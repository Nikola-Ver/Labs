/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */
extern uint8_t pin1_is_enabled;
extern uint8_t pin2_is_enabled;
extern uint8_t pin4_is_enabled;
/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define D14_Pin GPIO_PIN_0
#define D14_GPIO_Port GPIOC
#define D15_Pin GPIO_PIN_1
#define D15_GPIO_Port GPIOC
#define D16_Pin GPIO_PIN_2
#define D16_GPIO_Port GPIOC
#define D17_Pin GPIO_PIN_3
#define D17_GPIO_Port GPIOC
#define A0_Pin GPIO_PIN_0
#define A0_GPIO_Port GPIOA
#define A0_EXTI_IRQn EXTI0_IRQn
#define A1_Pin GPIO_PIN_1
#define A1_GPIO_Port GPIOA
#define A1_EXTI_IRQn EXTI1_IRQn
#define USART_TX_Pin GPIO_PIN_2
#define USART_TX_GPIO_Port GPIOA
#define USART_RX_Pin GPIO_PIN_3
#define USART_RX_GPIO_Port GPIOA
#define A2_Pin GPIO_PIN_4
#define A2_GPIO_Port GPIOA
#define A2_EXTI_IRQn EXTI4_IRQn
#define D13_Pin GPIO_PIN_5
#define D13_GPIO_Port GPIOA
#define D12_Pin GPIO_PIN_6
#define D12_GPIO_Port GPIOA
#define D11_Pin GPIO_PIN_7
#define D11_GPIO_Port GPIOA
#define TMS_Pin GPIO_PIN_13
#define TMS_GPIO_Port GPIOA
#define TCK_Pin GPIO_PIN_14
#define TCK_GPIO_Port GPIOA
#define SWO_Pin GPIO_PIN_3
#define SWO_GPIO_Port GPIOB
#define D10_Pin GPIO_PIN_6
#define D10_GPIO_Port GPIOB
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
