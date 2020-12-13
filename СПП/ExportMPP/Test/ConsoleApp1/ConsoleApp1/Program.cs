using System;

namespace ConsoleApp1
{
    [ExportClass]
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }

        public void sayHi()
        {
            Console.WriteLine("Hi");
        }

        public void sayPrivet()
        {
            Console.WriteLine("Hi");
        }

        public int yse = 2;

        public int Sum(int a, int b)
        {
            return a + b;
        }

        public int Sub(int a, int b)
        {
            return a - b;
        }
    }
}
