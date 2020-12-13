const express = require("express");
const path = require("path");
const fse = require("fs-extra");
const fs = require("fs").promises;
const fileupload = require("express-fileupload");

const server = express();
const PORT = 3000;
server.use(fileupload());

server
  .get("*", async (req, res) => {
    if (/\./.exec(req.path)) {
      const absolutePath = `${__dirname}/${req.path}`;
      try {
        await fs.access(absolutePath);
        res.sendFile(absolutePath);
      } catch (err) {
        res.status(404).send("File not found");
      }
    } else {
      res.send(await getFiles(`${__dirname}/${req.path}`));
    }
  })

  .put("*", async (req, res) => {
    if (req.files) {
      const path = req.path.replace(/\/[^/]*$/gi, "");
      const fileName = "/" + req.path.split("/").pop();
      const file = req.files.file.data;

      await fse.ensureDir(`${__dirname}${path}`);
      fs.writeFile(`${__dirname}${path}${fileName}`, file);

      res.send("File added");
    } else {
      res.status(400).send("Bad request");
    }
  })

  .delete("*", async (req, res) => {
    const path = req.path;
    try {
      await fs.unlink(__dirname + path);
      res.status(200).send("File deleted");
    } catch (err) {
      res.status(404).send("File not found");
    }
  })

  .post("*", async (req, res) => {
    const path = "/" + req.headers["copy-from"];
    if (path) {
      const oldPath = __dirname + req.path;
      const newPath = __dirname + path;
      const newPathDir = path.replace(/\/[^/]*$/gi, "");
      await fse.ensureDir(__dirname + newPathDir);

      try {
        await fs.copyFile(oldPath, newPath);
        res.status(200).send("File copied");
      } catch (err) {
        res.status(404).send("File not found");
      }
    } else {
      res.status(400).send("Bad request");
    }
  })

  .listen(PORT, () => console.info(`Сервер запущен http://localhost:${PORT}`));

async function getFiles(dir) {
  const directiorys = await fs.readdir(dir, { withFileTypes: true });
  return (
    await Promise.all(
      directiorys.map((directiory) => {
        const res = path.resolve(dir, directiory.name);
        return directiory.isDirectory() ? getFiles(res) : res;
      })
    )
  ).flat(Infinity);
}
