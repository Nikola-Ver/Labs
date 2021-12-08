export abstract class Signal {
  public n!: number;
  public signal!: number[];

  // public number[] signVal: number[] { get { return signal; } }

  public get signVal() {
    return this.signal;
  }

  public abstract GenerateSignal(): number[];
}
