using System;
using System.IO;

namespace HandleManagmend
{
    class Program
    {
        static void Main()
        {
            FileStream fs1 = new FileStream("newFile1.txt", FileMode.OpenOrCreate);
            fs1.WriteByte(10);
            OSHandle osHandle1 = new OSHandle();
            osHandle1.Handle = fs1.Handle;
            fs1.Dispose();

            FileStream fs2 = new FileStream("newFile2.txt", FileMode.OpenOrCreate);
            fs2.WriteByte(10);
            OSHandle osHandle2 = new OSHandle();
            osHandle2.Handle = fs2.Handle;
            fs2 = null;
        }
    }
}
