import * as math from 'mathjs';

const DoublePi = 2 * Math.PI;
export class Butterfly {
  public static DecimationInTime(
    frame: math.Complex[],
    direct: boolean
  ): math.Complex[] {
    if (frame.length === 1) return frame;
    const frameHalfSize = frame.length >> 1; // /2
    const frameFullSize = frame.length;
    const frameOdd: math.Complex[] = new Array<math.Complex>(frameHalfSize);
    const frameEven: math.Complex[] = new Array<math.Complex>(frameHalfSize);

    for (let i = 0; i < frameHalfSize; i++) {
      let j = i << 1; // i = 2 * j;
      frameOdd[i] = frame[j + 1];
      frameEven[i] = frame[j];
    }
    const spectrumOdd: math.Complex[] = Butterfly.DecimationInTime(
      frameOdd,
      direct
    );
    const spectrumEven: math.Complex[] = Butterfly.DecimationInTime(
      frameEven,
      direct
    );
    let arg = direct ? -DoublePi / frameFullSize : DoublePi / frameFullSize;
    const omegaPowBase: math.Complex = math.complex(
      Math.cos(arg),
      Math.sin(arg)
    );
    let omega: math.Complex = math.complex(1, 0);
    const spectrum: math.Complex[] = new Array(frameFullSize);
    for (let j = 0; j < frameHalfSize; j++) {
      const temp = math.multiply(omega, spectrumOdd[j]);
      spectrum[j] = math.add(spectrumEven[j], temp) as math.Complex;
      spectrum[j + frameHalfSize] = math.subtract(
        spectrumEven[j],
        math.multiply(omega, spectrumOdd[j])
      ) as math.Complex;

      omega = math.multiply(omega, omegaPowBase) as math.Complex;
    }
    return spectrum;
  }
}
