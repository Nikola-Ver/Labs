using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using System.Threading.Tasks;

namespace DSP_LW3
{
    public class GaussianSuperFastFilter
    {
        private readonly int[] alpha;
        private readonly int[] red;
        private readonly int[] green;
        private readonly int[] blue;

        private readonly int width;
        private readonly int height;

        public GaussianSuperFastFilter(Bitmap image)
        {
            var rectangle = new Rectangle(0, 0, image.Width, image.Height);
            var source = new int[rectangle.Width * rectangle.Height];
            var pixelBuffer = image.LockBits(rectangle, ImageLockMode.ReadWrite, PixelFormat.Format32bppArgb);
            Marshal.Copy(pixelBuffer.Scan0, source, 0, source.Length);
            image.UnlockBits(pixelBuffer);

            width = image.Width;
            height = image.Height;

            alpha = new int[width * height];
            red = new int[width * height];
            green = new int[width * height];
            blue = new int[width * height];

            Parallel.For(0, source.Length, i =>
            {
                alpha[i] = (int)((source[i] & 0xff000000) >> 24);
                red[i] = (source[i] & 0xff0000) >> 16;
                green[i] = (source[i] & 0x00ff00) >> 8;
                blue[i] = (source[i] & 0x0000ff);
            });
        }

        public Bitmap Process(double radial)
        {
            var newAlpha = new int[width * height];
            var newRed = new int[width * height];
            var newGreen = new int[width * height];
            var newBlue = new int[width * height];
            var dest = new int[width * height];

            Parallel.Invoke(
                () => GaussBlur(alpha, newAlpha, radial),
                () => GaussBlur(red, newRed, radial),
                () => GaussBlur(green, newGreen, radial),
                () => GaussBlur(blue, newBlue, radial)
            );

            Parallel.For(0, dest.Length, i =>
            {
                if (newAlpha[i] > 255) newAlpha[i] = 255;
                if (newRed[i] > 255) newRed[i] = 255;
                if (newGreen[i] > 255) newGreen[i] = 255;
                if (newBlue[i] > 255) newBlue[i] = 255;

                if (newAlpha[i] < 0) newAlpha[i] = 0;
                if (newRed[i] < 0) newRed[i] = 0;
                if (newGreen[i] < 0) newGreen[i] = 0;
                if (newBlue[i] < 0) newBlue[i] = 0;

                dest[i] = (int)((uint)(newAlpha[i] << 24) | (uint)(newRed[i] << 16) | (uint)(newGreen[i] << 8) | (uint)newBlue[i]);
            });

            var image = new Bitmap(width, height);
            var rectangle = new Rectangle(0, 0, image.Width, image.Height);
            var resultBuffer = image.LockBits(rectangle, ImageLockMode.ReadWrite, PixelFormat.Format32bppArgb);
            Marshal.Copy(dest, 0, resultBuffer.Scan0, dest.Length);
            image.UnlockBits(resultBuffer);
            return image;
        }

        private void GaussBlur(int[] source, int[] dest, double r)
        {
            var boxes = BoxesForGauss(r, 3);
            BoxBlur(source, dest, width, height, (boxes[0] - 1) / 2);
            BoxBlur(dest, source, width, height, (boxes[1] - 1) / 2);
            BoxBlur(source, dest, width, height, (boxes[2] - 1) / 2);
        }

        private static int[] BoxesForGauss(double sigma, int n)
        {
            var wIdeal = Math.Sqrt((12 * sigma * sigma / n) + 1);
            var wl = (int)Math.Floor(wIdeal);
            if (wl % 2 == 0) wl--;
            var wu = wl + 2;

            var mIdeal = ((12 * sigma * sigma) - n * wl * wl - 4 * n * wl - 3 * n) / (-4 * wl - 4);
            var m = Math.Round(mIdeal);

            var sizes = new List<int>();
            for (var i = 0; i < n; i++) sizes.Add(i < m ? wl : wu);

            return sizes.ToArray();
        }

        private static void BoxBlur(int[] source, int[] dest, int w, int h, int r)
        {
            for (var i = 0; i < source.Length; i++)
            {
                dest[i] = source[i];
            }

            BoxBlurHorizontal(dest, source, w, h, r);
            BoxBlurTotal(source, dest, w, h, r);
        }

        private static void BoxBlurHorizontal(int[] source, int[] dest, int width, int height, int filterOffset)
        {
            int tempSize = Math.Min(width, height) / 2 - 1;
            filterOffset = filterOffset > tempSize ? tempSize : filterOffset;
            var factor = 1d / (filterOffset + filterOffset + 1);
            Parallel.For(0, height, i =>
            {
                var temp = i * width;
                var left = temp;
                var right = temp + filterOffset + 1;
                var firstValue = source[temp];
                var lastValue = source[temp + width - 1];
                var value = firstValue * filterOffset;
                for (var j = 0; j <= filterOffset; j++)
                {
                    value += source[temp + j];
                }
                dest[temp++] = (int)Math.Round(value * factor);

                for (var j = 0; j < filterOffset; j++)
                {
                    value += source[right++] - firstValue;
                    dest[temp++] = (int)Math.Round(value * factor);
                }

                for (var j = filterOffset + 1; j < width - filterOffset; j++)
                {
                    value += source[right++] - source[left++];
                    dest[temp++] = (int)Math.Round(value * factor);
                }

                for (var j = width - filterOffset; j < width; j++)
                {
                    value += lastValue - source[left++];
                    dest[temp++] = (int)Math.Round(value * factor);
                }
            });
        }

        private static void BoxBlurTotal(int[] source, int[] dest, int width, int height, int filterOffset)
        {
            int tempSize = Math.Min(width, height) / 2 - 1;
            filterOffset = filterOffset > tempSize ? tempSize : filterOffset;
            var factor = 1d / (filterOffset + filterOffset + 1);
            Parallel.For(0, width, i =>
            {
                var temp = i;
                var left = temp;
                var right = temp + (filterOffset + 1) * width;
                var firstValue = source[temp];
                var lastValue = source[temp + width * (height - 1)];
                var value = firstValue * filterOffset;
                for (var j = 0; j <= filterOffset; j++)
                {
                    value += source[temp + j * width];
                }
                dest[temp] = (int)Math.Round(value * factor);
                temp += width;

                for (var j = 0; j < filterOffset; j++)
                {
                    value += source[right] - firstValue;
                    dest[temp] = (int)Math.Round(value * factor);
                    right += width;
                    temp += width;
                }

                for (var j = filterOffset + 1; j < height - filterOffset; j++)
                {
                    value += source[right] - source[left];
                    dest[temp] = (int)Math.Round(value * factor);
                    left += width;
                    right += width;
                    temp += width;
                }

                for (var j = height - filterOffset; j < height; j++)
                {
                    value += lastValue - source[left];
                    dest[temp] = (int)Math.Round(value * factor);
                    left += width;
                    temp += width;
                }
            });
        }
    }
}
