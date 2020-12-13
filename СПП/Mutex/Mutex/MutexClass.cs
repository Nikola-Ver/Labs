using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

namespace Mutex
{
    class MutexClass
    {
        public MutexClass() { }

        private int isLocked = 0;

        public void Lock()
        {
            while (Interlocked.CompareExchange(ref isLocked, 1, 0) != 0)
            {
                Thread.Yield();
            }
        }

        public void Unlock()
        {
            Interlocked.Exchange(ref isLocked, 0);
        }

    }
}
