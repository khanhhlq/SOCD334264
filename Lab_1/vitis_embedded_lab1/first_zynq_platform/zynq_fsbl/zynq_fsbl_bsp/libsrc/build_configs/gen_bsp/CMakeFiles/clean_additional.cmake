# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\diskio.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\ff.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\ffconf.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\sleep.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilffs.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilffs_config.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilrsa.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xiltimer.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xtimer_config.h"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxilffs.a"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxilrsa.a"
  "D:\\SoC\\vitis_embedded_lab1\\first_zynq_platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxiltimer.a"
  )
endif()
