using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TWOP_1
{
    class Triangle
    {
        private const int MAX_SIDE = 1_000_000_000;
        private const string MSG_OUT_OF_RANGE = "Введены неверные значения (значения должны\n быть целыми числами в диапазоне от 1 до 1 000 000 000)";
        private const string MSG_TRIANGLE_IS_NOT_EXIST = "Введенный треугольник не существует";

        private int sideA;
        private int sideB;
        private int sideC;

        public Triangle(string sideStringA, string sideStringB, string sideStringC)
        {
            try
            {
                sideA = int.Parse(sideStringA);
                sideB = int.Parse(sideStringB);
                sideC = int.Parse(sideStringC);
            }
            catch
            {
                throw new Exception(MSG_OUT_OF_RANGE);
            }

            if (!((sideA >= 0) && (sideB >= 1) && (sideC >= 1) && (sideA < MAX_SIDE) && (sideB < MAX_SIDE) && (sideC < MAX_SIDE)))
            {
                throw new Exception(MSG_OUT_OF_RANGE);
            }

            if (!isExists())
            {
                throw new Exception(MSG_TRIANGLE_IS_NOT_EXIST);
            }
        }

        private bool isExists()
        {
            if ((sideA + sideB > sideC) && (sideA + sideC > sideB) && (sideB + sideC > sideA))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool isEquilateral()
        {
            if ((sideA == sideB) && (sideB == sideC) && (sideC == sideA))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool isIsosceles()
        {
            if ((sideA == sideB) || (sideB == sideC) || (sideC == sideA))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool isVersatile()
        {
            if ((sideA != sideB) && (sideB != sideC) && (sideC != sideA))
            {
                return true;
            }
            return false;
        }
    }
}
