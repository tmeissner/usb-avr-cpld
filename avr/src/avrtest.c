#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>

#ifndef F_CPU
  #warning "F_CPU wasn't set in makefile, so we do it now with 10.0 MHz"
  #define F_CPU 10000000UL
#endif


// setting baud rate
#define BAUD 9600UL

// uart baud rate checks
#define UBRR_VAL ((F_CPU+BAUD*8)/(BAUD*16)-1)
#define BAUD_REAL (F_CPU/(16*(UBRR_VAL+1)))
#define BAUD_ERROR ((BAUD_REAL*1000)/BAUD)

#if ((BAUD_ERROR<990) || (BAUD_ERROR>1010))
  #warning baudrate error higher than 1%! 
#endif


static void uart_init (void);
static void uart_putc (unsigned char c);

volatile uint8_t got_char;
volatile unsigned char rx_char;

int main (void)
{

  // uart rx initialisation
  uart_init();

  // activate global interrupts
  sei();

  while(1)
  {
    if(got_char) {
      UCSR0B &= ~(1<<RXCIE0);
      uart_putc(rx_char);
      got_char = 0;
      UCSR0B |= (1<<RXCIE0);
    }
  }

  return 0;

}


// function to init uart
static void uart_init (void) {
  // set baudrate registers (high byte first!)
  UBRR0H = UBRR_VAL >> 8;
  UBRR0L = UBRR_VAL & 0xFF;
  // tx  enable
  UCSR0B |= (1<<TXEN0) | (1<<RXEN0) | (1<<RXCIE0);
  // frame format: async mode, no parity, 1 stop bit, 8 bit size
  UCSR0C |= (3<<UCSZ00);	
}


// send a byte on uart
static void uart_putc (unsigned char c) {
  while (!(UCSR0A & (1<<UDRE0))) {}
  UDR0 = c;
}


ISR(USART_RX_vect) {
  uint8_t rx_error = 0;
  //check for frame error
  if (UCSR0A & (1<<FE0)) {
    rx_error = 1;
  }
  // save rx buffer
  rx_char = UDR0;
  // signalise the new rx char if no frame error occured
  if (!rx_error) {
    got_char = 1;
  }
}
