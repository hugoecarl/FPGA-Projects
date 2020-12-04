#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

int main(void){
  unsigned int led = 0;
  unsigned int speed = 0;

  while(1){

	  if (IORD_32DIRECT(PIO_BOT_BASE,0) & 0x08){
			  if (led < 4){
				  if(IORD_32DIRECT(PIO_BOT_BASE,0) & 0x04){
					  IOWR_32DIRECT(PIO_MOT_BASE, 0, 0x08 >> led++);
				  }
				  else{
					  IOWR_32DIRECT(PIO_MOT_BASE, 0, 0x01 << led++);
				  }
				  usleep(speed);
			  }
			  else{
				  led = 0;
			  }
	  }

	  if ((IORD_32DIRECT(PIO_BOT_BASE,0) & 0x02) && !(IORD_32DIRECT(PIO_BOT_BASE,0) & 0x01)){
		  speed = 60000;
	  }
	  else if ((IORD_32DIRECT(PIO_BOT_BASE,0) & 0x01) && !(IORD_32DIRECT(PIO_BOT_BASE,0) & 0x02)){
		  speed = 20000;
	  }
	  else if (IORD_32DIRECT(PIO_BOT_BASE,0) & 0x03){
		  speed = 6000;
	  }
	  else{
		  speed = 100000;
	  }

  };
  return 0;
}
