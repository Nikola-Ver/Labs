using System;
using System.IO;
using System.Timers;

namespace Program
{
    class Program
    {
        private static Timer timerWrite;
        const int delayWrite = 15000;

        private static Timer timerRead;
        const int delayRead = 2000;

        const string path = "ReadItems.txt";

        public static void Main()
        {
            var buffer = new LogBuffer();
            using (StreamReader sr = new StreamReader(path, System.Text.Encoding.Default))
            {
                string line;
                while ((line = sr.ReadLine()) != null)
                {
                    buffer.ReadedItems.Enqueue(line);
                }
            }

            timerWrite = new System.Timers.Timer();
            timerWrite.Interval = delayWrite;
            timerWrite.Elapsed += buffer.TimerWrite;
            timerWrite.AutoReset = true;
            timerWrite.Enabled = true;

            timerRead = new System.Timers.Timer();
            timerRead.Interval = delayRead;
            timerRead.Elapsed += buffer.TimerRead;
            timerRead.AutoReset = true;
            timerRead.Enabled = true;

            while (buffer.programWorks) 
            {
                buffer.WriteAsync();
            }

        }
    }
}
