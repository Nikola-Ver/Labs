#include <iostream>
#include <fstream>
#include <windows.h>

struct ValueInformation
{
	int valueSize;
	long long int valueToFind;
};

struct DynamicAdressMassive
{
	unsigned long long int* massive;
	unsigned long long int length;
};

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

void ShowResults()
{
	std::cout << "------\n";
	DynamicAdressMassive* remainAdresses = new DynamicAdressMassive;
	remainAdresses = ReadAddressesFromFile();
	for (unsigned long long int i = 0; i < remainAdresses->length; i++)
	{
		std::cout << i + 1;
		std::cout << ") ";
		printf("%x\n", remainAdresses->massive[i]);
	}
	std::cout << "------\n";
}

int main()
{
	char buffer[300];
	std::string str("D:\\Dll\\MemoryScanDll.dll");
	std::size_t length = str.copy(buffer, str.length(), 0);
	buffer[length] = '\0';

	int PID;
	std::cout << "Enter process PID: ";
	std::cin >> PID;

	HANDLE processHandle = OpenProcess(PROCESS_ALL_ACCESS, TRUE, PID);

	LPVOID address = VirtualAllocEx(processHandle, NULL, 300, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
	BOOL isWrite = WriteProcessMemory(processHandle, address, buffer, length + 1, NULL);

	LPVOID loadLibraryAddress = (LPVOID)GetProcAddress(GetModuleHandle(L"kernel32.dll"), "LoadLibraryA");
	HANDLE loadRemoteThread = CreateRemoteThread(processHandle, NULL, 0, (LPTHREAD_START_ROUTINE)loadLibraryAddress, address, NULL, NULL);
	DWORD ErrorID = GetLastError();

	WaitForSingleObject(loadRemoteThread, INFINITE);
	DWORD threadReturns = 0;
	GetExitCodeThread(loadRemoteThread, &threadReturns);


	std::cout << "Choose type:\n";
	std::cout << "1) byte\n";
	std::cout << "2) int(16 bit)\n";
	std::cout << "3) int(32 bit)\n";
	std::cout << "4) int(64 bit)\n";
	std::cout << "0) Exit\n";
	std::cout << ">>> ";

	int selector = 0;
	std::cin >> selector;

	if (selector == 0)
	{
		return 0;
	}

	long long int valueToFind = 0;
	std::cout << "Enter value>>> ";
	std::cin >> valueToFind;

	int valueSize = 0;

	switch (selector)
	{
	case 1:
		valueSize = 1;
		break;
	case 2:
		valueSize = 2;
		break;
	case 3:
		valueSize = 4;
		break;
	case 4:
		valueSize = 8;
		break;
	default:
		return 0;
		break;
	}

	ValueInformation valueInformation;
	valueInformation.valueSize = valueSize;
	valueInformation.valueToFind = valueToFind;

	LPVOID paramsAddress = VirtualAllocEx(processHandle, NULL, 12, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
	BOOL isWriteParams = WriteProcessMemory(processHandle, paramsAddress, &valueInformation, sizeof(ValueInformation), NULL);
	HANDLE dllRemoteThread = CreateRemoteThread(processHandle, NULL, NULL, (LPTHREAD_START_ROUTINE)(threadReturns + 70777), paramsAddress, NULL, NULL);
	
	WaitForSingleObject(dllRemoteThread, INFINITE);


	ShowResults();

	std::cout << "Enter new value>>> ";
	std::cin >> valueToFind;
	while (valueToFind != 0)
	{
		valueInformation.valueToFind = valueToFind;
		isWriteParams = WriteProcessMemory(processHandle, paramsAddress, &valueInformation, sizeof(ValueInformation), NULL);
		dllRemoteThread = CreateRemoteThread(processHandle, NULL, NULL, (LPTHREAD_START_ROUTINE)(threadReturns + 70102), paramsAddress, NULL, NULL);

		ShowResults();
		std::cout << "Enter new value>>> ";
		std::cin >> valueToFind;
	}

	long long int newValue = 0;
	std::cout << "Enter new value>>> ";
	std::cin >> newValue;


	valueInformation.valueToFind = newValue;
	isWriteParams = WriteProcessMemory(processHandle, paramsAddress, &valueInformation, sizeof(ValueInformation), NULL);
	dllRemoteThread = CreateRemoteThread(processHandle, NULL, NULL, (LPTHREAD_START_ROUTINE)(threadReturns + 69932), paramsAddress, NULL, NULL);

	system("Pause");
}