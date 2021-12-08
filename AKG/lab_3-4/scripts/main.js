'use strict';

import { Model } from './model.js';
import * as Resources from './resources.js';
import { Constants } from './constants.js';
import { Game } from './game.js';
import * as Util from './utils.js';

window.onload = () => {
  new Game().start();
};

function setNewObj(newObj) {
  // Load OBJ file line by line
  newObj = newObj.replace(/  +/g, ' ');
  const lines = newObj.split('\n');
  let positions = [];
  let texCoords = [];
  let normals = [];
  let indices = [];

  for (const line of lines) {
    const tokens = line.replace('\r', '').split(' ');
    switch (tokens[0]) {
      case 'v':
        let v = [];
        for (let i = 0; i < 3; i++) v.push(parseFloat(tokens[i + 1]));
        positions.push(v);
        break;

      case 'vt':
        let tc = [];
        for (let i = 0; i < 2; i++) tc.push(parseFloat(tokens[i + 1]));
        texCoords.push(tc);
        break;

      case 'vn':
        let vn = [];
        for (let i = 0; i < 3; i++) vn.push(parseFloat(tokens[i + 1]));
        normals.push(vn);
        break;

      case 'f': {
        if (tokens.length > 4) {
          const newFArray = [];
          const polToTriangle = getTrianglesFromPolygon(tokens.length - 1);
          polToTriangle?.forEach(positions => {
            newFArray.push([
              tokens[positions[0] + 1],
              tokens[positions[1] + 1],
              tokens[positions[2] + 1],
            ]);
          });

          newFArray.forEach(arrayWithStrings => {
            let f = [];
            arrayWithStrings.forEach(_string => {
              let v = [];
              const da = _string.split('/');
              da.forEach(valueToParse => {
                const value = parseInt(valueToParse);
                if (isNaN(value)) {
                }
                v.push(value);
              });
              f.push(v);
            });

            indices.push(f);
          });
          break;
        } else {
          let f = [];
          for (let i = 0; i < 3; i++) {
            let v = [];
            for (let j = 0; j < 3; j++)
              v.push(parseInt(tokens[i + 1].split('/')[j]));
            f.push(v);
          }
          indices.push(f);
          break;
        }
      }
    }
  }
  Constants.loadedResources++;
  const newModel = new Model(positions, texCoords, normals, indices);
  Resources.models['man'] = newModel;
}

function getTrianglesFromPolygon(numOfCorners) {
  const res = [];
  let arrNum = new Array(numOfCorners).fill(0).map((_, i) => i);
  let currentPos = 0;
  for (let i = 0; i < numOfCorners - 2; ++i) {
    const { length } = arrNum;
    res.push([
      arrNum[currentPos % length],
      arrNum[(currentPos + 1) % length],
      arrNum[(currentPos + 2) % length],
    ]);
    currentPos = (currentPos + 1) % length;
    // eslint-disable-next-line no-loop-func
    arrNum = arrNum.filter((_, pos) => pos !== currentPos);
  }
  return res;
}
const tmpCvs = document.createElement('canvas');
const tmpGfx = tmpCvs.getContext('2d');

const fileInput = document.getElementById('file_input');
fileInput.onchange = function () {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    setNewObj(this.result);
  };
  fr.readAsText(this.files[0]);
};

function createImage(imgFile, name) {
  // const imageURL = Resources.textures[key][0];
  // const imageWidth = Resources.textures[key][1][0];
  // const imageHeight = Resources.textures[key][1][1];

  let image = new Image();
  image.src = imgFile;
  image.crossOrigin = 'Anonymous';

  image.onload = () => {
    console.dir(image);
    const imageWidth = image.width;
    const imageHeight = image.height;
    // document.body.appendChild(image);

    tmpCvs.setAttribute('width', imageWidth + 'px');
    tmpCvs.setAttribute('height', imageHeight + 'px');
    // // Loading textures.

    tmpGfx.drawImage(image, 0, 0, imageWidth, imageHeight);

    image = tmpGfx.getImageData(0, 0, imageWidth, imageHeight);
    image = Util.convertImageDataToBitmap(image, imageWidth, imageHeight);

    Constants.loadedResources++;
    Resources.textures[name] = image;

    // return image;
  };
}

function setDiffuse(image) {
  createImage(image, 'diffuse');
}

function setNormals(image) {
  createImage(image, 'normals');
}

function setSpecular(image) {
  createImage(image, 'specular');
}

function setBloom(image) {
  createImage(image, 'bloom');
}

const fileInputDiffuse = document.getElementById('file_input_diffuse');
fileInputDiffuse.onchange = function () {
  const fr = new FileReader();

  fr.onload = function onLoadFile() {
    setDiffuse(this.result);
  };
  fr.readAsDataURL(this.files[0]);
};

const fileInputNormals = document.getElementById('file_input_normals');
fileInputNormals.onchange = function () {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    setNormals(this.result);
  };
  fr.readAsDataURL(this.files[0]);
};

const fileInputSpecular = document.getElementById('file_input_specular');
fileInputSpecular.onchange = function () {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    setSpecular(this.result);
  };
  fr.readAsDataURL(this.files[0]);
};

const fileInputBloom = document.getElementById('file_input_bloom');
fileInputBloom.onchange = function () {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    setBloom(this.result);
  };
  fr.readAsDataURL(this.files[0]);
};
