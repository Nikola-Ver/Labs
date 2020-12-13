using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

namespace WaitAllDelegates
{
    class Parallel
    {
        public static void WaitAll(Queue<WaitCallback> delegates)
        {
            int counOfTasks = delegates.Count;

            while (delegates.TryDequeue(out var _delegate))
            {
                ThreadPool.QueueUserWorkItem(_delegate);
            }

            while (ThreadPool.CompletedWorkItemCount <= counOfTasks)
            {
                Thread.Yield();
            }

            Console.WriteLine(ThreadPool.CompletedWorkItemCount);
            Console.WriteLine(counOfTasks);
        }
    }
}
