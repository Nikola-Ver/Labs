using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace HandleManagmend
{
    class OSHandle : IDisposable
    {
        public IntPtr Handle;
        
        private bool isDisposed;

        [DllImport("Kernel32.dll")]

        protected static extern bool CloseHandle(IntPtr handle);

        protected virtual void Dispose(bool disposing)
        {
            if (!isDisposed)
            {
                if (disposing)
                {
                    isDisposed = true;
                }
                CloseHandle(Handle);
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public OSHandle()
        {
            Handle = (IntPtr) null;
            isDisposed = false;
        }

        ~OSHandle()
        {
            Dispose(false);
        }
    }
}
