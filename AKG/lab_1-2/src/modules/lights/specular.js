import { normMatr3x1, mulMatWithCoef, dotVec, subMatr3x1 } from '../matrices';

export function specular(
  strength,
  color,
  normal,
  shininess,
  lookDirection,
  lightDirection,
) {
  const n = normMatr3x1(normal);
  const v = normMatr3x1(lookDirection);
  const l = normMatr3x1(mulMatWithCoef(lightDirection, -1));
  const nl2 = 2 * dotVec(n, l);
  const r = subMatr3x1(l, mulMatWithCoef(n, nl2));
  const rv = dotVec(r, v);
  if (rv >= 0) {
    const pow = shininess ** rv;
    return mulMatWithCoef(color, strength * pow);
  }
  return [0, 0, 0, 255];
}
