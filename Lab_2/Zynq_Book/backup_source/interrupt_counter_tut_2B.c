#include "xparameters.h"
#include "xgpio.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"

//----------------------------------------------------
// PARAMETER DEFINITIONS
// Adapted for Vitis 2026.1 / SDT flow
//----------------------------------------------------

// Interrupt controller base address
#define INTC_BASEADDR              XPAR_XSCUGIC_0_BASEADDR

// AXI GPIO base addresses
#define BTNS_BASEADDR              XPAR_AXI_GPIO_0_BASEADDR
#define LEDS_BASEADDR              XPAR_AXI_GPIO_1_BASEADDR

// GPIO interrupt ID
#define INTC_GPIO_INTERRUPT_ID     XPAR_FABRIC_AXI_GPIO_0_INTR

// GPIO Channel 1 interrupt mask
#define BTN_INT                    XGPIO_IR_CH1_MASK


//----------------------------------------------------
// GLOBAL VARIABLES
//----------------------------------------------------

XGpio LEDInst;
XGpio BTNInst;
XScuGic INTCInst;

static int led_data = 0;
static int btn_value = 0;


//----------------------------------------------------
// PROTOTYPE FUNCTIONS
//----------------------------------------------------

static void BTN_Intr_Handler(void *InstancePtr);

static int InterruptSystemSetup(
        XScuGic *XScuGicInstancePtr);

static int IntcInitFunction(
        UINTPTR BaseAddress,
        XGpio *GpioInstancePtr);


//----------------------------------------------------
// INTERRUPT HANDLER FUNCTION
//----------------------------------------------------

void BTN_Intr_Handler(void *InstancePtr)
{
    // Disable GPIO interrupts temporarily
    XGpio_InterruptDisable(&BTNInst, BTN_INT);

    // Check whether GPIO interrupt really occurred
    if ((XGpio_InterruptGetStatus(&BTNInst) & BTN_INT)
            != BTN_INT)
    {
        return;
    }

    // Read push button value
    btn_value = XGpio_DiscreteRead(&BTNInst, 1);

    /*
     * Increment counter according to button value.
     *
     * If centre button produces value 1:
     * reset LED counter to 0.
     *
     * Otherwise:
     * add button value to LED counter.
     */
    if (btn_value != 1)
    {
        led_data = led_data + btn_value;
    }
    else
    {
        led_data = 0;
    }

    // Display counter value on LEDs
    XGpio_DiscreteWrite(&LEDInst, 1, led_data);

    // Clear GPIO interrupt
    XGpio_InterruptClear(&BTNInst, BTN_INT);

    // Re-enable GPIO interrupt
    XGpio_InterruptEnable(&BTNInst, BTN_INT);
}


//----------------------------------------------------
// MAIN FUNCTION
//----------------------------------------------------

int main(void)
{
    int status;

    //------------------------------------------------
    // INITIALIZE LED GPIO
    //------------------------------------------------

    status = XGpio_Initialize(
            &LEDInst,
            LEDS_BASEADDR);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // INITIALIZE PUSH BUTTON GPIO
    //------------------------------------------------

    status = XGpio_Initialize(
            &BTNInst,
            BTNS_BASEADDR);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // SET GPIO DIRECTIONS
    //------------------------------------------------

    // LEDs = outputs
    XGpio_SetDataDirection(
            &LEDInst,
            1,
            0x00);

    // Push buttons = inputs
    XGpio_SetDataDirection(
            &BTNInst,
            1,
            0xFF);


    //------------------------------------------------
    // INITIALIZE INTERRUPT CONTROLLER
    //------------------------------------------------

    status = IntcInitFunction(
            INTC_BASEADDR,
            &BTNInst);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // MAIN LOOP
    //------------------------------------------------

    while (1)
    {
        /*
         * CPU waits here.
         *
         * Button processing occurs inside
         * BTN_Intr_Handler() whenever an
         * interrupt arrives.
         */
    }

    return 0;
}


//----------------------------------------------------
// INTERRUPT SYSTEM SETUP
//----------------------------------------------------

int InterruptSystemSetup(
        XScuGic *XScuGicInstancePtr)
{
    //------------------------------------------------
    // Enable GPIO interrupt
    //------------------------------------------------

    XGpio_InterruptEnable(
            &BTNInst,
            BTN_INT);

    XGpio_InterruptGlobalEnable(
            &BTNInst);


    //------------------------------------------------
    // Register GIC interrupt handler
    //------------------------------------------------

    Xil_ExceptionRegisterHandler(
            XIL_EXCEPTION_ID_INT,
            (Xil_ExceptionHandler)
                XScuGic_InterruptHandler,
            XScuGicInstancePtr);


    //------------------------------------------------
    // Enable processor exceptions
    //------------------------------------------------

    Xil_ExceptionEnable();


    return XST_SUCCESS;
}


//----------------------------------------------------
// INTERRUPT CONTROLLER INITIALIZATION
//----------------------------------------------------

int IntcInitFunction(
        UINTPTR BaseAddress,
        XGpio *GpioInstancePtr)
{
    XScuGic_Config *IntcConfig;
    int status;


    //------------------------------------------------
    // LOOK UP GIC CONFIGURATION
    //------------------------------------------------

    IntcConfig =
        XScuGic_LookupConfig(BaseAddress);

    if (IntcConfig == NULL)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // INITIALIZE GIC
    //------------------------------------------------

    status = XScuGic_CfgInitialize(
            &INTCInst,
            IntcConfig,
            IntcConfig->CpuBaseAddress);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // INTERRUPT SYSTEM SETUP
    //------------------------------------------------

    status =
        InterruptSystemSetup(&INTCInst);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // CONNECT GPIO INTERRUPT TO BUTTON HANDLER
    //------------------------------------------------

    status = XScuGic_Connect(
            &INTCInst,
            INTC_GPIO_INTERRUPT_ID,
            (Xil_ExceptionHandler)
                BTN_Intr_Handler,
            (void *)GpioInstancePtr);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //------------------------------------------------
    // ENABLE GPIO INTERRUPTS
    //------------------------------------------------

    XGpio_InterruptEnable(
            GpioInstancePtr,
            BTN_INT);

    XGpio_InterruptGlobalEnable(
            GpioInstancePtr);


    //------------------------------------------------
    // ENABLE GPIO INTERRUPT IN GIC
    //------------------------------------------------

    XScuGic_Enable(
            &INTCInst,
            INTC_GPIO_INTERRUPT_ID);


    return XST_SUCCESS;
}