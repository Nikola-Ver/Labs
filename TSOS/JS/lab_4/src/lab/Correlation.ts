import * as math from 'mathjs';
import { Butterfly } from './Butterfly';

export class Сorrelation {
  public static CrossCorrelation(
    signal1: number[],
    signal2: number[]
  ): math.Complex[] {
    if (signal1.length != signal2.length) {
      alert('something went');
      throw new Error('The lengths of arrays must be the same');
    }

    let L = signal1.length + signal2.length;

    const correlation: math.Complex[] = new Array(L);

    let index1 = 0;
    let index2 = signal2.length - 1;

    let start;
    let end;
    let index;

    for (let i = 0; i < L; i++) {
      let sum: math.Complex = math.complex(0, 0);

      if (i < signal1.length - 1) {
        start = index2;
        end = signal2.length;
        index = 0;

        for (let j = start; j < end; j++) {
          const mutlplier = math.multiply(signal1[index++], signal2[j]);

          sum = math.add(sum, mutlplier) as math.Complex;
        }

        index1++;
        index2--;
      } else {
        start = signal1.length - index1 - 1;
        end = signal1.length;
        index = 0;

        for (let j = start; j < end; j++) {
          sum = math.add(
            sum,
            math.multiply(signal1[j], signal2[index++])
          ) as math.Complex;
        }

        index1--;
        index2++;
      }

      correlation[i] = sum;
    }

    return Сorrelation.Normalize(correlation);
  }

  public static FastCrossCorrelation(
    signal1: number[],
    signal2: number[]
  ): math.Complex[] {
    const L = signal1.length + signal2.length;

    const complexSignal1: math.Complex[] = new Array(L)
      .fill(undefined)
      .map(() => math.complex(0, 0));
    const complexSignal2: math.Complex[] = new Array(L)
      .fill(undefined)
      .map(() => math.complex(0, 0));

    for (let i = 0; i < signal1.length; i++) {
      complexSignal1[i] = math.complex(signal1[i], 0);
    }

    for (let i = 0; i < signal2.length; i++) {
      complexSignal2[i] = math.complex(signal2[i], 0);
    }

    const bpf1: math.Complex[] = Butterfly.DecimationInTime(
      complexSignal1,
      true
    );
    const bpf2: math.Complex[] = Butterfly.DecimationInTime(
      complexSignal2,
      true
    );

    const multiplicated: math.Complex[] = new Array(L);
    for (let i = 0; i < L; i++) {
      bpf1[i] = math.divide(bpf1[i], bpf1.length) as math.Complex;
      bpf2[i] = math.divide(bpf2[i], bpf2.length) as math.Complex;
      // @ts-ignore
      multiplicated[i] = math.multiply(bpf1[i], bpf2[i].conjugate()) as Complex;
    }

    const correlation: math.Complex[] = Butterfly.DecimationInTime(
      multiplicated,
      false
    );

    return Сorrelation.Normalize(correlation);
  }

  public static AutoCorrelation(
    signal: number[],
    shift: number
  ): math.Complex[] {
    return Сorrelation.CrossCorrelation(
      signal,
      Сorrelation.GetShiftedSignal(signal, shift)
    );
  }

  public static FastAutoCorrelation(
    signal: number[],
    shift: number
  ): math.Complex[] {
    return Сorrelation.FastCrossCorrelation(
      signal,
      Сorrelation.GetShiftedSignal(signal, shift)
    );
  }

  private static Normalize(values: math.Complex[]): math.Complex[] {
    const result: math.Complex[] = new Array(values.length);

    const max = Math.max(...values.map(e => e.re)); //values.Max(c => Math.abs(c.Real));

    for (let i = 0; i < result.length; i++) {
      result[i] = math.divide(values[i], max) as math.Complex;
    }

    return result;
  }

  private static GetShiftedSignal(signal: number[], shift: number): number[] {
    const shiftedSignal: number[] = new Array<number>(signal.length);

    for (let i = 0; i < shiftedSignal.length; i++) {
      let index = i - shift;
      if (index < 0) {
        index = signal.length + index;
      }
      shiftedSignal[i] = signal[index];
    }
    return shiftedSignal;
  }
}
