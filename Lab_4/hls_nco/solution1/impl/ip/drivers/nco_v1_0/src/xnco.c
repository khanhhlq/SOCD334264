// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xnco.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XNco_CfgInitialize(XNco *InstancePtr, XNco_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Slv0_BaseAddress = ConfigPtr->Slv0_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

u32 XNco_Get_sine_sample(XNco *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XNco_ReadReg(InstancePtr->Slv0_BaseAddress, XNCO_SLV0_ADDR_SINE_SAMPLE_DATA);
    return Data;
}

u32 XNco_Get_sine_sample_vld(XNco *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XNco_ReadReg(InstancePtr->Slv0_BaseAddress, XNCO_SLV0_ADDR_SINE_SAMPLE_CTRL);
    return Data & 0x1;
}

void XNco_Set_step_size(XNco *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XNco_WriteReg(InstancePtr->Slv0_BaseAddress, XNCO_SLV0_ADDR_STEP_SIZE_DATA, Data);
}

u32 XNco_Get_step_size(XNco *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XNco_ReadReg(InstancePtr->Slv0_BaseAddress, XNCO_SLV0_ADDR_STEP_SIZE_DATA);
    return Data;
}

