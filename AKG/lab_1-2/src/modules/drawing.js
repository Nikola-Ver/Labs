import { HEIGHT, WIDTH } from './constants';
import { drawFilledTriangleWithZBuffer } from './getPoints';
import {
  mulMatr4x4,
  mulMatr4x4And4x1,
  divMatrByW,
  projection,
  scale,
  translate,
  view,
  viewport,
  xRotate,
  yRotate,
  zRotate,
} from './matrices';

export function drawObj(context, obj, scene, objVertices, objNormals) {
  let coef = projection(scene);
  coef = mulMatr4x4(coef, view(scene));
  let coefNormals = translate(obj.translate);
  coefNormals = mulMatr4x4(coefNormals, zRotate(obj.rotate[2]));
  coefNormals = mulMatr4x4(coefNormals, yRotate(obj.rotate[1]));
  coefNormals = mulMatr4x4(coefNormals, xRotate(obj.rotate[0]));
  coefNormals = mulMatr4x4(coefNormals, scale(obj.scale));
  coef = mulMatr4x4(coef, coefNormals);

  const viewPortMatrix = viewport(scene);

  const readyObjVertices = objVertices.map((vertices) =>
    new Array(vertices.length)
      .fill([])
      .map((_, i) =>
        mulMatr4x4And4x1(
          viewPortMatrix,
          divMatrByW(mulMatr4x4And4x1(coef, vertices[i])),
        ),
      ),
  );

  const readyObjNormals = objNormals.map((normals) =>
    new Array(normals.length)
      .fill([])
      .map((_, i) => divMatrByW(mulMatr4x4And4x1(coefNormals, normals[i]))),
  );

  // console.log(readyObjNormals);

  // const readyObjNormals = readyObjVertices.map((_, i) =>
  //   objNormals[i].map((normal, i1) =>
  //     normal.map(
  //       (e, i2) => (e * objVertices[i][i1][i2] /  readyObjVertices[i][i1][i2]),
  //     ),
  //   ),
  // );

  const image = context.createImageData(WIDTH, HEIGHT);
  const zBuffer = new Array(WIDTH)
    .fill(null)
    .map(() => new Array(HEIGHT).fill(0));

  const color = [0, 0, 0, 255];

  readyObjVertices.forEach((vertices, i) => {
    drawFilledTriangleWithZBuffer(
      zBuffer,
      vertices,
      objNormals[i],
      // readyObjNormals[i],
      image,
      color,
      scene,
    );
  });

  context.putImageData(image, 0, 0);
}
