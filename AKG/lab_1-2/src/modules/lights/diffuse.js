import { normMatr3x1, mulMatWithCoef, dotVec } from '../matrices';

export function diffuse(polygonNormal, lightDirection) {
  const normalizePolygonNormal = normMatr3x1(polygonNormal);
  const invertedNormalizeLightDirection = normMatr3x1(
    mulMatWithCoef(lightDirection, -1),
  );

  const lightDegree = dotVec(
    normalizePolygonNormal,
    invertedNormalizeLightDirection,
  );

  return lightDegree > 0 ? lightDegree : 0;
}
