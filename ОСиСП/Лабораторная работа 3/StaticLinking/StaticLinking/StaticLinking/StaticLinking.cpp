#include <iostream>
#include "MemoryScanDll.h"
#include <fstream>

int main()
{
    long long int bee = 19411945;

    std::cout << "Variable value: ";
    std::cout << bee;
    std::cout << "\n";
    
    FindIntegerValueInProcessMemory(sizeof(bee), bee);

    std::cout << "Enter new value >>> ";
    long long int newValue = 0;
    std::cin >> newValue;

    ChangeAllFindedIntegerValuesInProcessMemory(sizeof(bee), newValue);

    std::cout << "Variable value: ";
    std::cout << bee;
    std::cout << "\n";

    system("Pause");
}
