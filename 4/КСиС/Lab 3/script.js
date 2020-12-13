(async () => {
var ip = require("ip");
console.dir ( ip.address() );
  const dgram = require("dgram"),
    net = require("net"),
    os = require("os"),
    readline = require("readline");

  const IPV4 = 4,
    PORT = 3000,
    HISTORY_REQUEST = "HISTORY_REQUEST",
    HISTORY_RESPONSE = "HISTORY_RESPONSE",
    MESSAGE = "MESSAGE";
  let history = [];
  const TCPSockets = [];

  const rl = readline.createInterface({
    input: process.stdin,
  });

  function readln(message = "") {
    return new Promise((resolve, reject) => {
      rl.question(message, (input) => {
        resolve(input);
      });
    });
  }

  console.info("Введите ваше имя: ");
  const userName = await readln();
  console.info("\nНачало чата: ");

  const UDP = dgram.createSocket({ type: "udp4", reuseAddr: true });
  const TCP = net.createServer();

  const interfaces = Object.values(os.networkInterfaces()).flat();

  const { address: address, netmask: netmask } = interfaces.find(
    (interface) => interface.family === "IPv4" && !interface.internal
  );

  const netmaskArray = netmask.split(".");
  const broadcastAddress = address
    .split(".")
    .map((ipPart, i) => (netmaskArray[i] === "255" ? ipPart : "255"))
    .join(".");

  function beginChat(TCPClient) {
    // Отправляем broadcast
    const { port: TCPPort } = TCP.address();
    UDP.send(JSON.stringify({ userName, TCPPort }), PORT, broadcastAddress);

    // Начало общения
    Promise.resolve().then(function resolver() {
      return readln()
        .then((message) => {
          TCPSockets.forEach((socket) => {
            socket.write(JSON.stringify({ type: MESSAGE, userName, message }));
            history.push(
              `\nIP: ${TCPClient.address().address} \nВремя: ${String(
                new Date()
              ).match(
                /([0-9]?[0-9]\:){2}[0-9]?[0-9]/g
              )}\n${userName}: ${message}\n`
            );
          });
        })
        .then(resolver);
    });
  }

  UDP.bind(PORT);

  UDP.on("listening", () => {
    UDP.setBroadcast(true);
  });

  TCP.listen(() => beginChat(TCP));
  TCP.on("connection", (socket) => {
    if (TCPSockets.length === 0) {
      socket.write(JSON.stringify({ type: HISTORY_REQUEST }));
    }
    newConnection(socket, socket.remoteAddress.slice(7), "");
  });

  function processMessage(data, IPAddress, socket) {
    const { type, userName: name, message } = JSON.parse(data);
    if (type === HISTORY_REQUEST) {
      socket.write(JSON.stringify({ type: HISTORY_RESPONSE, history }));
    } else if (type === HISTORY_RESPONSE) {
      const { history } = JSON.parse(data);
      history.forEach((message) => console.log(message));
    } else if (type === MESSAGE) {
      const msgStr = `\nIP: ${IPAddress} \nВремя: ${String(new Date()).match(
        /([0-9]?[0-9]\:){2}[0-9]?[0-9]/g
      )}\n${name}: ${message}\n`;
      console.info(msgStr);
      history.push(msgStr);
    }
  }

  function newConnection(TCPSocket, IPAddress, Name) {
    TCPSocket.setEncoding("utf8");
    TCPSocket.on("data", (data) => {
      processMessage(data, IPAddress, TCPSocket);
    });
    TCPSockets.push(TCPSocket);
    TCPSocket.on("error", (TCPSocket) => {
      console.info("Пользователь " + Name + " вышел из чата");
      const socketIndex = TCPSockets.findIndex(
        (arraySocket) => arraySocket === TCPSocket
      );
      TCPSockets.splice(socketIndex, 1);
    });
  }

  UDP.on("message", (msg, userInfo) => {
    const msgObject = JSON.parse(msg);
    if (userInfo.address !== address) {
      const socket = new net.Socket();

      socket.connect({
        port: msgObject.TCPPort,
        host: userInfo.address,
        family: IPV4,
      });

      // Создаем TCP соединение
      socket.on("connect", () => {
        console.log(
          "Подключился новый пользователь " + msgObject.userName + "."
        );
        newConnection(socket, socket.remoteAddress, msgObject.userName);
      });
    }
  });
})();
