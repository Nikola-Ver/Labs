import { Signal } from './Signal';

const dutyCycle = 0.25;
export class HarmonicSignal extends Signal {
  Amplitude: number;
  Frequency: number;
  Phase: number;

  constructor(
    amplitude: number,
    frequency: number,
    phase: number,
    discrPoints: number
  ) {
    super();
    this.Amplitude = amplitude;
    this.n = discrPoints;
    this.Frequency = frequency;
    this.Phase = phase;

    this.signal = this.GenerateSignal();
  }

  public override GenerateSignal(): number[] {
    const values: number[] = new Array(this.n);
    for (let i = 0; i < this.n; i++) {
      // //==========================SQUARE
      // let sample = Math.sin(
      //   (2 * Math.PI * this.Frequency * i) / this.n + this.Phase
      // );
      // sample = sample + dutyCycle * 2 - 1;
      // if (sample > 0) {
      //   values[i] = 1;
      // } else {
      //   values[i] = 0;
      // }
      //==========================
      // ========================= saw
      // values[i] =
      //   ((-2 * this.Amplitude) / Math.PI) *
      //   Math.atan(
      //     1 / Math.tan((Math.PI * this.Frequency * i) / this.n + this.Phase)
      //   );
      // -(
      //   (2 *
      //     this.Amplitude *
      //     Math.atan(1 / Math.tan(Math.PI * this.Frequency * i + this.Phase))) /
      //   Math.PI
      // );
      // ===========================
      //=========================== triangle
      values[i] =
        ((2 * this.Amplitude) / Math.PI) *
        Math.asin(
          Math.sin((2 * Math.PI * this.Frequency * i) / this.n + this.Phase)
        );
      // (2 *
      //   this.Amplitude *
      //   Math.asin(Math.sin(2 * Math.PI * this.Frequency * i + this.Phase))) /
      // Math.PI;
      //==============================
      // values[i] = -(
      //   (2 *
      //     this.Amplitude *
      //     Math.atan(1 / Math.tan(Math.PI * this.Frequency + this.Phase))) /
      //   Math.PI
      // );
      // =============================SIN
      // values[i] =
      //   this.Amplitude *
      //   Math.sin((2 * Math.PI * this.Frequency * i) / this.n + this.Phase);
      //==========================================
    }
    console.log(values);
    return values;
  }
}

// export function GenerateSquareSignalDynamic({
//   amplitude,
//   frequency,
//   initialPhase = 0,
//   startSecs = 0,
//   lengthSecs = 2,
//   byteRate = 44100,
//   dutyCycle = 0.25,
// }) {
//   const length = byteRate * lengthSecs;
//   const data = new Int32Array(byteRate * (lengthSecs + startSecs));

//   const startIndex = startSecs * byteRate;

//   for (let i = 0; i < length; i++) {
//     let sample = Math.sin(
//       (2 * Math.PI * frequency * (i % byteRate)) / byteRate + initialPhase
//     );
//     sample = sample + dutyCycle * 2 - 1;
//     if (sample > 0) {
//       data[i + startIndex] = 1;
//     } else {
//       data[i + startIndex] = 0;
//     }

//     data[i + startIndex] = data[i + startIndex] * amplitude;
//   }
//   return data;
// }
