#include "LIBRARY/BIT_MATH.h"
#include "LIBRARY/STD_TYPES.h"

#include "GPIO/GPIO_interface.h"
#include "RCC/RCC_interface.h"
#include "SYSTICK/SYSTICK_interface.h"

int main(void)
{
	RCC_systemInit(); // system clock
	RCC_PeripheralClockEnable(RCC_APB2, RCC_GPIOC);
	GPIO_SetPinMode(GPIO_PORTC, PIN13, GPIO_OUTPUT_GP_PP_10MHZ);
	GPIO_SetPinValue(GPIO_PORTC, PIN13, 1);

	while(1){
		GPIO_SetPinValue(GPIO_PORTC, PIN13, 0);
		TICK_Delay(1000);
		GPIO_SetPinValue(GPIO_PORTC, PIN13, 1);
		TICK_Delay(1000);
	}
}
