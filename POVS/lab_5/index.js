// const { clipboard, nativeImage } = require('electron')
const { com, rate, width, height } = require('./config.json');

const SerialPort = require('serialport');
const port = new SerialPort(com, { baudRate: rate });
const decoder = new TextDecoder("utf-8");

const fs = require('fs');
const { createCanvas } = require('canvas');
const canvas = createCanvas(width, height);
const ctx = canvas.getContext('2d');

port.on('error', function (err) {
  console.log('Error: ', err.message);
});

port.on('data', function (data) {
    const str = decoder.decode(data);
    const [x, y, radius, color] = str.match(/[0-9]+/g);

    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.fill();
    
    fs.writeFileSync('img.png', canvas.toBuffer());

    // const image = nativeImage.createFromPath('./img.png')
    // clipboard.clear()
    // clipboard.writeImage(image)
});
