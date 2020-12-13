#include <iostream>
#include <fstream>
#include <string>
#include <queue>
#include <windows.h>

#define AMOUNTOFTHREADS 10

struct SortTask
{
    int From;
    int To;
};

class TaskListClass
{
public:
    TaskListClass() 
    {
        mutex = CreateMutex(NULL, FALSE, NULL);
    }

    void AddTask(SortTask task) 
    {
        WaitForSingleObject(mutex, INFINITE);
        taskQueue.push(task);
        ReleaseMutex(mutex);
    }

    SortTask GetTask()
    {
        SortTask task;        
        task.From = -1;
        task.To = -1;
        WaitForSingleObject(mutex, INFINITE);
        if (taskQueue.empty() == false)
        {
            task.From = taskQueue.front().From;
            task.To = taskQueue.front().To;
            taskQueue.pop();
        }
        ReleaseMutex(mutex);
        return task;            
    }

    int Count()
    {
        return taskQueue.size();
    }

    ~TaskListClass() 
    {
        CloseHandle(mutex);
    }

private:
    std::queue<SortTask> taskQueue;
    HANDLE mutex;
};

struct ThreadParameters
{
    TaskListClass* taskList;
    std::string* stringMassive;
    bool* stopFlag;
};

void SortArrayMerge(std::string* arr, long size)
{
    if (size > 1)
    {
        long const leftSize = size / 2;
        long const rightSize = size - leftSize;

        SortArrayMerge(arr, leftSize);
        SortArrayMerge(&arr[leftSize], rightSize);

        long left = 0;
        long right = leftSize;
        long step = 0;

        std::string* tempArr = new std::string[size];

        while (left < leftSize || right < size)
        {
            if (arr[left] < arr[right])
            {
                tempArr[step++] = std::move(arr[left++]);
            }
            else
            {
                tempArr[step++] = std::move(arr[right++]);
            }

            if (left == leftSize)
            {
                std::copy(std::make_move_iterator(&arr[right]),
                    std::make_move_iterator(&arr[size]),
                    &tempArr[step]);
                break;
            }

            if (right == size)
            {
                std::copy(std::make_move_iterator(&arr[left]),
                    std::make_move_iterator(&arr[leftSize]),
                    &tempArr[step]);
                break;
            }
        }

        std::copy(std::make_move_iterator(tempArr),
            std::make_move_iterator(&tempArr[size]),
            arr);
    }
}

void SortArrayPart(long from, long to, std::string* arr)
{
    for (int startPos = from; startPos <= to; ++startPos)
    {
        int smallestPos = startPos;

        for (int currentIndex = startPos; currentIndex <= to; ++currentIndex)
        {
            if (arr[currentIndex] < arr[smallestPos])
                smallestPos = currentIndex;
        }

        std::swap(arr[startPos], arr[smallestPos]);
    }
}

int ThreadMain(ThreadParameters* parameters)
{
    SortTask task;
    bool temp = false;
    ThreadParameters params = *parameters;
    TaskListClass* taskList = params.taskList;

    while (*(params.stopFlag) == 0)
    {
        task = taskList->GetTask();
        if (task.From != -1)
        {
            SortArrayPart(task.From, task.To, params.stringMassive);
        }
        else
        {
            Yield();
        }
    }
    return 0;
}

int main()
{
    LPOFSTRUCT fileInfo = new _OFSTRUCT;
    HFILE fileToRead = OpenFile("FileToRead.txt", fileInfo, OF_READ); 
    if (fileToRead == NULL)
    {
        std::cout << "Cannot open file";
        return -1;
    }

    int fileSize = GetFileSize((HANDLE)fileToRead, NULL);
    if (fileSize == 0) 
    {
        std::cout << "File is empty";
        return -1;
    }

    char* fileBuffer = new char[fileSize + 1];
    std::string fileData;

    if (ReadFile((HANDLE)fileToRead, fileBuffer, fileSize, NULL, NULL)) 
    {
        fileBuffer[fileSize] = '\0';
        fileData = std::string(fileBuffer);
    }
    else
    {
        std::cout << "File read error";
    }

    int amountOfStrings = 0;
    for (int i = 0; i < fileData.length(); i++) 
    {
        if (fileData[i] == ' ')
        {
            amountOfStrings++;
        }
    }
    amountOfStrings++;

    std::string* stringMassive = new std::string[amountOfStrings];
    int previousPosition = 0;

    for (int i = 0; i < amountOfStrings - 1; i++)
    {
        stringMassive[i] = fileData.substr(previousPosition, fileData.find(' ', previousPosition) - previousPosition);
        previousPosition = fileData.find(' ', previousPosition) + 1;
    }
    stringMassive[amountOfStrings - 1] = fileData.substr(previousPosition);
   
    CloseHandle((HANDLE)fileToRead);
    delete fileInfo;
    delete[] fileBuffer;
    fileData.clear();

    int threadsCount = AMOUNTOFTHREADS;
    TaskListClass* taskList = new TaskListClass;

    int usualBlockSize = amountOfStrings / threadsCount;
    int lastBlockSize = amountOfStrings % threadsCount;
    
    SortTask tempTask;
    for (int i = 0; i < amountOfStrings - 1; i = i + usualBlockSize)
    {
        tempTask.From = i;
        tempTask.To = usualBlockSize + i - 1;
        taskList->AddTask(tempTask);
    }
    if (lastBlockSize != 0)
    {
        tempTask.From = amountOfStrings - lastBlockSize;
        tempTask.To = amountOfStrings - 1;
        taskList->AddTask(tempTask);
    }  
    
    HANDLE* threadsMassive = new HANDLE[threadsCount];
    bool* threadStopFlags = new bool[threadsCount];
    ThreadParameters threadParams;
    threadParams.taskList = taskList;
    threadParams.stringMassive = stringMassive;
    for (int i = 0; i < threadsCount; i++)
    {
        threadStopFlags[i] = false;
        threadParams.stopFlag = &threadStopFlags[i];
        threadsMassive[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ThreadMain, &threadParams, 0, NULL);
    }

    while (taskList->Count() > 0)
    {
        Sleep(100);
    }

    for (int i = 0; i < threadsCount; i++)
    {
        threadStopFlags[i] = true;
    }

    for (int i = 0; i < threadsCount; i++)
    {
        WaitForSingleObject(threadsMassive[i], INFINITE);
    }

    SortArrayMerge(stringMassive, amountOfStrings);

    HANDLE fileToWrite = CreateFile(L"FileToWrite.txt", GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    for (int i = 0; i < amountOfStrings; i++)
    {
        WriteFile(fileToWrite, stringMassive[i].c_str(), stringMassive[i].length(), NULL, NULL);
        WriteFile(fileToWrite, " ", 1, NULL, NULL);
    }

    delete[] stringMassive;
    delete taskList;

    system("Pause");
}

