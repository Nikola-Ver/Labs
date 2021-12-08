import * as math from 'mathjs';
const numberHarmonics = 30;
const n = 1024;

export class HarmonicSignal {
  Amplitude = 20;
  Frequency = 4;
  Phase = -Math.PI / 4;
  filtrationType = '4';

  signal = [];
  sineSpectrum = [];
  cosineSpectrum = [];
  amplSpectrum = [];
  phaseSpectrum = [];
  restoredPhasedSignal = [];
  restoredNonePhasedSignal = [];

  GenerateTask2_1(frequncy) {
    this.Frequency = frequncy;
    this.GenerateSignal();
    this.GetSineSpectrum();
    this.GetCosineSpectrum();
    this.GetAmplSpectrum(0, 10);
    this.GetPhaseSpectrum();
    this.RestoreNonPhasedSignal();
    this.RestoreSignal();

    return {
      signal: this.signal,
      restoredSignal: this.restoredNonePhasedSignal,
      restoredPhasedSignal: this.restoredPhasedSignal,
      amplSpectrum: this.amplSpectrum,
      phaseSpectrum: this.phaseSpectrum,
    };
  }

  GenerateSignal() {
    for (let i = 0; i < n; i++) {
      this.signal[i] =
        this.Amplitude *
        Math.cos((2 * Math.PI * this.Frequency * i) / n + this.Phase);
    }
  }

  GetSineSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      let val = 0;
      for (let i = 0; i < n; i++) {
        val += this.signal[i] * Math.sin((2 * Math.PI * i * j) / n);
      }
      this.sineSpectrum[j] = (2 * val) / n;
    }
  }

  GetCosineSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      let val = 0;
      for (let i = 0; i < n; i++) {
        val += this.signal[i] * Math.cos((2 * Math.PI * i * j) / n);
      }
      this.cosineSpectrum[j] = (2 * val) / n;
    }
  }

  GetAmplSpectrum(minHarmonic, maxHarmonic) {
    let tempValue;
    for (let j = 0; j < numberHarmonics; j++) {
      tempValue = Math.sqrt(
        Math.pow(this.sineSpectrum[j], 2) + Math.pow(this.cosineSpectrum[j], 2)
      );
      switch (this.filtrationType) {
        case '1':
          this.amplSpectrum[j] =
            j > maxHarmonic && j < minHarmonic ? tempValue : 0;
          break;
        case '2':
          this.amplSpectrum[j] = j < maxHarmonic ? 0 : tempValue;
          break;
        case '3':
          this.amplSpectrum[j] = j > minHarmonic ? 0 : tempValue;
          break;
        case '4':
          this.amplSpectrum[j] = tempValue;
          break;
        default:
          break;
      }
    }
  }

  GetPhaseSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      this.phaseSpectrum[j] = Math.atan2(
        this.sineSpectrum[j],
        this.cosineSpectrum[j]
      );
      if (this.amplSpectrum[j] < 0.01) {
        this.phaseSpectrum[j] = 0;
      }
    }
  }

  RestoreSignal() {
    let temp = 0;
    for (let i = 0; i < n; i++) {
      let val = 0;
      for (let j = 0; j < numberHarmonics; j++) {
        val +=
          this.amplSpectrum[j] *
          Math.cos((2 * Math.PI * i * j) / n - this.phaseSpectrum[j]);
      }
      if (i % 2 === 0) {
        this.restoredPhasedSignal[temp] = val;
        temp++;
      }
    }
  }

  RestoreNonPhasedSignal() {
    let temp = 0;
    for (let i = 0; i < n; i++) {
      let val = 0;
      for (let j = 0; j < numberHarmonics; j++) {
        val += this.amplSpectrum[j] * Math.cos((2 * Math.PI * i * j) / n);
      }
      if (i % 2 === 0) {
        this.restoredNonePhasedSignal[temp] = val;
        temp++;
      }
    }
  }
}

export class PolyharmonicSignal {
  Amplitude = [];
  Frequency;
  Phase = [];
  filtrationType;

  signal = [];
  sineSpectrum = [];
  cosineSpectrum = [];
  amplSpectrum = [];
  phaseSpectrum = [];
  restoredPhasedSignal = [];
  restoredNonePhasedSignal = [];

  resAmplitudes = [];
  resPhases = [];

  GenerateTask3_1(frequncy, filtrationType, maxHarmonic, minHarmonic) {
    console.log(frequncy, filtrationType, maxHarmonic, minHarmonic);
    this.Amplitude = [1, 6, 7, 9, 12, 14, 17];
    this.Phase = [
      Math.PI / 6,
      Math.PI / 4,
      Math.PI / 3,
      Math.PI / 2,
      (3 * Math.PI) / 4,
      Math.PI,
    ];

    for (let i = 0; i < numberHarmonics; i++) {
      this.resAmplitudes[i] = this.Amplitude[this.getRandomInt(7)];
      this.resPhases[i] = this.Phase[this.getRandomInt(6)];
    }

    this.Frequency = frequncy;
    this.filtrationType = filtrationType;
    this.GenerateSignal();
    this.GetSineSpectrum();
    this.GetCosineSpectrum();
    this.GetAmplSpectrum(maxHarmonic, minHarmonic);
    this.GetPhaseSpectrum();
    this.RestoreNonPhasedSignal();
    this.RestoreSignal();

    return {
      signal: this.signal,
      restoredSignal: this.restoredNonePhasedSignal,
      restoredPhasedSignal: this.restoredPhasedSignal,
      amplSpectrum: this.amplSpectrum,
      phaseSpectrum: this.phaseSpectrum,
    };
  }

  RedreawTask3_1(filtrationType, maxHarmonic, minHarmonic) {
    this.filtrationType = filtrationType;
    this.GetSineSpectrum();
    this.GetCosineSpectrum();
    this.GetAmplSpectrum(maxHarmonic, minHarmonic);
    this.GetPhaseSpectrum();
    this.RestoreNonPhasedSignal();
    this.RestoreSignal();
    console.log('hello');
    return {
      signal: this.signal,
      restoredSignal: this.restoredNonePhasedSignal,
      restoredPhasedSignal: this.restoredPhasedSignal,
      amplSpectrum: this.amplSpectrum,
      phaseSpectrum: this.phaseSpectrum,
    };
  }

  GenerateSignal() {
    for (let i = 0; i <= n - 1; i++) {
      let temp = 0;
      for (let j = 0; j < numberHarmonics; j++) {
        temp +=
          this.resAmplitudes[j] *
          Math.cos((2 * Math.PI * (j + 1) * i) / n - this.resPhases[j]);
      }
      this.signal[i] = temp;
    }
  }

  GetSineSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      let val = 0;
      for (let i = 0; i < n; i++) {
        val += this.signal[i] * Math.sin((2 * Math.PI * i * j) / n);
      }
      this.sineSpectrum[j] = (2 * val) / n;
    }
  }

  GetCosineSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      let val = 0;
      for (let i = 0; i < n; i++) {
        val += this.signal[i] * Math.cos((2 * Math.PI * i * j) / n);
      }
      this.cosineSpectrum[j] = (2 * val) / n;
    }
  }

  GetAmplSpectrum(maxHarmonic, minHarmonic) {
    let tempValue;

    for (let j = 0; j < numberHarmonics; j++) {
      const value1 = Math.pow(this.sineSpectrum[j], 2);
      const value2 = Math.pow(this.cosineSpectrum[j], 2);
      tempValue = Math.sqrt(value1 + value2, 2);
      switch (this.filtrationType) {
        case 1:
          this.amplSpectrum[j] =
            j > maxHarmonic && j < minHarmonic ? tempValue : 0;
          break;
        case 2:
          this.amplSpectrum[j] = j < maxHarmonic ? 0 : tempValue;
          break;
        case 3:
          this.amplSpectrum[j] = j > minHarmonic ? 0 : tempValue;
          break;
        case 4:
          this.amplSpectrum[j] = tempValue;
          break;
        default:
          break;
      }
    }
  }

  GetPhaseSpectrum() {
    for (let j = 0; j < numberHarmonics; j++) {
      this.phaseSpectrum[j] = Math.atan2(
        this.sineSpectrum[j],
        this.cosineSpectrum[j]
      );
      if (this.amplSpectrum[j] < 0.01) {
        this.phaseSpectrum[j] = 0;
      }
    }
  }

  RestoreSignal() {
    let temp = 0;
    for (let i = 0; i < n; i++) {
      let val = 0;
      for (let j = 0; j < numberHarmonics; j++) {
        val +=
          this.amplSpectrum[j] *
          Math.cos((2 * Math.PI * i * j) / n - this.phaseSpectrum[j]);
      }
      if (i % 2 === 0) {
        this.restoredPhasedSignal[temp] = val;
        temp++;
      }
    }
  }

  RestoreNonPhasedSignal() {
    let temp = 0;
    for (let i = 0; i < n; i++) {
      let val = 0;
      for (let j = 0; j < numberHarmonics; j++) {
        val += this.amplSpectrum[j] * Math.cos((2 * Math.PI * i * j) / n);
      }
      if (i % 2 === 0) {
        this.restoredNonePhasedSignal[temp] = val;
        temp++;
      }
    }
  }
  getRandomInt(max) {
    return Math.floor(Math.random() * max);
  }
}

const DoublePi = 2 * Math.PI;
export class Butterfly {
  static DecimationInTime(frame, direct) {
    if (frame.length === 1) return frame;
    const frameHalfSize = frame.length >> 1; // /2
    const frameFullSize = frame.length;
    const frameOdd = new Array(frameHalfSize);
    const frameEven = new Array(frameHalfSize);

    for (let i = 0; i < frameHalfSize; i++) {
      let j = i << 1; // i = 2 * j;
      frameOdd[i] = frame[j + 1];
      frameEven[i] = frame[j];
    }
    const spectrumOdd = Butterfly.DecimationInTime(frameOdd, direct);
    const spectrumEven = Butterfly.DecimationInTime(frameEven, direct);
    let arg = direct ? -DoublePi / frameFullSize : DoublePi / frameFullSize;
    const omegaPowBase = math.complex(Math.cos(arg), Math.sin(arg));
    let omega = math.complex(1, 0);
    const spectrum = new Array(frameFullSize);
    for (let j = 0; j < frameHalfSize; j++) {
      const temp = math.multiply(omega, spectrumOdd[j]);
      spectrum[j] = math.add(spectrumEven[j], temp);
      spectrum[j + frameHalfSize] = math.subtract(
        spectrumEven[j],
        math.multiply(omega, spectrumOdd[j])
      );

      omega = math.multiply(omega, omegaPowBase);
    }
    return spectrum;
  }
}
