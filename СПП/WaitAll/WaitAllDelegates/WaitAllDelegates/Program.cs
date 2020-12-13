using System;
using System.Collections.Generic;
using System.Threading;

namespace WaitAllDelegates
{
    class Program
    {
        const int countOfTasks = 1000;

        static void printHi(Object obj)
        {
            Console.WriteLine("Hi");
        }

        static void Main(string[] args)
        {
            WaitCallback print = new WaitCallback(printHi);
            Queue<WaitCallback> queue = new Queue<WaitCallback>();
            for (int i = 0; i < countOfTasks; i++)
            {
                queue.Enqueue(print);
            }
            Parallel.WaitAll(queue);
        }
    }
}
