using System;
using System.Net;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using System.Text;

public class Tracert
{
    public static void Main(string[] argv)
    {
        Console.Write("Максимальное количество прыжков: ");
        int ttl = Convert.ToInt32(Console.ReadLine());
        Console.Write("Количество попыток: ");
        int countTry = Convert.ToInt32(Console.ReadLine());
        Console.Write("Максимальное время ожидания в миллисекундах: ");
        int waitingTime = Convert.ToInt32(Console.ReadLine());
        Console.Write("Трассировка: ");
        string address = Console.ReadLine();

        byte[] data = new byte[1024];
        int recv, timestart, timestop;
        Socket host = new Socket(AddressFamily.InterNetwork, SocketType.Raw, ProtocolType.Icmp);
        bool flagCorrectEnter = false;
        while (!flagCorrectEnter)
        {
            try
            {
                IPHostEntry temp = Dns.Resolve(address);
                flagCorrectEnter = true;
            }
            catch (Exception)
            {
                Console.Write("\nБыл введен неверный адрес, повторите попытку: ");
                address = Console.ReadLine();
            };
        };
        IPHostEntry iphe = Dns.Resolve(address);
        IPEndPoint iep = new IPEndPoint(iphe.AddressList[0], 0);
        EndPoint ep = (EndPoint)iep;
        ICMP packet = new ICMP();

        packet.Type = 0x08;
        packet.Code = 0x00;
        packet.Checksum = 0;
        Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 0, 2);
        Buffer.BlockCopy(BitConverter.GetBytes(1), 0, packet.Message, 2, 2);
        data = Encoding.ASCII.GetBytes("test packet");
        Buffer.BlockCopy(data, 0, packet.Message, 4, data.Length);
        packet.MessageSize = data.Length + 4;
        int packetsize = packet.MessageSize + 4;

        UInt16 chcksum = packet.getChecksum();
        packet.Checksum = chcksum;

        host.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, waitingTime);

        try
        {
            if (System.Net.Dns.GetHostEntry(address).AddressList[0].ToString() == address)
                if (Dns.GetHostEntry(address).HostName == address)
                    Console.WriteLine("\nТрассировка маршрута к {0}:\n", address);
                else
                    Console.WriteLine("\nТрассировка маршрута к {0} [{1}]:\n", Dns.GetHostEntry(address).HostName, address);
            else
                Console.WriteLine("\nТрассировка маршрута к {0} [{1}]:\n", address, System.Net.Dns.GetHostEntry(address).AddressList[0].ToString());
        }
        catch (Exception)
        {
            Console.WriteLine("\nТрассировка маршрута к {0}:\n", address);
        };

        int badcount = 0;
        bool flagInProgres = true;
        for (int i = 1; i <= ttl && flagInProgres; i++)
        {
            string currentIp = "";
            Console.Write("{0,3} ", i);
            for (int j = 0; j < countTry; j++)
            {
                host.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IpTimeToLive, i);
                timestart = Environment.TickCount;
                host.SendTo(packet.getBytes(), packetsize, SocketFlags.None, iep);
                try
                {
                    data = new byte[1024];
                    recv = host.ReceiveFrom(data, ref ep);
                    timestop = Environment.TickCount;
                    if (currentIp.Length == 0)
                        currentIp = Regex.Replace(ep.ToString(), ":.*", "");
                    else
                        if (currentIp != Regex.Replace(ep.ToString(), ":.*", ""))
                        currentIp += " Смена ip адреса на " + (j + 1).ToString() + " попытки: " + Regex.Replace(ep.ToString(), ":.*", "");
                    ICMP response = new ICMP(data, recv);
                    if (response.Type == 11)
                        if (timestop == timestart)
                            Console.Write("    1 мс", timestop - timestart);
                        else
                            Console.Write("{0,5} мс", timestop - timestart);
                    if (response.Type == 0)
                    {
                        if (timestop == timestart)
                            Console.Write("    1 мс", timestop - timestart);
                        else
                            Console.Write("{0,5} мс", timestop - timestart);
                        flagInProgres = false;
                    }
                    badcount = 0;
                }
                catch (SocketException)
                {
                    Console.Write("    *   ");
                    badcount++;
                }
            }
            if (badcount >= countTry)
            {
                Console.WriteLine("   Превышен интервал ожидания для запроса.");
                if (badcount == countTry * 5)
                {
                    Console.WriteLine("\nНевозможно связаться с удаленным хостом.");
                    flagInProgres = false;
                }
            }
            else
            {
                try
                {
                    string[] masStr = currentIp.Split(' ');
                    for (int k = 0; k < masStr.Length; k++)
                        Console.Write("   {0} [{1}]", Dns.GetHostEntry(masStr[k]).HostName, masStr[k]);
                }
                catch (Exception)
                {
                    string[] masStr = currentIp.Split(' ');
                    for (int k = 0; k < masStr.Length; k++)
                        Console.Write("   {0}", masStr[k]);
                };
                Console.WriteLine();
            }
        }

        host.Close();
        Console.WriteLine("\nТрассировка завершина.\n");
        Console.Read();
    }
}

class ICMP
{
    public byte Type;
    public byte Code;
    public UInt16 Checksum;
    public int MessageSize;
    public byte[] Message = new byte[1024];

    public ICMP()
    {
    }

    public ICMP(byte[] data, int size)
    {
        Type = data[20];
        Code = data[21];
        Checksum = BitConverter.ToUInt16(data, 22);
        MessageSize = size - 24;
        Buffer.BlockCopy(data, 24, Message, 0, MessageSize);
    }

    public byte[] getBytes()
    {
        byte[] data = new byte[MessageSize + 9];
        Buffer.BlockCopy(BitConverter.GetBytes(Type), 0, data, 0, 1);
        Buffer.BlockCopy(BitConverter.GetBytes(Code), 0, data, 1, 1);
        Buffer.BlockCopy(BitConverter.GetBytes(Checksum), 0, data, 2, 2);
        Buffer.BlockCopy(Message, 0, data, 4, MessageSize);
        return data;
    }

    public UInt16 getChecksum()
    {
        UInt32 chcksm = 0;
        byte[] data = getBytes();
        int packetsize = MessageSize + 8;
        int index = 0;

        while (index < packetsize)
        {
            chcksm += Convert.ToUInt32(BitConverter.ToUInt16(data, index));
            index += 2;
        }
        chcksm = (chcksm >> 16) + (chcksm & 0xffff);
        chcksm += (chcksm >> 16);
        return (UInt16)(~chcksm);
    }
}