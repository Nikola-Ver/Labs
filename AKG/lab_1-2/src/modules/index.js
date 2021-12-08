import { HEIGHT, WIDTH } from './constants';
import { drawObj } from './drawing';
import { get3dModel } from './fileParser3d';

const canvas = document.getElementById('canvas');
const context = canvas.getContext('2d');
const fileInput = document.getElementById('file_input');

const offsetsVal = {
  scale: 5,
  rotate: 0.25,
  translate: 25,
  eye: 5,
  zNear: 5,
  zFar: 5,
  light: 0.1,
};

const keys = {
  scale: 0,
  rotate: [0, 0, 0],
  translate: [0, 0, 0],
  light: [0, 0, 0],
  zNear: 0,
  zFar: 0,
  camera: false,
};

const scene = {
  light: [0, 0, -1],
  eye: [0, 0, 2000],
  target: [0, 0, 0],
  up: [0, 1, 0],
  xMin: 0,
  yMin: 0,
  zNear: HEIGHT,
  zFar: 1000,
  w: WIDTH,
  h: HEIGHT,
};

let obj = {
  scale: [25, 25, 25],
  rotate: [0, 0, 0],
  translate: [0, 0, 0],
};

canvas.width = WIDTH;
canvas.height = HEIGHT;

function setNewObj(newObj) {
  obj = Object.assign(obj, get3dModel(newObj));
  const getIndex = (i) => (i > 0 ? i - 1 : i);

  // eslint-disable-next-line no-param-reassign
  const objVertices = obj.f?.map((points) => {
    const vertices = points.map((e) => {
      const vertex = obj.v.at(getIndex(e.v));
      // eslint-disable-next-line no-debugger
      return vertex;
    });
    return vertices;
  });

  const objNormals = obj.f?.map((points) => {
    const vertices = points.map((e) => {
      const vn = obj.vn.at(getIndex(e.vn));
      vn.push(1);
      // eslint-disable-next-line no-debugger
      return vn;
    });
    return vertices;
  });

  drawObj(context, obj, scene, objVertices, objNormals);
  const tick = () => {
    let needRerender = false;

    keys.light.forEach((e, i) => {
      if (e !== 0) {
        scene.light[i] += e * offsetsVal.light;
        needRerender = true;
      }
    });

    keys.rotate.forEach((e, i) => {
      if (e !== 0) {
        obj.rotate[i] += e * offsetsVal.rotate;
        needRerender = true;
      }
    });

    keys.translate.forEach((e, i) => {
      if (e !== 0) {
        if (keys.camera) {
          scene.eye[i] += e * offsetsVal.eye;
        } else {
          obj.translate[i] += e * offsetsVal.translate;
        }
        needRerender = true;
      }
    });

    if (keys.scale !== 0) {
      obj.scale = obj.scale.map((e) => e + keys.scale * offsetsVal.scale);
      needRerender = true;
    }

    if (keys.zNear !== 0) {
      scene.zNear += keys.zNear * offsetsVal.zNear;
      needRerender = true;
    }

    if (keys.zFar !== 0) {
      scene.zFar += keys.zFar * offsetsVal.zFar;
      needRerender = true;
    }

    if (needRerender) {
      drawObj(context, obj, scene, objVertices, objNormals);
    }
    requestAnimationFrame(tick);
  };
  requestAnimationFrame(tick);
}

fileInput.onchange = function onChangeFile() {
  const fr = new FileReader();
  fr.onload = function onLoadFile() {
    setNewObj(this.result);
  };
  fr.readAsText(this.files[0]);
};

document.onkeydown = (e) => {
  if (e.ctrlKey && e.key === 'Enter') {
    fileInput.click();
  } else if (e.shiftKey) {
    if (e.key === 'X') {
      keys.rotate[0] = 1;
    } else if (e.key === 'Y') {
      keys.rotate[1] = 1;
    } else if (e.key === 'Z') {
      keys.rotate[2] = 1;
    } else if (e.key === 'N') {
      keys.zNear = -1;
    } else if (e.key === 'F') {
      keys.zFar = -1;
    }
  } else if (e.key === 'x') {
    keys.rotate[0] = -1;
  } else if (e.key === 'y') {
    keys.rotate[1] = -1;
  } else if (e.key === 'z') {
    keys.rotate[2] = -1;
  } else if (e.key === 'd') {
    keys.translate[0] = -1;
  } else if (e.key === 'a') {
    keys.translate[0] = 1;
  } else if (e.key === 's') {
    keys.translate[1] = -1;
  } else if (e.key === 'w') {
    keys.translate[1] = 1;
  } else if (e.key === 'q') {
    keys.translate[2] = -1;
  } else if (e.key === 'e') {
    keys.translate[2] = 1;
  } else if (e.key === '[') {
    keys.scale = -1;
  } else if (e.key === ']') {
    keys.scale = 1;
  } else if (e.key === 'n') {
    keys.zNear = 1;
  } else if (e.key === 'f') {
    keys.zFar = 1;
  } else if (e.key === 'c') {
    keys.camera = !keys.camera;
  } else if (e.key === '6') {
    keys.light[0] = 1;
  } else if (e.key === '4') {
    keys.light[0] = -1;
  } else if (e.key === '8') {
    keys.light[1] = -1;
  } else if (e.key === '2') {
    keys.light[1] = 1;
  } else if (e.key === '7') {
    keys.light[2] = -1;
  } else if (e.key === '9') {
    keys.light[2] = 1;
  }
};

document.onkeyup = () => {
  keys.scale = 0;
  keys.zNear = 0;
  keys.zFar = 0;
  keys.rotate = keys.rotate.map(() => 0);
  keys.light = keys.light.map(() => 0);
  keys.translate = keys.translate.map(() => 0);
};
