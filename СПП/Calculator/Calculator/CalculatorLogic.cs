using System;

namespace Calculator
{
    public class CalculatorLogic
    {
        double currentVal = 0;

        public double Add(double val)
        {
            currentVal += val;
            return currentVal;
        }

        public double Subtraction(double val)
        {
            currentVal -= val;
            return currentVal;
        }

        public double Multiply(double val)
        {
            currentVal *= val;
            return currentVal;
        }

        public double Division(double val)
        {
            if (val < 0.00000000001) 
                throw new DivideByZeroException("You tried to divide " + currentVal + " by 0"); 

            currentVal /= val;
            return currentVal;
        }

        public double Power(double val)
        {
            if (currentVal < 0 && Convert.ToInt32(val) != val)
                throw new IndexOutOfRangeException("You tried to raise " + currentVal + 
                                                   " to the power of " + val);

            currentVal = Math.Pow(currentVal, val);
            return currentVal;
        }

        // Override methods

        public double Add(double val1, double val2)
        {
            currentVal = val1 + val2;
            return currentVal;
        }

        public double Subtraction(double val1, double val2)
        {
            currentVal = val1 - val2;
            return currentVal;
        }

        public double Multiply(double val1, double val2)
        {
            currentVal = val1 * val2;
            return currentVal;
        }

        public double Division(double val1, double val2)
        {
            if (val2 < 0.00000000001) 
                throw new DivideByZeroException("You tried to divide " + currentVal + " by 0");

            currentVal = val1 / val2;
            return currentVal;
        }

        public double Power(double val1, double val2)
        {
            if (val1 < 0 && Convert.ToInt32(val2) != val2)
                throw new IndexOutOfRangeException("You tried to raise " + val1 +
                                                   " to the power of " + val2);

            currentVal = Math.Pow(val1, val2);
            return currentVal;
        }

        public double GetCurrentVal() => currentVal;
    }
}
