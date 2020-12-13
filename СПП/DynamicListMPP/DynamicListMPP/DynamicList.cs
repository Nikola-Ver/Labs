using System;
using System.Collections;

namespace DynamicListMPP
{
    class DynamicList<Type> : IEnumerable, IEnumerator
    {

        public int Count { get; private set; }
        const int DEFAULT_SIZE = 50;
        int currentSize;
        int currentPos;

        public Type[] Items { get; private set; }

        public Type this[int index]
        {
            get
            {
                if (index >= 0 && index < Count)
                {
                    return Items[index];
                }
                throw new Exception("Invalid index");
            }
            set
            {
                if (index >= 0 && index < Count)
                {
                    Items[index] = value;
                }
                else
                {
                    throw new Exception("Invalid index");
                }
            }
        }

        public DynamicList()
        {
            Items = new Type[DEFAULT_SIZE];
            Count = 0;
            currentSize = DEFAULT_SIZE;
            currentPos = -1;
        }

        public DynamicList(int size)
        {
            if (size >= 0)
            {
                Items = new Type[size];
                currentSize = size;
                Count = 0;
                currentPos = -1;
            }
            else
            {
                throw new Exception("The size must be positive");
            }
        }

        public IEnumerator GetEnumerator()
        {
            return this;
        }

        public bool MoveNext()
        {
            if (currentPos < Count - 1)
            {
                currentPos++;
                return true;
            }
            else
            {
                Reset();
                return false;
            }
        }

        public void Reset()
        {
            currentPos = -1;
        }

        public void Add(Type element)
        {
            if (Count >= currentSize)
            {
                var newArray = Items;
                Array.Resize(ref newArray, currentSize * 2);
                Items = newArray;

                currentSize *= 2;
                Items[Count] = element;
                ++Count;
            }
            else
            {
                Items[Count] = element;
                Count++;
            }
        }

        public void Remove()
        {
            if (Count > 0)
            {
                Items[--Count] = default;
            }
            else
            {
                throw new Exception("The list is empty");
            }
        }

        public void RemoveAt(int index)
        {
            if (index < Count && index >= 0)
            {
                for (int i = index + 1; i < Count; i++)
                {
                    Items[i - 1] = Items[i];
                }
                --Count;
            }
            else
            {
                throw new Exception("Invalid index");
            }
        }

        public void Clear()
        {
            Items = new Type[currentSize];
            Count = 0;
        }

        public object Current
        {
            get => Items[currentPos];
        }
    }
}

