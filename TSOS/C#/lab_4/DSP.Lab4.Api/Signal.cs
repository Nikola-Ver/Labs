using System;

namespace DSP.Lab4.Api
{
    public abstract class Signal
    {
        public int n;
        public double[] signal;

        public double[] signVal { get { return signal; } }

        public abstract double[] GenerateSignal();
    }
}
