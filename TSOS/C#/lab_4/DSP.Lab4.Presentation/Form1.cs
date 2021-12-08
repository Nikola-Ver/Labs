using DSP.Lab4.Api;
using System;
using System.Diagnostics;
using System.Numerics;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace DSP.Lab4.Presentation
{
    public partial class Form1 : Form
    {
        Chart[] targetCharts;
        int N = 1024;

        public Form1()
        {
            InitializeComponent();

            targetCharts = new Chart[2];
            targetCharts[0] = chart1;
            targetCharts[1] = chart2;
        }

        private void ClearCharts()
        {
            for (int i = 0; i < 2; i++)
            {
                foreach (var j in targetCharts[i].Series)
                {
                    j.Points.Clear();
                }
            }
        }

        private void Calculate(СorrelationType ct)
        {
            HarmonicSignal firstSignal = new HarmonicSignal(100, 1, 0, N);
            HarmonicSignal secondSignal = new HarmonicSignal(80, 1.5, 30, N);

            Complex[] crossCorrelation = null;
            Complex[] fastCrossCorrelation = null;

            Stopwatch stopwatch1 = new Stopwatch();
            Stopwatch stopwatch2 = new Stopwatch();

            long time = 1;
            long fastTime = 1;

            switch (ct)
            {
                case СorrelationType.Cross:
                    stopwatch1.Start();
                    crossCorrelation = DSP.Lab4.Api.Сorrelation.CrossCorrelation(firstSignal.signVal, secondSignal.signVal);
                    stopwatch1.Stop();
                    time = stopwatch1.ElapsedTicks;

                    stopwatch2.Start();
                    fastCrossCorrelation = DSP.Lab4.Api.Сorrelation.FastCrossCorrelation(firstSignal.signVal, secondSignal.signVal);
                    stopwatch2.Stop();
                    fastTime = stopwatch2.ElapsedTicks;
                    break;
                case СorrelationType.Auto:
                    stopwatch1.Start();
                    crossCorrelation = DSP.Lab4.Api.Сorrelation.AutoCorrelation(firstSignal.signVal, 100);
                    stopwatch1.Stop();
                    time = stopwatch1.ElapsedTicks;

                    stopwatch2.Start();
                    fastCrossCorrelation = DSP.Lab4.Api.Сorrelation.FastAutoCorrelation(firstSignal.signVal, 100);
                    stopwatch2.Stop();
                    fastTime = stopwatch2.ElapsedTicks;
                    break;
            }

            ClearCharts();

            if (ct == СorrelationType.Cross)
            {
                for (int i = 0; i < N; i++)
                {
                    targetCharts[0].Series[0].Points.AddXY(
                        2 * Math.PI * i / N, 
                        firstSignal.signVal[i]
                    );
                    targetCharts[0].Series[1].Points.AddXY(
                        2 * Math.PI * i / N, 
                        secondSignal.signVal[i]
                    );
                }
            }
            else
            {
                for (int i = 0; i < N; i++)
                {
                    targetCharts[0].Series[0].Points.AddXY(
                        2 * Math.PI * i / N, 
                        firstSignal.signVal[i]
                    );
                }
            }

            for (int i = 0; i < crossCorrelation.Length; i++)
            {
                targetCharts[1].Series[0].Points.AddXY(
                    2 * Math.PI * i / N, 
                    crossCorrelation[i].Real
                );
            }

            for (int i = 0; i < fastCrossCorrelation.Length; i++)
            {
                targetCharts[1].Series[1].Points.AddXY(
                    2 * Math.PI * i / N, 
                    fastCrossCorrelation[i].Real
                );
            }

            string percents = string.Format("{0:00}%", fastTime * 100 / time);

            label1.Text = $"Прямая корреляция заняла:\n {time}" +
                $"\n\nБыстрая корреляция заняла:\n {fastTime}" +
                $"\n\nОтношение в процентах:\n {percents}";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (comboBox1.SelectedIndex)
            {
                case 0:
                    Calculate(СorrelationType.Cross);
                    break;
                case 1:
                    Calculate(СorrelationType.Auto);
                    break;
                default:
                    return;
            }
        }
    }
}
