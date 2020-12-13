using System;

namespace DynamicListMPP
{
    class Program
    {
        const int LIST_LENGTH = 25;
        const int MIN_VALUE = 0;
        const int MAX_VALUE = 10;

        static void Main(string[] args)
        {
            Random rnd = new Random();
            DynamicList<int> dynamicList = new DynamicList<int>();

            for (int i = 0; i < LIST_LENGTH; i++)
            {
                dynamicList.Add(rnd.Next(MIN_VALUE, MAX_VALUE));
            }

            Console.Write("Source array: ");
            foreach (var element in dynamicList)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine("\nLength of array: " + dynamicList.Count);

            for (int i = 0; i < dynamicList.Count - 1; i++)
            {
                for (int j = i + 1; j < dynamicList.Count; j++)
                {
                    if (dynamicList[i] > dynamicList[j])
                    {
                        int temp = dynamicList[i];
                        dynamicList[i] = dynamicList[j];
                        dynamicList[j] = temp;
                    }
                }
            }

            Console.Write("\nSorted array: ");
            foreach (var element in dynamicList)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine("\nLength of array: " + dynamicList.Count);

            int deletingNum = rnd.Next(MIN_VALUE, MAX_VALUE);
            Console.WriteLine("\nDeleting number: " + deletingNum);

            for (int i = 0; i < dynamicList.Count; i++)
            {
                if (dynamicList[i] == deletingNum) dynamicList.RemoveAt(i--);
            }

            Console.Write("Array after removing the number: ");
            foreach (var element in dynamicList)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine("\nLength of array: " + dynamicList.Count);

            dynamicList.Remove();
            Console.Write("\nArray after removing the last number: ");
            foreach (var element in dynamicList)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine("\nLength of array: " + dynamicList.Count);

            dynamicList.Clear();
            Console.Write("\nArray after cleaning: ");
            foreach (var element in dynamicList)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine("\nLength of array: " + dynamicList.Count);

            Console.ReadKey();
        }
    }
}
