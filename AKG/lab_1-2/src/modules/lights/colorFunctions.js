export function correctColor(color) {
  // eslint-disable-next-line no-nested-ternary
  return color.map((e) => (e < 0 ? 0 : e > 255 ? 255 : e));
}

export function colorSum(color1, color2) {
  return color1.map((e, i) => e + color2[i]);
}
