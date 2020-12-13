#include <iostream>
#include <windows.h>

typedef int FindIntegerValueInProcessMemory(int valueSize, long long int valueToFind);
typedef int ChangeAllFindedIntegerValuesInProcessMemory(int valueSize, long long int newValue);

int main()
{
    long long int bee = 19411945;

    FindIntegerValueInProcessMemory* pFind;
    ChangeAllFindedIntegerValuesInProcessMemory* pChange;
    HMODULE handle = LoadLibrary(L"MemoryScanDll.dll");

    pFind = (FindIntegerValueInProcessMemory*)
        GetProcAddress(handle, "FindIntegerValueInProcessMemory");
    pChange = (ChangeAllFindedIntegerValuesInProcessMemory*)
        GetProcAddress(handle, "ChangeAllFindedIntegerValuesInProcessMemory");

    std::cout << "Variable value: ";
    std::cout << bee;
    std::cout << "\n";

    pFind(sizeof(bee), bee);

    std::cout << "Enter new value >>> ";
    long long int newValue = 0;
    std::cin >> newValue;

    pChange(sizeof(bee), newValue);

    std::cout << "Variable value: ";
    std::cout << bee;
    std::cout << "\n";

    system("Pause");
}
