// export const Sharpen3x3 = [
//   [0, -1, 0],
//   [-1, 5, -1],
//   [0, -1, 0],
// ];
export const Sobel3x3Horizontal = [
  [-1, 0, 1],
  [-2, 0, 2],
  [-1, 0, 1],
];
export const Sobel3x3Vertical = [
  [1, 2, 1],
  [0, 0, 0],
  [-1, -2, -1],
];

function createX_X_Matrix(size) {
  let result = new Array(size);
  result = result.fill([]).map(e => new Array(size).fill(undefined));
  return result;
}

export function GetBoxBlurMatrix(size) {
  const matrix = createX_X_Matrix(size);
  let sum = 0;
  const offset = Math.floor((size - 1) / 2);

  for (let y = -offset; y <= offset; y++) {
    for (let x = -offset; x <= offset; x++) {
      matrix[y + offset][x + offset] = 1;
      sum += matrix[y + offset][x + offset];
    }
  }
  sum = 1 / sum;

  return { matrix, sum };
}
// export function GetMotionBlurMatrix(size) {
//   const matrix = createX_X_Matrix(size);
//   let sum = 0;
//   const offset = Math.floor((size - 1) / 2);

//   for (let y = -offset; y <= offset; y++) {
//     for (let x = -offset; x <= offset; x++) {
//       if (x === y) {
//         matrix[y + offset][x + offset] = 1;
//         sum += matrix[y + offset][x + offset];
//       }
//     }
//   }
//   sum = 1 / sum;
//   return { matrix, sum };
// }
export function GetGaussianMatrix(sigma) {
  let size = Math.ceil(6 * sigma);
  size = (size & 1) === 0 ? size + 1 : size;
  const matrix = createX_X_Matrix(size);
  const offset = Math.floor((size - 1) / 2);

  let sum = 0;
  for (let y = -offset; y <= offset; y++) {
    for (let x = -offset; x <= offset; x++) {
      matrix[y + offset][x + offset] =
        (1 / (2 * Math.PI * sigma * sigma)) *
        Math.exp(-(x * x + y * y) / (2 * sigma * sigma));
      sum += matrix[y + offset][x + offset];
    }
  }
  sum = 1 / sum;
  return { matrix, sum };
}
