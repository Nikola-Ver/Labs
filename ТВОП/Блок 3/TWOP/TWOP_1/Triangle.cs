using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TWOP_1
{
    class Triangle
    {
        private const string MSG_OUT_OF_RANGE = "Введены неверные значения (значения должны\n быть целыми числами в диапазоне от 1 до 1 000 000 000).";
        private const string MSG_TRIANGLE_IS_NOT_EXIST = "Введенного треугольника не существует.\nТреугольник существует, если выполняются все 3 условия:\n•	AB + AC > BC\n•	AC + BC > AB\n•	AB + BC > AC";

        private const int MAX_SIDE = 1_000_000_000;

        private int sideAB;
        private int sideBC;
        private int sideAC;

        public Triangle(string sideStringAB, string sideStringBC, string sideStringAC) 
        {
            try
            {
                sideAB = int.Parse(sideStringAB);
                sideBC = int.Parse(sideStringBC);
                sideAC = int.Parse(sideStringAC);
            }
            catch
            {
                throw new Exception(MSG_OUT_OF_RANGE);
            }

            if (!((sideAB >= 1) && (sideBC >= 1) && (sideAC >= 1) && (sideAB <= MAX_SIDE) && (sideBC <= MAX_SIDE) && (sideAC <= MAX_SIDE)))
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
            if ((sideAB + sideBC > sideAC) && (sideAB + sideAC > sideBC) && (sideBC + sideAC > sideAB))
            {
                return true;
            }
            return false;
        }

        public bool isEquilateral() 
        {
            if ((sideAB == sideBC) && (sideBC == sideAC))
            {
                return true;
            }
            return false;
        }

        public bool isIsosceles() 
        {
            if ((sideAB == sideBC) || (sideBC == sideAC) || (sideAC == sideAB))
            {
                return true;
            }
            return false;
        }

        public bool isVersatile()
        {
            if ((sideAB != sideBC) && (sideBC != sideAC) && (sideAC != sideAB))
            {
                return true;
            }
            return false;
        }
    }
}
