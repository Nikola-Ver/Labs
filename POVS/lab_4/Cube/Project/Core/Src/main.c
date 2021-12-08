/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "usart.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
#define BUTTON_DELAY 200
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
uint8_t pressedA1 = 0;
uint8_t pressedA2 = 0;
uint32_t button1PressTime = 0;
uint32_t button2PressTime = 0;
uint8_t isStopwatchRunning = 0;
uint8_t isStopwatchPaused = 0;
uint32_t stopwatchStartTime = 0;
uint32_t pauseStartTime = 0;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */
void writeByte(uint8_t val);
void beginDisplayWrite(void);
void endDisplayWrite(void);
uint8_t translateDigit(uint8_t value);
void writeDigit(uint8_t digit, uint8_t pos, uint8_t showDot);
void writeMsecToDisplay(uint32_t msec);
void handleButtons(void);
void handleLEDs(void);
void handleDisplay(void);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_USART2_UART_Init();
  /* USER CODE BEGIN 2 */
	
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
		
		handleButtons();
		handleLEDs();
		handleDisplay();
		
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI_DIV2;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */
void handleDisplay()
{
	if (isStopwatchRunning == 1) 
		{
			if (isStopwatchPaused == 1) 
			{
				writeMsecToDisplay(pauseStartTime - stopwatchStartTime);
			} 
			else
			{
				writeMsecToDisplay(HAL_GetTick() - stopwatchStartTime);
			}
		}
		else
		{
			writeMsecToDisplay(0);
		}
}

void handleLEDs()
{
	if (isStopwatchPaused == 1)
	{
		HAL_GPIO_WritePin(GPIOA, D13_Pin|D12_Pin, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, D11_Pin, GPIO_PIN_SET);
		return;
	}
	
	if (isStopwatchRunning == 1)
	{
		HAL_GPIO_WritePin(GPIOA, D13_Pin|D11_Pin, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, D12_Pin, GPIO_PIN_SET);
		return;
	}
	
	if (isStopwatchRunning == 0)
	{
		HAL_GPIO_WritePin(GPIOA, D12_Pin|D11_Pin, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, D13_Pin, GPIO_PIN_SET);
		return;
	}
	
	HAL_GPIO_WritePin(GPIOA, D13_Pin|D12_Pin|D11_Pin, GPIO_PIN_RESET);
}

void handleButtons()
{
		if (pressedA1 == 1)
		{
			button1PressTime = HAL_GetTick();
			pressedA1 = 2;
			
			if (isStopwatchRunning == 0) 
			{
				isStopwatchPaused = 0;
				pauseStartTime = 0;
				
				isStopwatchRunning = 1;
				stopwatchStartTime = HAL_GetTick();
			} 
			else 
			{
				isStopwatchPaused = 0;
				pauseStartTime = 0;
				
				isStopwatchRunning = 0;
				stopwatchStartTime = 0;
			}
		}
		if (pressedA1 == 2 && button1PressTime + BUTTON_DELAY < HAL_GetTick())
		{
			pressedA1 = 0;
		}
		
		if (pressedA2 == 1)
		{
			button2PressTime = HAL_GetTick();
			pressedA2 = 2;
			
			if (isStopwatchRunning == 1) 
			{
				if (isStopwatchPaused == 0) 
				{
					isStopwatchPaused = 1;
					pauseStartTime = HAL_GetTick();
				} 
				else
				{
					stopwatchStartTime = stopwatchStartTime + HAL_GetTick() - pauseStartTime;
					isStopwatchPaused = 0;
					pauseStartTime = 0;
				}
			}
		}
		if (pressedA2 == 2 && button2PressTime + BUTTON_DELAY < HAL_GetTick())
		{
			pressedA2 = 0;
		}
}

void writeByte(uint8_t val)
{
	uint8_t i;

	for (i = 0; i < 8; i++) {
		if (!!(val & (1 << i)) == 1) {
			HAL_GPIO_WritePin(GPIOA, DS_Pin, GPIO_PIN_SET);
		} else {
			HAL_GPIO_WritePin(GPIOA, DS_Pin, GPIO_PIN_RESET);
		}
		
		HAL_GPIO_WritePin(GPIOA, SH_CP_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOA, SH_CP_Pin, GPIO_PIN_RESET);     
	}
}

void beginDisplayWrite() {
	HAL_GPIO_WritePin(GPIOB, ST_CP_Pin, GPIO_PIN_RESET); 
}

void endDisplayWrite() {
	HAL_GPIO_WritePin(GPIOB, ST_CP_Pin, GPIO_PIN_SET); 
}

uint8_t translateDigit(uint8_t value) {
	switch (value) {
		case 0:
			return 0xFC; // 11111100
		case 1:
			return 0x60; // 01100000
		case 2:
			return 0xDA; // 11011010
		case 3:
			return 0xF2; // 11110010
		case 4:
			return 0x66; // 01100110
		case 5:
			return 0xB6; // 10110110
		case 6:
			return 0xBE; // 10111110
		case 7:
			return 0xE0; // 11100000
		case 8:
			return 0xFE; // 11111110
		case 9:
			return 0xF6; // 11110110
	}
	
	return 0x0;
}

void writeDigit(uint8_t digit, uint8_t pos, uint8_t showDot) {
	if (pos > 3) {
		return;
	}
	
	if (digit > 9) {
		return;
	}
	
	uint8_t d = translateDigit(digit);
	if (showDot) {
		d = d | 0x01;
	}
	
	beginDisplayWrite();
	writeByte(d);
	writeByte(0xEF << pos);
	endDisplayWrite();
}

void writeMsecToDisplay(uint32_t msec) {
	msec = msec / 100;
	
	uint8_t pos = 0;
	while (pos <= 1 || (pos <= 3 && msec > 0)) {
		writeDigit(msec % 10, pos, pos == 1);
		msec = msec / 10;
		pos++;
	}
}
/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

