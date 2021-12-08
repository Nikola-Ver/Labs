using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab5
{

    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            int queueCount = Convert.ToInt32(textBox3.Text);
            int n = Convert.ToInt32(textBox2.Text);
            double time = Convert.ToInt32(textBox1.Text);
            var model = new Model(time, n, queueCount);
            ModelResult modelResult = model.Run();

            double spend = (n * 2 + 0.3 * queueCount) * time;
            double get = modelResult.ProcessedRequests * 4;

            label14.Text = spend.ToString();
            label13.Text = get.ToString();
            label15.Text = (get - spend).ToString();
        }

        private void label13_Click(object sender, EventArgs e)
        {

        }
    }

    public class Model
    {
        private int _queueMax = 0;
        private int _queueCount = 0;
        private double _lambda = 4;
        private double _currentTime = 0;
        private double _endTime;
        private double _nextRequestGenerationTime;
        private const double _processTime = 0.8;
        private List<double?> _consumersFinishTime = new List<double?>();

        private int lamb = 0;

        ModelResult modelResult = new ModelResult();

        public Model(double endTime, int countConsumers, int queueCount)
        {
            _endTime = endTime;
            _queueMax = queueCount;
            for (int i = 0; i < countConsumers; i++)
            {
                _consumersFinishTime.Add(null);
            }
        }

        public ModelResult Run()
        {
            CalculateNextGeneration();

            while (_currentTime < _endTime)
            {
                var nextProcessedIndex = NextRequestProcessedIndex();
                if (_consumersFinishTime[nextProcessedIndex] < _nextRequestGenerationTime)
                {
                    _currentTime = _consumersFinishTime[nextProcessedIndex].Value;
                    modelResult.ProcessedRequests++;
                    if (_queueCount > 0)
                    {
                        _queueCount--;
                        _consumersFinishTime[nextProcessedIndex] = _currentTime + _processTime;
                    }
                    else
                    {
                        _consumersFinishTime[nextProcessedIndex] = null;
                    }
                }
                else
                {
                    _currentTime = _nextRequestGenerationTime;
                    modelResult.GeneratedRequests++;
                    var freeIndex = FreeConsumerIndex();
                    if (freeIndex == -1)
                    {
                        if (_queueCount >= _queueMax)
                        {
                            modelResult.DroppedRequests++;
                        }
                        else
                        {
                            _queueCount++;
                        }
                    }
                    else
                    {
                        _consumersFinishTime[freeIndex] = _currentTime + _processTime;
                    }
                    CalculateNextGeneration();
                }
            }

            return modelResult;
        }

        private void CalculateNextGeneration()
        {
            _nextRequestGenerationTime = _currentTime + SimpleStream.Next(_lambda);

            lamb++;

        }

        private int FreeConsumerIndex()
        {
            return _consumersFinishTime.IndexOf(null);
        }


        private int NextRequestProcessedIndex()
        {
            var minIndex = 0;
            for (int i = 1; i < _consumersFinishTime.Count(); i++)
            {
                if (_consumersFinishTime[i] < _consumersFinishTime[minIndex])
                {
                    minIndex = i;
                }
            }
            return minIndex;
        }
    }

    public class ModelResult
    {
        public int GeneratedRequests = 0;
        public int ProcessedRequests = 0;
        public int DroppedRequests = 0;
    }

    class SimpleStream
    {
        private static readonly Random random = new Random();

        public static double Next(double lambda)
        {
            return -1 * Math.Log(random.NextDouble(), Math.E) / lambda;
        }
    }

   
}
