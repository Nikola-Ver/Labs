using System.Numerics;
using System;

namespace DSP.Lab4.Api
{
    public static class Butterfly
    {
        public const double SinglePi = Math.PI;
        public const double DoublePi = 2 * Math.PI;

        public static Complex[] DecimationInTime(Complex[] frame, bool direct)
        {
            if (frame.Length == 1) return frame;
            int frameHalfSize = frame.Length >> 1;   // frame.Length/2
            int frameFullSize = frame.Length;

            Complex[] frameOdd = new Complex[frameHalfSize];
            Complex[] frameEven = new Complex[frameHalfSize];
            for (int i = 0; i < frameHalfSize; i++)
            {
                int j = i << 1;               // i = 2*j;
                frameOdd[i] = frame[j + 1];
                frameEven[i] = frame[j];
            }

            Complex[] spectrumOdd = DecimationInTime(frameOdd, direct);
            Complex[] spectrumEven = DecimationInTime(frameEven, direct);

            double arg = direct 
                ? -DoublePi / frameFullSize 
                : DoublePi / frameFullSize;
            Complex omegaPowBase = new Complex(Math.Cos(arg), Math.Sin(arg));
            Complex omega = Complex.One;
            Complex[] spectrum = new Complex[frameFullSize];

            for (int j = 0; j < frameHalfSize; j++)
            {
                spectrum[j] = spectrumEven[j] + omega * spectrumOdd[j];
                spectrum[j + frameHalfSize] = spectrumEven[j] - omega * spectrumOdd[j];
                omega *= omegaPowBase;
            }

            return spectrum;
        }
    }
}
