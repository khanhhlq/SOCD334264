#include "xparameters.h"
#include "xgpio.h"
#include "xtmrctr.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xstatus.h"

//====================================================
// PARAMETER DEFINITIONS - VITIS 2026.1
//====================================================

// GIC
#define INTC_BASEADDR           XPAR_XSCUGIC_0_BASEADDR

// AXI Timer
#define TMR_BASEADDR            XPAR_XTMRCTR_0_BASEADDR

// GPIO
#define BTNS_BASEADDR           XPAR_XGPIO_0_BASEADDR
#define LEDS_BASEADDR           XPAR_XGPIO_1_BASEADDR

// Interrupt IDs
#define INTC_GPIO_INTERRUPT_ID  XPAR_FABRIC_AXI_GPIO_0_INTR
#define INTC_TMR_INTERRUPT_ID   XPAR_FABRIC_AXI_TIMER_0_INTR

// GPIO interrupt channel
#define BTN_INT                 XGPIO_IR_CH1_MASK

// Timer reset/load value
#define TMR_LOAD                0xF8000000


//====================================================
// GLOBAL VARIABLES
//====================================================

XGpio LEDInst;
XGpio BTNInst;

XScuGic INTCInst;

XTmrCtr TMRInst;

static int led_data = 0;
static int btn_value = 0;
static int tmr_count = 0;


//====================================================
// FUNCTION PROTOTYPES
//====================================================

static void BTN_Intr_Handler(void *InstancePtr);

static void TMR_Intr_Handler(
        void *CallBackRef,
        u8 TmrCtrNumber);

static int InterruptSystemSetup(
        XScuGic *XScuGicInstancePtr);

static int IntcInitFunction(
        UINTPTR BaseAddress,
        XTmrCtr *TmrInstancePtr,
        XGpio *GpioInstancePtr);


//====================================================
// BUTTON INTERRUPT HANDLER
//====================================================

static void BTN_Intr_Handler(void *InstancePtr)
{
    (void)InstancePtr;

    // Disable GPIO interrupt temporarily
    XGpio_InterruptDisable(&BTNInst, BTN_INT);

    // Check whether GPIO interrupt occurred
    if ((XGpio_InterruptGetStatus(&BTNInst) & BTN_INT)
            != BTN_INT)
    {
        XGpio_InterruptEnable(&BTNInst, BTN_INT);
        return;
    }

    // Read push buttons
    btn_value = XGpio_DiscreteRead(&BTNInst, 1);

    /*
     * BTN[0] = center button
     * If center button -> reset LED counter
     *
     * Other buttons add their binary value:
     * BTN1 = 2
     * BTN2 = 4
     * BTN3 = 8
     * BTN4 = 16
     */

    if (btn_value != 1)
    {
        led_data = led_data + btn_value;
    }
    else
    {
        led_data = 0;
    }

    // Write counter value to LEDs
    XGpio_DiscreteWrite(&LEDInst, 1, led_data);

    // Clear interrupt
    XGpio_InterruptClear(&BTNInst, BTN_INT);

    // Re-enable GPIO interrupt
    XGpio_InterruptEnable(&BTNInst, BTN_INT);
}


//====================================================
// TIMER INTERRUPT HANDLER
//====================================================

static void TMR_Intr_Handler(
        void *CallBackRef,
        u8 TmrCtrNumber)
{
    (void)CallBackRef;

    // Check timer 0
    if (TmrCtrNumber != 0)
        return;

    if (XTmrCtr_IsExpired(&TMRInst, 0))
    {
        /*
         * After several timer expirations,
         * increment LED counter.
         */

        if (tmr_count == 3)
        {
            XTmrCtr_Stop(&TMRInst, 0);

            tmr_count = 0;

            led_data++;

            XGpio_DiscreteWrite(
                    &LEDInst,
                    1,
                    led_data);

            XTmrCtr_Reset(
                    &TMRInst,
                    0);

            XTmrCtr_Start(
                    &TMRInst,
                    0);
        }
        else
        {
            tmr_count++;
        }
    }
}


//====================================================
// MAIN
//====================================================

int main(void)
{
    int status;

    xil_printf(
        "\r\n================================\r\n");

    xil_printf(
        " ZYNQ GPIO + TIMER INTERRUPT\r\n");

    xil_printf(
        "================================\r\n");


    //================================================
    // INITIALIZE LED GPIO
    //================================================

    status = XGpio_Initialize(
                    &LEDInst,
                    LEDS_BASEADDR);

    if (status != XST_SUCCESS)
    {
        xil_printf(
            "LED GPIO initialization failed\r\n");

        return XST_FAILURE;
    }


    //================================================
    // INITIALIZE BUTTON GPIO
    //================================================

    status = XGpio_Initialize(
                    &BTNInst,
                    BTNS_BASEADDR);

    if (status != XST_SUCCESS)
    {
        xil_printf(
            "Button GPIO initialization failed\r\n");

        return XST_FAILURE;
    }


    // LEDs = OUTPUT
    XGpio_SetDataDirection(
                    &LEDInst,
                    1,
                    0x00);

    // Buttons = INPUT
    XGpio_SetDataDirection(
                    &BTNInst,
                    1,
                    0x1F);

    // Clear LEDs initially
    XGpio_DiscreteWrite(
                    &LEDInst,
                    1,
                    0x00);


    //================================================
    // INITIALIZE AXI TIMER
    //================================================

    status = XTmrCtr_Initialize(
                    &TMRInst,
                    TMR_BASEADDR);

    if (status != XST_SUCCESS)
    {
        xil_printf(
            "Timer initialization failed\r\n");

        return XST_FAILURE;
    }


    // Register timer callback
    XTmrCtr_SetHandler(
                    &TMRInst,
                    TMR_Intr_Handler,
                    &TMRInst);


    // Timer initial value
    XTmrCtr_SetResetValue(
                    &TMRInst,
                    0,
                    TMR_LOAD);


    // Enable:
    // - interrupt mode
    // - automatic reload
    XTmrCtr_SetOptions(
                    &TMRInst,
                    0,
                    XTC_INT_MODE_OPTION |
                    XTC_AUTO_RELOAD_OPTION);


    //================================================
    // INITIALIZE INTERRUPT CONTROLLER
    //================================================

    status = IntcInitFunction(
                    INTC_BASEADDR,
                    &TMRInst,
                    &BTNInst);

    if (status != XST_SUCCESS)
    {
        xil_printf(
            "Interrupt controller initialization failed\r\n");

        return XST_FAILURE;
    }


    //================================================
    // START TIMER
    //================================================

    XTmrCtr_Start(
                    &TMRInst,
                    0);

    xil_printf(
        "System started successfully\r\n");


    //================================================
    // MAIN LOOP
    //================================================

    while (1)
    {
        // CPU waits for interrupts
    }

    return 0;
}


//====================================================
// INTERRUPT SYSTEM SETUP
//====================================================

static int InterruptSystemSetup(
        XScuGic *XScuGicInstancePtr)
{
    // Enable GPIO interrupt
    XGpio_InterruptEnable(
                    &BTNInst,
                    BTN_INT);

    XGpio_InterruptGlobalEnable(
                    &BTNInst);


    // Connect GIC handler to ARM exception system
    Xil_ExceptionRegisterHandler(
            XIL_EXCEPTION_ID_INT,
            (Xil_ExceptionHandler)
                XScuGic_InterruptHandler,
            XScuGicInstancePtr);


    // Enable CPU interrupts
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}


//====================================================
// INITIALIZE GIC
//====================================================

static int IntcInitFunction(
        UINTPTR BaseAddress,
        XTmrCtr *TmrInstancePtr,
        XGpio *GpioInstancePtr)
{
    XScuGic_Config *IntcConfig;

    int status;


    //================================================
    // LOOKUP GIC CONFIGURATION
    //================================================

    IntcConfig =
        XScuGic_LookupConfig(
                BaseAddress);

    if (IntcConfig == NULL)
    {
        return XST_FAILURE;
    }


    //================================================
    // INITIALIZE GIC
    //================================================

    status =
        XScuGic_CfgInitialize(
                &INTCInst,
                IntcConfig,
                IntcConfig->DistBaseAddress);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //================================================
    // REGISTER CPU INTERRUPT SYSTEM
    //================================================

    status =
        InterruptSystemSetup(
                &INTCInst);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //================================================
    // CONNECT GPIO INTERRUPT
    //================================================

    status =
        XScuGic_Connect(
                &INTCInst,
                INTC_GPIO_INTERRUPT_ID,
                (Xil_InterruptHandler)
                    BTN_Intr_Handler,
                (void *)GpioInstancePtr);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //================================================
    // CONNECT TIMER INTERRUPT
    //================================================

    status =
        XScuGic_Connect(
                &INTCInst,
                INTC_TMR_INTERRUPT_ID,
                (Xil_InterruptHandler)
                    XTmrCtr_InterruptHandler,
                (void *)TmrInstancePtr);

    if (status != XST_SUCCESS)
    {
        return XST_FAILURE;
    }


    //================================================
    // ENABLE GPIO INTERRUPT
    //================================================

    XGpio_InterruptEnable(
                GpioInstancePtr,
                BTN_INT);

    XGpio_InterruptGlobalEnable(
                GpioInstancePtr);


    //================================================
    // ENABLE INTERRUPTS INSIDE GIC
    //================================================

    XScuGic_Enable(
                &INTCInst,
                INTC_GPIO_INTERRUPT_ID);

    XScuGic_Enable(
                &INTCInst,
                INTC_TMR_INTERRUPT_ID);


    return XST_SUCCESS;
}