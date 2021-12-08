import { ambient } from './ambient';
import { diffuse } from './diffuse';
import { specular } from './specular';
import { colorSum, correctColor } from './colorFunctions';
import { mulMatWithCoef } from '../matrices';

const DIFFUSE_COLOR = [255, 255, 255, 255];

const AMBIENT_COLOR = [255, 255, 255, 255];
const AMBIENT_STRENGTH = 0.001;

const SPECULAR_COLOR = [255, 255, 255, 255];
const SPECULAR_STRENGTH = 0.2;
const SPECULAR_SHINES = 128;

export function getPixelColor(color, polygonNormal, scene) {
  const ambientColor = ambient(AMBIENT_STRENGTH, AMBIENT_COLOR);

  const diffuseColor = mulMatWithCoef(
    DIFFUSE_COLOR,
    diffuse(polygonNormal, scene.light),
  ).map((e, i) => (i === 3 ? 255 : e));

  const specularColor = specular(
    SPECULAR_STRENGTH,
    SPECULAR_COLOR,
    polygonNormal,
    SPECULAR_SHINES,
    scene.eye,
    scene.light,
  );

  return correctColor(
    // colorSum(
      colorSum(colorSum(color, ambientColor), specularColor),
    //   specularColor,
    // ),
  );
}
