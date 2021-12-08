using System;

namespace DSP.Lab4.Api
{
    public class HarmonicSignal : Signal
    {
        double Amplitude;
        double Frequency;
        double Phase;

        public HarmonicSignal(
            double amplitude, 
            double frequency, 
            double phase, 
            int discrPoints)
        {
            Amplitude = amplitude;
            n = discrPoints;
            Frequency = frequency;
            Phase = phase;

            signal = GenerateSignal();
        }

        public override double[] GenerateSignal()
        {
            double[] values = new double[n];
            for (int i = 0; i < n; i++)
            {
                values[i] = Amplitude * Math.Sin(2 * Math.PI * Frequency * i / n + Phase);
            }
            return values;
        }
    }
}
