using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Windows.Forms;
using DSP_LW3.Extensions;

namespace DSP_LW3
{
    public partial class MainForm : Form
    {
        private const string FileFilter = "Image Files (*.bmp; *.jpg; *.jpeg; *.png)|*.bmp;*.jpg;*.jpeg;*.png";
        private Bitmap originalBitmap = null;
        private Bitmap previewBitmap = null;
        private Bitmap resultBitmap = null;

        public MainForm()
        {
            InitializeComponent();
            cmbFilter.SelectedIndex = 0;
            tbSize.Visible = false;
            tbSigma.Visible = false;
            btnPerform.Enabled = false;
            btnSave.Enabled = false;
        }

        private void LoadClick(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new();
            ofd.Title = "Выберите изображение.";
            ofd.Filter = FileFilter;

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                StreamReader streamReader = new(ofd.FileName);
                originalBitmap = (Bitmap)Image.FromStream(streamReader.BaseStream);
                streamReader.Close();

                previewBitmap = originalBitmap.CopyToSquareCanvas(pbOriginalImage.Width);
                pbOriginalImage.Image = previewBitmap;

                ApplyFilter(true);
                btnPerform.Enabled = true;
                btnSave.Enabled = true;
            }
        }

        private void ApplyFilter(bool preview)
        {
            if (previewBitmap is null || cmbFilter.SelectedIndex == -1)
            {
                return;
            }

            Bitmap selectedSource;
            Bitmap bitmapResult = null;

            if (preview)
            {
                selectedSource = previewBitmap;
            }
            else
            {
                selectedSource = originalBitmap;
            }

            long startTime = Environment.TickCount64;
            if (selectedSource is not null)
            {
                int filterSize;
                try
                {
                    filterSize = Convert.ToInt32(tbSize.Text);
                    if ((filterSize & 1) == 0)
                    {
                        filterSize += 1;
                        tbSize.Text = filterSize.ToString();
                    }
                }
                catch
                {
                    filterSize = 3;
                    tbSize.Text = filterSize.ToString();
                }

                if (cmbFilter.SelectedItem.ToString() == "Без фильтра")
                {
                    bitmapResult = selectedSource;
                }
                else if (cmbFilter.SelectedItem.ToString() == "Box Blur")
                {
                    bitmapResult = selectedSource.BoxBlurFilter(filterSize);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Gaussian Blur")
                {
                    double sigma = Convert.ToDouble(tbSigma.Text);
                    bitmapResult = selectedSource.GaussianBlurFilter(sigma);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Gaussian Fast Blur")
                {
                    double sigma = Convert.ToDouble(tbSigma.Text);
                    bitmapResult = selectedSource.GaussianFastBlurFilter(sigma);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Gaussian Super Fast Blur")
                {
                    double sigma = Convert.ToDouble(tbSigma.Text);
                    bitmapResult = selectedSource.GaussianSuperFastBlurFilter(sigma);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Median Filter")
                {
                    bitmapResult = selectedSource.MedianFilter(filterSize);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Motion Blur")
                {
                    bitmapResult = selectedSource.MotionBlurFilter(filterSize);
                }
                else if (cmbFilter.SelectedItem.ToString() == "Sobel Operator")
                {
                    bitmapResult = selectedSource.Sobel3x3Filter();
                }
                else if (cmbFilter.SelectedItem.ToString() == "Sharpen")
                {
                    bitmapResult = selectedSource.Sharpen3x3Filter();
                }
            }

            if (bitmapResult is not null)
            {
                if (preview)
                {
                    pbPreview.Image = bitmapResult;
                }
                else
                {
                    resultBitmap = bitmapResult;
                }
            }

            long endTime = Environment.TickCount64;
            long result = endTime - startTime;
            MessageBox.Show($"{result} мс", "Execute time");
        }

        private void FilterSelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbFilter.SelectedItem.ToString() == "Без фильтра"
                || cmbFilter.SelectedItem.ToString() == "Sobel Operator"
                || cmbFilter.SelectedItem.ToString() == "Sharpen"
                || cmbFilter.SelectedItem.ToString() == "Gaussian Blur"
                || cmbFilter.SelectedItem.ToString() == "Gaussian Fast Blur"
                || cmbFilter.SelectedItem.ToString() == "Gaussian Super Fast Blur")
            {
                tbSize.Visible = false;
            }
            else
            {
                tbSize.Visible = true;
            }

            if (cmbFilter.SelectedItem.ToString() == "Gaussian Blur"
                || cmbFilter.SelectedItem.ToString() == "Gaussian Fast Blur"
                || cmbFilter.SelectedItem.ToString() == "Gaussian Super Fast Blur")
            {
                tbSigma.Visible = true;
            }
            else
            {
                tbSigma.Visible = false;
            }
        }

        private void PerformClick(object sender, EventArgs e)
        {
            ApplyFilter(true);
        }

        private void SaveClick(object sender, EventArgs e)
        {
            ApplyFilter(false);

            if (resultBitmap != null)
            {
                SaveFileDialog sfd = new();
                sfd.Title = "Выберите путь.";
                sfd.Filter = FileFilter;

                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    string fileExtension = Path.GetExtension(sfd.FileName).ToLower();
                    ImageFormat imgFormat = ImageFormat.Jpeg;

                    if (fileExtension == "png")
                    {
                        imgFormat = ImageFormat.Png;
                    }
                    else if (fileExtension == "bmp")
                    {
                        imgFormat = ImageFormat.Bmp;
                    }

                    StreamWriter streamWriter = new(sfd.FileName, false);
                    resultBitmap.Save(streamWriter.BaseStream, imgFormat);
                    streamWriter.Flush();
                    streamWriter.Close();

                    resultBitmap = null;
                }
            }
        }
    }
}
