#include "pch.h" 
#include <utility>
#include "MemoryScanDll.h"
#include <iostream>
#include <fstream>

struct BlockInformation
{
    char* blockAddress;
    int blockSize;
    long long int valueToFind;
    int valueSize;
    unsigned long long int currentMemoryAddress;
};

struct DynamicAdressMassive
{
    unsigned long long int* massive;
    unsigned long long int length;
};

struct ValueInformation 
{
	int valueSize;
	long long int valueToFind;
};

void FindIntegerValueInBlock(BlockInformation* blockInformation, std::ofstream& fileToWrite)
{
    char* block = blockInformation->blockAddress;
    long long int valueToFind = blockInformation->valueToFind;
    int blockSize = blockInformation->blockSize;
    int valueSize = blockInformation->valueSize;
    unsigned long long int currentMemoryAddress = blockInformation->currentMemoryAddress;
    unsigned long long int address = 0;

    for (int i = 0; i + valueSize - 1 < blockSize; i++)
    {
        if (valueSize == 1)
        {
            if ((char)valueToFind == block[i])
            {
                address = currentMemoryAddress + (unsigned long long int)i;   
                fileToWrite.write(((char*)(&address)), 8);
            }
        }
        if (valueSize == 2)
        {
            if ((short int)valueToFind == *((short int*)(&(block[i]))))
            {
                address = currentMemoryAddress + (unsigned long long int)i;
                fileToWrite.write(((char*)(&address)), 8);
            }
        }

        if (valueSize == 4)
        {
            if ((long int)valueToFind == *((long int*)(&(block[i]))))
            {
                address = currentMemoryAddress + (unsigned long long int)i;
                fileToWrite.write(((char*)(&address)), 8);
            }
        }
        if (valueSize == 8)
        {
            if ((long long int)valueToFind == *((long long int*)(&(block[i]))))
            {
                address = currentMemoryAddress + (unsigned long long int)i;
                fileToWrite.write(((char*)(&address)), 8);
            }
        }
    }
}

int FindIntegerValueInProcessMemory(void* valueInformation)
{
	int valueSize = ((ValueInformation *)valueInformation)->valueSize;
	long long int valueToFind = ((ValueInformation*)valueInformation)->valueToFind;

	LPSYSTEM_INFO information;
	information = new _SYSTEM_INFO;

	HANDLE currentProcess = GetCurrentProcess();

	GetSystemInfo(information);

	unsigned long long int minAddress, maxAddress;
	minAddress = (unsigned long long int)information->lpMinimumApplicationAddress;
	maxAddress = (unsigned long long int)information->lpMaximumApplicationAddress;

	int blockSize = 100 * 1024 * 1024;

	std::ofstream dataFile;
	dataFile.open("D:\\MyAmData\\AddressBase.txt", std::ios::out | std::ios::binary);

	char* buffer = new char[blockSize];

	BlockInformation blockInf;
	blockInf.blockAddress = buffer;
	blockInf.blockSize = blockSize;
	blockInf.currentMemoryAddress = 0;
	blockInf.valueSize = valueSize;
	blockInf.valueToFind = valueToFind;


	MEMORY_BASIC_INFORMATION memoryBaseInformation;
	unsigned long long int startAddress, endAddress;

	for (unsigned long long int currentAddress = minAddress; currentAddress < maxAddress - blockSize; )
	{
		VirtualQueryEx(currentProcess, (void*)currentAddress,
			&memoryBaseInformation, sizeof(MEMORY_BASIC_INFORMATION));

		if ((memoryBaseInformation.State == MEM_COMMIT) && (memoryBaseInformation.Protect == PAGE_READWRITE)
			&& (memoryBaseInformation.Type == MEM_PRIVATE))
		{
			startAddress = (unsigned long long int)memoryBaseInformation.BaseAddress;
			endAddress = (unsigned long long int)memoryBaseInformation.BaseAddress + memoryBaseInformation.RegionSize;

			if (ReadProcessMemory(currentProcess, (LPCVOID)startAddress, (LPVOID)buffer,
				memoryBaseInformation.RegionSize, NULL) != 0)
			{
				blockInf.blockSize = memoryBaseInformation.RegionSize;
				blockInf.currentMemoryAddress = startAddress;

				FindIntegerValueInBlock(&blockInf, dataFile);
			}
		}

		currentAddress += memoryBaseInformation.RegionSize;
	}

	return 0;
}

DynamicAdressMassive* ReadAddressesFromFile()
{
    std::ifstream addressListFile;
    addressListFile.open("D:\\MyAmData\\AddressBase.txt", std::ios::in | std::ios::binary);


    addressListFile.seekg(0, addressListFile.end);
    unsigned long long int fileLength = addressListFile.tellg();
    addressListFile.seekg(0, addressListFile.beg);

    char* addressesBuffer = new char[fileLength];

    addressListFile.read(addressesBuffer, fileLength);

    unsigned long long int* addressesMassive = new unsigned long long int[fileLength / 8];

    unsigned long long int index = 0;
    for (unsigned long long int i = 0; i < fileLength; i = i + 8)
    {
        addressesMassive[index] = *((unsigned long long int*)(&(addressesBuffer[i])));
        index++;
    }

    DynamicAdressMassive* addressesList = new DynamicAdressMassive;
    addressesList->length = fileLength / 8;
    addressesList->massive = addressesMassive;

    delete[] addressesBuffer;
    addressListFile.close();

    return addressesList;
}

int SelectionIntegerValueInProcessMemory(void* valueInformation)
{
	int valueSize = ((ValueInformation*)valueInformation)->valueSize;
	long long int newValue = ((ValueInformation*)valueInformation)->valueToFind;

    DynamicAdressMassive* addressesList;
    addressesList = ReadAddressesFromFile();

    unsigned long long int length = addressesList->length;
    unsigned long long int* addresses = addressesList->massive;

    std::ofstream newAddressesFile;
    newAddressesFile.open("D:\\MyAmData\\AddressBase.txt", std::ios::out | std::ios::binary);

    char* buffer = new char[valueSize];
    HANDLE currentProcess = GetCurrentProcess();

    unsigned long long int address = 0;

    for (unsigned long long int i = 0; i < length; i++)
    {
        if (ReadProcessMemory(currentProcess, (LPCVOID)(addressesList->massive[i]), (LPVOID)buffer, valueSize, NULL) != 0)
        {
            if (newValue == *((long long int*)(buffer)))
            {
                address = addressesList->massive[i];
                newAddressesFile.write(((char*)(&address)), 8);
            }
        }
    }

    delete[] addressesList->massive;
    delete addressesList;

    newAddressesFile.close();

    return 0;
}

int ChangeIntegerValueInProcessMemory(int valueSize, long long int newValue, unsigned long long int address)
{
    HANDLE currentProcess = GetCurrentProcess();

    long long int buffer = newValue;

    if (WriteProcessMemory(currentProcess, (LPVOID)address, (LPCVOID)(&buffer), valueSize, NULL))
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

int ChangeAllFindedIntegerValuesInProcessMemory(void* valueInformation)
{
	int valueSize = ((ValueInformation*)valueInformation)->valueSize;
	long long int newValue = ((ValueInformation*)valueInformation)->valueToFind;

    HANDLE currentProcess = GetCurrentProcess();
    long long int buffer = newValue;

    DynamicAdressMassive* addressesList;
    addressesList = ReadAddressesFromFile();

    int exitCode = 1;

    for (unsigned long long int i = 0; i < addressesList->length; i++)
    {
        if (WriteProcessMemory(currentProcess, (LPVOID)addressesList->massive[i], (LPCVOID)(&buffer), valueSize, NULL))
        {
            exitCode = 0;
        }
    }

    delete[] addressesList->massive;
    delete addressesList;

    return exitCode;
}