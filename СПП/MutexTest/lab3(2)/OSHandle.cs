using System;
using System.Collections.Generic;
using System.Text;

namespace lab3_2_
{
    class OSHandle : IDisposable
    {
        public int Handle;
        bool IsDisposed;

        public OSHandle() 
        {
            Handle = 0;
            IsDisposed = false;
        }

        public void Dispose() 
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (IsDisposed == false)
            {
                if (disposing == true)
                {
                    Handle = 0;
                }

                IsDisposed = true;
            }
        }

        ~OSHandle() 
        {
            Dispose(false);
        }
    }
}
