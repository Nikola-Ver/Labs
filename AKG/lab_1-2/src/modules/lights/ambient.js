import { mulMatWithCoef } from '../matrices';
import { correctColor } from './colorFunctions';

export function ambient(strength, color) {
  return correctColor(mulMatWithCoef(color, strength));
}
