using System;
using System.Threading;

namespace Mutex
{
    class Program
    {
        static MutexClass Mutex = new MutexClass();

        static private void ShowMessage1()
        {
            Mutex.Lock();
            for (int i = 0; i < 5; i++)
                Console.WriteLine("String 1");
            Console.WriteLine("______________");
            Mutex.Unlock();
        }

        static private void ShowMessage2()
        {
            Mutex.Lock();
            for (int i = 0; i < 5; i++)
                Console.WriteLine("String 2");
            Console.WriteLine("______________");
            Mutex.Unlock();
        }

        static private void ShowMessage3()
        {
            Mutex.Lock();
            for (int i = 0; i < 5; i++)
                Console.WriteLine("String 3");
            Console.WriteLine("______________");
            Mutex.Unlock();
        }

        static void Main(string[] args)
        {
            Thread thread1 = new Thread(new ThreadStart(ShowMessage1));
            thread1.Start();
            Thread thread2 = new Thread(new ThreadStart(ShowMessage2));
            thread2.Start();
            ShowMessage3();
        }
    }
}
