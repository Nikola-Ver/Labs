using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Program
{
    class LogBuffer
    {
        public Queue<string> ReadedItems = new Queue<string>();
        public bool programWorks = true;

        private Queue<string> Buffer = new Queue<string>();
        private int numOfItemsToWrite = 0;
        private const int maxCountOfItems = 5;

        public void Add(string item)
        {
            if (Buffer.Count < maxCountOfItems)
            {
                Buffer.Enqueue(item);
                Console.WriteLine("New line {0}, number of messages {1}", item, Buffer.Count);
            }

            if (Buffer.Count >= maxCountOfItems)
            {
                Console.WriteLine("\nNumber of elements to unload (overflowed) {0}\n", maxCountOfItems);
                numOfItemsToWrite = maxCountOfItems;
            }
        }

        public void TimerRead(Object source, System.Timers.ElapsedEventArgs e)
        {
            if (numOfItemsToWrite == 0 && ReadedItems.TryDequeue(out var item)) Add(item);
            else 
            { 
                if (ReadedItems.Count > 0) Console.WriteLine("Failed to write a new line");
                if (Buffer.Count == 0 && ReadedItems.Count == 0) programWorks = false;
            }
        }

        public void TimerWrite(Object source, System.Timers.ElapsedEventArgs e)
        {
            Console.WriteLine("\nNumber of elements to unload (timer) {0}\n", Buffer.Count);
            numOfItemsToWrite = Buffer.Count;
        }

        public async void WriteAsync()
        {
            using (StreamWriter writer = new StreamWriter("RecordedItems.txt", append: true))
            {
                if (numOfItemsToWrite > 0 && Buffer.TryDequeue(out var item))
                {
                    await writer.WriteLineAsync(item);
                    numOfItemsToWrite--;
                    Console.WriteLine("New line written {0}", item);
                }
            }
        }
    }
}
