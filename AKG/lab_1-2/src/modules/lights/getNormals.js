import { mulMatWithCoef, sumVec } from '../matrices';

export function getInterpolatedNormal(n0, n1, v0, v1, x, y, z) {
  const x0 = v0.x;
  const x1 = v1.x;
  const y0 = v0.y;
  const y1 = v1.y;
  const z0 = v0.z;
  const z1 = v1.z;

  let in0;
  let in1;
  if (y0 !== y1) {
    in0 = mulMatWithCoef(n0, (y - y1) / (y0 - y1));
    in1 = mulMatWithCoef(n1, (y0 - y) / (y0 - y1));
  } else if (x0 !== x1) {
    in0 = mulMatWithCoef(n0, (x - x1) / (x0 - x1));
    in1 = mulMatWithCoef(n1, (x0 - x) / (x0 - x1));
  } else if (z0 !== z1) {
    in0 = mulMatWithCoef(n0, (z - z1) / (z0 - z1));
    in1 = mulMatWithCoef(n1, (z0 - z) / (z0 - z1));
  }

  return sumVec(in0, in1);
}
