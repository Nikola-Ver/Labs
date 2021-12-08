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
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
uint8_t pin1_is_enabled = 0;
uint8_t pin2_is_enabled = 0;
uint8_t pin4_is_enabled = 0;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

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
	uint32_t hal_tick = 50;
	uint8_t is_lit = 1;
	uint32_t tapTime = 0;

	uint32_t nextMoveTick = 0;
	uint8_t state = 0;
	
	uint32_t tapDelay = 50;
	
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
		if (pin1_is_enabled == 1)
		{
			is_lit = !is_lit;
			pin1_is_enabled = 2;
			tapTime = HAL_GetTick();
		}
		if (pin1_is_enabled == 2)
		{
			if (HAL_GetTick() > tapTime + tapDelay)
			{
				pin1_is_enabled = 0;
			}
		}
		
		if (pin2_is_enabled == 1)
		{
			if (hal_tick > 25) {
				hal_tick -= 25;
			}
			
			pin2_is_enabled = 2;
			tapTime = HAL_GetTick();
		}
		if (pin2_is_enabled == 2)
		{
			if (HAL_GetTick() > tapTime + tapDelay)
			{
				pin2_is_enabled = 0;
			}
		}
		
		if (pin4_is_enabled == 1)
		{
			if (hal_tick < 100) {
				hal_tick += 25;
			}
			
			pin4_is_enabled = 2;
			tapTime = HAL_GetTick();
		}
		if (pin4_is_enabled == 2)
		{
			if (HAL_GetTick() > tapTime + tapDelay)
			{
				pin4_is_enabled = 0;
			}
		}
		
	
		if (is_lit && HAL_GetTick() > nextMoveTick)
		{
			nextMoveTick = HAL_GetTick() + hal_tick;
			
			HAL_GPIO_WritePin(GPIOC, D14_Pin|D15_Pin|D16_Pin|D17_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(GPIOA, D13_Pin|D12_Pin|D11_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(D10_GPIO_Port, D10_Pin, GPIO_PIN_RESET);
			
			switch (state) {
				case 0:
					HAL_GPIO_WritePin(D10_GPIO_Port, D10_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOA, D11_Pin, GPIO_PIN_SET);
					break;
				case 1:
					HAL_GPIO_WritePin(GPIOA, D11_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOA, D12_Pin, GPIO_PIN_SET);
					break;
				case 2:
					HAL_GPIO_WritePin(GPIOA, D12_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOA, D13_Pin, GPIO_PIN_SET);
					break;
				case 3:
					HAL_GPIO_WritePin(GPIOA, D13_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOC, D14_Pin, GPIO_PIN_SET);
					break;
				case 4:
					HAL_GPIO_WritePin(GPIOC, D14_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOC, D15_Pin, GPIO_PIN_SET);
					break;
				case 5:
					HAL_GPIO_WritePin(GPIOC, D15_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOC, D16_Pin, GPIO_PIN_SET);
					break;
				case 6:
					HAL_GPIO_WritePin(GPIOC, D16_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(GPIOC, D17_Pin, GPIO_PIN_SET);
					break;
				case 7:
					HAL_GPIO_WritePin(GPIOC, D17_Pin, GPIO_PIN_SET);
					HAL_GPIO_WritePin(D10_GPIO_Port, D10_Pin, GPIO_PIN_SET);
					break;
			}
			
			state = (state + 1) % 8;
		} 
		else if (!is_lit) 
		{
			HAL_GPIO_WritePin(GPIOC, D14_Pin|D15_Pin|D16_Pin|D17_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(GPIOA, D13_Pin|D12_Pin|D11_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(D10_GPIO_Port, D10_Pin, GPIO_PIN_RESET);
		}
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
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL16;
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

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

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

