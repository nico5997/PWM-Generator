#include <inttypes.h>
#include "system.h"
#include "stdio.h"
#include "io.h"

#define Period_1 1000000
#define Period_2 750000
#define DutyCycle_1 500000
#define DutyCycle_2 250000
#define PWMEnable 1
#define Polarity_1 1
#define Polarity_2 0
#define Demo 3

#define Period_bit 0
#define DutyCycle_bit 1
#define PWMEnable_bit 2
#define Polarity_bit 3

void PWMinit() {

	if (Demo == 1) {
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Period_bit*4, Period_1);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, DutyCycle_bit*4, DutyCycle_1);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, PWMEnable_bit*4, PWMEnable);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Polarity_bit*4, Polarity_1);
	}
	else if(Demo == 2) {
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Period_bit*4, Period_2);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, DutyCycle_bit*4, DutyCycle_2);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, PWMEnable_bit*4, PWMEnable);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Polarity_bit*4, Polarity_1);
	}
	else if(Demo == 3)  {
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Period_bit*4, Period_2);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, DutyCycle_bit*4, DutyCycle_2);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, PWMEnable_bit*4, PWMEnable);
		IOWR_32DIRECT(AVALON_PWM_0_BASE, Polarity_bit*4, Polarity_2);
	}
}
int main(void) {

  printf("Hello from Nios II!\n");
  PWMinit();

  while(1)

  return 0;
}
