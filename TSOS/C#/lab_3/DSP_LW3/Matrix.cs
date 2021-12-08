using System;

namespace DSP_LW3
{
    public static class Matrix
    {
        public static double[,] Sharpen3x3
        {
            get
            {
                return new double[,]
                {
                    { 0,  -1,  0, },
                    { -1,  5,  -1, },
                    { 0,  -1,  0, },
                };
            }
        }

        public static double[,] Sobel3x3Horizontal
        {
            get
            {
                return new double[,]
                {
                    { -1,  0,  1, },
                    { -2,  0,  2, },
                    { -1,  0,  1, },
                };
            }
        }

        public static double[,] Sobel3x3Vertical
        {
            get
            {
                return new double[,]
                {
                    {  1,  2,  1, },
                    {  0,  0,  0, },
                    { -1, -2, -1, },
                };
            }
        }

        public static (double[,], double) GetBoxBlurMatrix(int size)
        {
            double[,] matrix = new double[size, size];
            int offset = (size - 1) / 2;
            double sum = 0;
            for (int y = -offset; y <= offset; y++)
            {
                for (int x = -offset; x <= offset; x++)
                {
                    matrix[y + offset, x + offset] = 1;
                    sum += matrix[y + offset, x + offset];
                }
            }

            sum = 1 / sum;
            return (matrix, sum);
        }

        public static (double[,], double) GetMotionBlurMatrix(int size)
        {
            double[,] matrix = new double[size, size];
            int offset = (size - 1) / 2;
            double sum = 0;
            for (int y = -offset; y <= offset; y++)
            {
                for (int x = -offset; x <= offset; x++)
                {
                    if (x == y)
                    {
                        matrix[y + offset, x + offset] = 1;
                        sum += matrix[y + offset, x + offset];
                    }
                }
            }

            sum = 1 / sum;
            return (matrix, sum);
        }

        public static (double[,], double) GetGaussianMatrix(double sigma)
        {
            int size = (int)Math.Ceiling(6 * sigma);
            size = (size & 1) == 0 ? size + 1 : size;
            double[,] matrix = new double[size, size];
            int offset = (size - 1) / 2;
            double sum = 0;
            for (int y = -offset; y <= offset; y++)
            {
                for (int x = -offset; x <= offset; x++)
                {
                    matrix[y + offset, x + offset] = 1d / (2 * Math.PI * sigma * sigma) * Math.Exp(-((x * x) + (y * y)) / (2 * sigma * sigma));
                    sum += matrix[y + offset, x + offset];
                }
            }

            sum = 1 / sum;
            return (matrix, sum);
        }

        public static (double[], double) Get1DGaussianMatrix(double sigma)
        {
            int size = (int)Math.Ceiling(6 * sigma);
            size = (size & 1) == 0 ? size + 1 : size;
            double[] matrix = new double[size];
            int offset = (size - 1) / 2;
            double sum = 0;
            for (int x = -offset; x <= offset; x++)
            {
                matrix[x + offset] = 1d / (Math.Sqrt(2 * Math.PI) * sigma) * Math.Exp(-(x * x) / (2 * sigma * sigma));
                sum += matrix[x + offset];
            }

            sum = 1 / sum;
            return (matrix, sum);
        }
    }
}
