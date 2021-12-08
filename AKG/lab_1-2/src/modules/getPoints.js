/* eslint-disable camelcase */
/* eslint-disable no-use-before-define */
import {
  mulVec,
  normMatr3x1,
  subMatr3x1,
  dotVec,
  interpolate,
  subVec,
} from './matrices';
import { drawPixel } from './drawingShapes';
import { getInterpolatedNormal } from './lights/getNormals';
import { getPixelColor } from './lights/getPixelColor';

function getZDepth(x, v1, xv21, yv1, yv21, xv31, yv31, zv21, zv31) {
  const xa = v1.x + xv21 * (yv1 / yv21);
  const xb = v1.x + xv31 * (yv1 / yv31);
  const za = v1.z + zv21 * (yv1 / yv21);
  const zb = v1.z + zv31 * (yv1 / yv31);
  return 1 / (za + (zb - za) * ((x - xa) / (xb - xa)));
}

export function drawFilledTriangleWithZBuffer(
  zBuffer,
  vArr,
  objNormals,
  image,
  color,
  scene,
) {
  const sortedVArr = vArr
    .map((e, i) => {
      e[3] = i;
      return e;
    })
    .sort((a, b) => a[1] - b[1]);

  const [v1, v2, v3] = sortedVArr.map((e) => ({
    x: e[0],
    y: e[1],
    z: e[2],
  }));

  // eslint-disable-next-line no-param-reassign
  objNormals = objNormals.map((_, i) => objNormals[sortedVArr[i][3]]);

  const x12 = interpolate(v1, v2);
  const x23 = interpolate(v2, v3);
  const x13 = interpolate(v1, v3);

  const x123 = x12.concat(x23);
  const m = Math.floor(x123.length / 2);

  const condition = x13[m] < x123[m];
  const xLeft = condition ? x13 : x123;
  const xRight = condition ? x123 : x13;

  const xv21 = v2.x - v1.x;
  const yv21 = v2.y - v1.y;
  const zv21 = v2.z - v1.z;

  const xv31 = v3.x - v1.x;
  const yv31 = v3.y - v1.y;
  const zv31 = v3.z - v1.z;

  const splitY = v2.y;

  for (let y = Math.floor(v1.y); y < Math.ceil(v3.y); ++y) {
    const lowerBound = Math.floor(xLeft[y - Math.floor(v1.y)]);
    const upperBound = Math.floor(xRight[y - Math.floor(v1.y)]);

    if (lowerBound >= upperBound) {
      // eslint-disable-next-line no-continue
      continue;
    }
    const yv1 = y - v1.y;

    const n2 = getInterpolatedNormal(
      objNormals[0],
      objNormals[2],
      v1,
      v3,
      v3.x,
      y,
      getZDepth(v3.x, v1, xv21, yv1, yv21, xv31, yv31, zv21, zv31),
    );

    let n1;
    const coordsForN1 = { x: 0, y, z: v1.z };

    if (y < splitY) {
      coordsForN1.x = get_2d_XtY(v1, v2, y);
      n1 = getInterpolatedNormal(
        objNormals[0],
        objNormals[1],
        v1,
        v2,
        v1.x,
        y,
        getZDepth(v1.x, v1, xv21, yv1, yv21, xv31, yv31, zv21, zv31),
      );
    } else {
      coordsForN1.x = get_2d_XtY(v2, v3, y);
      n1 = getInterpolatedNormal(
        objNormals[1],
        objNormals[2],
        v2,
        v3,
        v2.x,
        y,
        getZDepth(v2.x, v1, xv21, yv1, yv21, xv31, yv31, zv21, zv31),
      );
    }
    // HERE
    // l02_2d.
    // l02_3d.
    // l02_3d.
    const x02 = get_2d_XtY(v1, v3, y);
    const z02 = get_3d_ZtXY(v1, v3, y);
    const coordsForN2 = { x: x02, y, z: z02 };

    // const n02 = getInterpolatedNormal(x02, scanlineY, z02);

    for (let x = lowerBound; x < upperBound; ++x) {
      const zDepth = getZDepth(x, v1, xv21, yv1, yv21, xv31, yv31, zv21, zv31);

      if (x > -1 && y > -1 && zBuffer.length > x && zBuffer[x].length > y) {
        if (zBuffer[x][y] < zDepth) {
          // eslint-disable-next-line no-param-reassign
          zBuffer[x][y] = zDepth;

          const n = getInterpolatedNormal(
            n1,
            n2,
            coordsForN1,
            coordsForN2,
            x,
            y,
            zDepth,
          );
          drawPixel(image, getPixelColor(color, n, scene), x, y);
        }
      }
    }
  }
}

export function getTriangleColor(vectors, light) {
  const n = normMatr3x1(
    mulVec(
      subMatr3x1(vectors[2], vectors[0]),
      subMatr3x1(vectors[1], vectors[0]),
    ),
  );
  const degree = dotVec(n, light);
  let lightDegree = ((degree + 1) * 255) >>> 1;
  if (lightDegree > 255) {
    lightDegree = 255;
  }
  return [lightDegree, lightDegree, lightDegree, 255];
}

function get_2d_XtY(point0, point1, targetY) {
  let x = (targetY - point0.y) * (point1.x - point0.x);
  x /= point1.y - point0.y;
  x += point0.x;

  return x;
}

function get_3d_ZtXY(point0, point1, targetX, targetY) {
  const r = subVec(point1, point0);

  if (r.x !== 0.0) {
    const t = (targetX - point0.x) / r.x;
    return point0.z + t * r.z;
  }

  if (r.y !== 0.0) {
    const t = (targetY - point0.y) / r.y;
    return point0.z + t * r.z;
  }

  return NaN;
}
