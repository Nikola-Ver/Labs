#pragma once

#ifdef MEMORYSCANDLL_EXPORTS
#define MEMORYSCANDLL_API __declspec(dllexport)
#else
#define MEMORYSCANDLL_API __declspec(dllimport)
#endif

extern "C" MEMORYSCANDLL_API 
int FindIntegerValueInProcessMemory(void* valueInformation);

extern "C" MEMORYSCANDLL_API 
int SelectionIntegerValueInProcessMemory(void* valueInformation);

extern "C" MEMORYSCANDLL_API 
int ChangeIntegerValueInProcessMemory(int valueSize, long long int newValue, unsigned long long int address);

extern "C" MEMORYSCANDLL_API
int ChangeAllFindedIntegerValuesInProcessMemory(void* valueInformation);
