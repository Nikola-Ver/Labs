/* eslint-disable no-use-before-define */
import { WIDTH } from './constants';

function line(image, color, from, to) {
  const dx = Math.abs(to.x - from.x);
  const dy = Math.abs(to.y - from.y);
  const sx = from.x < to.x ? 1 : -1;
  const sy = from.y < to.y ? 1 : -1;

  let err = dx - dy;
  let { x, y } = from;

  while (x !== to.x || y !== to.y) {
    const e2 = err << 1;

    if (e2 > dy * -1) {
      err -= dy;
      x += sx;
    }

    if (e2 < dx) {
      err += dx;
      y += sy;
    }
    if (x >= 0 && y >= 0) {
      drawPixel(image, color, x, y);
    }
  }
}

export function drawPixel(image, color, x, y) {
  const { data } = image;
  const BYTE_PER_COLOR = 4;

  for (let i = 0; i < 4; i++) {
    data[(y * WIDTH + x) * BYTE_PER_COLOR + i] = color[i];
  }
}

export function grid(image, color, points2d) {
  const { length } = points2d;
  for (let i = 0; i < length - 1; ++i) {
    const from = points2d[i];
    const to = points2d[i + 1];
    line(
      image,
      color,
      { x: from[0] ^ 0, y: from[1] ^ 0 },
      { x: to[0] ^ 0, y: to[1] ^ 0 },
    );
  }
  const from = points2d[length - 1];
  const to = points2d[0];
  line(
    image,
    color,
    { x: from[0] ^ 0, y: from[1] ^ 0 },
    { x: to[0] ^ 0, y: to[1] ^ 0 },
  );
}

export function filledTriangle(image, color, vArr) {
  const [v1, v2, v3] = vArr
    .sort((a, b) => a[1] - b[1])
    .map((e) => ({ x: e[0] ^ 0, y: e[1] ^ 0 }));
  if (v2.y === v3.y) {
    fillBottomFlatTriangle(image, color, v1, v2, v3);
  } else if (v1.y === v2.y) {
    fillTopFlatTriangle(image, color, v1, v2, v3);
  } else {
    const v4 = {
      x: v1.x + ((v2.y - v1.y) / (v3.y - v1.y)) * (v3.x - v1.x),
      y: v2.y,
    };
    fillBottomFlatTriangle(image, color, v1, v2, v4);
    fillTopFlatTriangle(image, color, v2, v4, v3);
  }
}

function fillBottomFlatTriangle(image, color, v1, v2, v3) {
  const invslope1 = (v2.x - v1.x) / (v2.y - v1.y);
  const invslope2 = (v3.x - v1.x) / (v3.y - v1.y);

  let curx1 = v1.x;
  let curx2 = v1.x;

  for (let scanlineY = v1.y; scanlineY <= v2.y; ++scanlineY) {
    line(
      image,
      color,
      { x: curx1 ^ 0, y: scanlineY },
      { x: curx2 ^ 0, y: scanlineY },
    );
    curx1 += invslope1;
    curx2 += invslope2;
  }
}

function fillTopFlatTriangle(image, color, v1, v2, v3) {
  const invslope1 = (v3.x - v1.x) / (v3.y - v1.y);
  const invslope2 = (v3.x - v2.x) / (v3.y - v2.y);

  let curx1 = v3.x;
  let curx2 = v3.x;

  for (let scanlineY = v3.y; scanlineY > v1.y; --scanlineY) {
    line(
      image,
      color,
      { x: curx1 ^ 0, y: scanlineY },
      { x: curx2 ^ 0, y: scanlineY },
    );
    curx1 -= invslope1;
    curx2 -= invslope2;
  }
}
