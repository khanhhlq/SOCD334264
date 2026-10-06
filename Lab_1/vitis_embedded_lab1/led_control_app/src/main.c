#include "xparameters.h"
#include "xgpio.h"
#include "xstatus.h"
#include "sleep.h"

#define GPIO_BASEADDR   XPAR_XGPIO_0_BASEADDR
#define LED_CHANNEL     1
#define LED_MASK        0x0F

int main(void)
{
    XGpio Gpio;
    int Status;
    u32 led_value = 0x01;

    /* Initialize AXI GPIO */
    Status = XGpio_Initialize(&Gpio, GPIO_BASEADDR);

    if (Status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }

    /* Configure GPIO channel 1 as output */
    XGpio_SetDataDirection(&Gpio, LED_CHANNEL, 0x00);

    while (1)
    {
        XGpio_DiscreteWrite(&Gpio, LED_CHANNEL, led_value);

        sleep(1);

        led_value <<= 1;

        if (led_value > LED_MASK)
        {
            led_value = 0x01;
        }
    }

    return XST_SUCCESS;
}