using System;
using System.Linq;

namespace MainModule
{
    public static class TheoryInf
    {
        public static bool isSimple(long N)              //определение простого числа
        {
            bool IfProst = false;
            for (int i = 2; i < (int)(N / 2); i++)
            {
                if (N % i == 0)
                {
                    IfProst = false;
                    break;
                }
                else
                {
                    IfProst = true;
                }
            }
            return IfProst;
        }

        public static long NOD(long m, long n)
        {
            long nod = 0;
            for (long i = m; i > 0; i--)
            {
                if (m % i == 0 && n % i == 0)
                {
                    nod = i;
                    break;
                }
            }
            return nod;
        }

        public static long Proizv(long a, long b)    //произведение
        {
            return a * b;
        }

        public static long FuncEiler(long a, long b)
        {
            return (a - 1) * (b - 1);
        }

        public static long Ext_GCD(long eiler, long d)   //расширенный алгоритм евклида
        {                                                 //находим e
            long q, d2, x2, y2;
            long d0 = eiler;
            long d1 = d;
            long x0 = 1;
            long x1 = 0;
            long y0 = 0;
            long y1 = 1;
            while (d1 > 1)
            {
                q = d0 / d1;
                d2 = d0 % d1;
                x2 = x0 - (q * x1);
                y2 = y0 - (q * y1);
                d0 = d1;
                d1 = d2;
                x0 = x1;
                x1 = x2;
                y0 = y1;
                y1 = y2;
            }
            if (y1 < 0)
            {
                y1 += eiler;
            }
            return (y1);
        }

        public static long InPower(byte M, long e, long r)  //возведение в степень
        {
            long a = (long)M;
            long z = e;
            long x = 1;
            while (z != 0)
            {
                while (z % 2 == 0)
                {
                    z = z / 2;
                    a = (a * a) % r;
                }
                z--;
                x = (x * a) % r;
            }
            return (long)x;
        }

        public static string ProvNaDigits(string s)
        {
            string str = "";
            char[] digits = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
            if (s == null)
            {
                throw new NullReferenceException("Строка не задана");
            }
            foreach (char a in s)
            {
                if (digits.Select(x => x).Contains(a))
                {
                    str += a;
                    continue;
                }
            }
            return str;
        }
    }
}
