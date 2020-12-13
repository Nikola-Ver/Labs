using System;
using System.Threading;

namespace lab3_2_
{
    class Program
    {
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello World!");
            OSHandle oSHandle;
            oSHandle = new OSHandle();
            oSHandle.Handle = 2324;
            oSHandle = null;

            oSHandle = new OSHandle();
            oSHandle.Handle = 2322134;
            oSHandle.Dispose();

            Thread.Sleep(1000);
        }
    }
}
