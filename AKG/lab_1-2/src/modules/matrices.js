/* eslint-disable no-use-before-define */
export function translate([x, y, z]) {
  return [
    [1, 0, 0, x],
    [0, 1, 0, y],
    [0, 0, 1, z],
    [0, 0, 0, 1],
  ];
}

export function scale([x, y, z]) {
  return [
    [x, 0, 0, 0],
    [0, y, 0, 0],
    [0, 0, z, 0],
    [0, 0, 0, 1],
  ];
}

export function xRotate(angle) {
  return [
    [1, 0, 0, 0],
    [0, Math.cos(angle), -Math.sin(angle), 0],
    [0, Math.sin(angle), Math.cos(angle), 0],
    [0, 0, 0, 1],
  ];
}

export function yRotate(angle) {
  return [
    [Math.cos(angle), 0, Math.sin(angle), 0],
    [0, 1, 0, 0],
    [-Math.sin(angle), 0, Math.cos(angle), 0],
    [0, 0, 0, 1],
  ];
}

export function zRotate(angle) {
  return [
    [Math.cos(angle), -Math.sin(angle), 0, 0],
    [Math.sin(angle), Math.cos(angle), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
  ];
}

export function view({ eye, target, up }) {
  const zAxis = normMatr3x1(subMatr3x1(eye, target));
  const xAxis = normMatr3x1(mulVec(up, zAxis));
  const yAxis = up;

  return [
    [xAxis[0], xAxis[1], xAxis[2], -dotVec(xAxis, eye)],
    [yAxis[0], yAxis[1], yAxis[2], -dotVec(yAxis, eye)],
    [zAxis[0], zAxis[1], zAxis[2], -dotVec(zAxis, eye)],
    [0, 0, 0, 1],
  ];
}

export function projection({ w, h, zNear, zFar }) {
  return [
    [(2 * zNear) / w, 0, 0, 0],
    [0, (2 * zNear) / h, 0, 0],
    [0, 0, zFar / (zNear - zFar), (zNear * zFar) / (zNear - zFar)],
    [0, 0, -1, 0],
  ];
}

export function viewport({ w, h, xMin, yMin }) {
  return [
    [w / 2, 0, 0, xMin + w / 2],
    [0, -(h / 2), 0, yMin + h / 2],
    [0, 0, 1, 0],
    [0, 0, 0, 1],
  ];
}

export function mulMatr4x4(mat1, mat2) {
  const [
    [a11, a12, a13, a14],
    [a21, a22, a23, a24],
    [a31, a32, a33, a34],
    [a41, a42, a43, a44],
  ] = mat1;

  const [
    [b11, b12, b13, b14],
    [b21, b22, b23, b24],
    [b31, b32, b33, b34],
    [b41, b42, b43, b44],
  ] = mat2;

  return [
    [
      a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41,
      a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42,
      a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43,
      a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44,
    ],
    [
      a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41,
      a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42,
      a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43,
      a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44,
    ],
    [
      a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41,
      a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42,
      a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43,
      a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44,
    ],
    [
      a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41,
      a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42,
      a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43,
      a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44,
    ],
  ];
}

export function subMatr4x4(mat1, mat2) {
  const [
    [a11, a12, a13, a14],
    [a21, a22, a23, a24],
    [a31, a32, a33, a34],
    [a41, a42, a43, a44],
  ] = mat1;

  const [
    [b11, b12, b13, b14],
    [b21, b22, b23, b24],
    [b31, b32, b33, b34],
    [b41, b42, b43, b44],
  ] = mat2;

  return [
    [a11 - b11, a12 - b12, a13 - b13, a14 - b14],
    [a21 - b21, a22 - b22, a23 - b23, a24 - b24],
    [a31 - b31, a32 - b32, a33 - b33, a34 - b34],
    [a41 - b41, a42 - b42, a43 - b43, a44 - b44],
  ];
}

export function subMatr3x1(mat1, mat2) {
  const [a11, a21, a31] = mat1;
  const [b11, b21, b31] = mat2;
  return [a11 - b11, a21 - b21, a31 - b31];
}

export function mulMatr4x4And4x1(mat1, mat2) {
  const [
    [a11, a12, a13, a14],
    [a21, a22, a23, a24],
    [a31, a32, a33, a34],
    [a41, a42, a43, a44],
  ] = mat1;
  const [b11, b21, b31, b41] = mat2;

  return [
    a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41,
    a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41,
    a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41,
    a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41,
  ];
}

export function divMatr3x1AndDig(mat, div) {
  const [a11, a21, a31] = mat;
  return [a11 / div, a21 / div, a31 / div];
}

export function divMatrByW(mat) {
  const [a11, a21, a31, w] = mat;
  return [a11 / w, a21 / w, a31 / w, 1];
}

export function normMatr3x1(mat) {
  let [a11, a21, a31] = mat;
  a11 = Math.abs(a11);
  a21 = Math.abs(a21);
  a31 = Math.abs(a31);
  // eslint-disable-next-line no-nested-ternary
  const div = a11 > a21 ? (a11 > a31 ? a11 : a31) : a21 > a31 ? a21 : a31;
  return divMatr3x1AndDig(mat, div);
}

export function mulVec(vec1, vec2) {
  const [ax, ay, az] = vec1;
  const [bx, by, bz] = vec2;
  return [ay * bz - az * by, az * bx - ax * bz, ax * by - ay * bx];
}

export function dotVec(vec1, vec2) {
  const [ax, ay, az] = vec1;
  const [bx, by, bz] = vec2;
  return ax * bx + ay * by + az * bz;
}

export function interpolate(vec1, vec2) {
  const values = [];
  const a = (vec2.x - vec1.x) / (vec2.y - vec1.y);
  let d = vec1.x;
  for (let i = Math.floor(vec1.y); i < Math.floor(vec2.y); ++i) {
    values.push(d);
    d += a;
  }
  return values;
}

export function mulMatWithCoef(mat, coef) {
  return mat.map((e) => (e.length ? mulMatWithCoef(e, coef) : e * coef));
}

export function sumVec(vec1, vec2) {
  return vec1.map((e, i) => e + vec2[i]);
}

export function subVec(vec1, vec2) {
  if (Array.isArray(vec1)) {
    return vec1.map((e, i) => e - vec2[i]);
  }
  if (vec2.z) {
    return { x: vec1.x - vec2.x, y: vec1.y - vec2.y, z: vec1?.z - vec2?.z };
  }
  return { x: vec1.x - vec2.x, y: vec1.y - vec2.y };
}
