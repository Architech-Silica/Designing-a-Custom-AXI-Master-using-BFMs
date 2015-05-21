#include <stdio.h>
#include "xparameters.h"
#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"
#include "xgpio.h"
#include "xil_cache.h"


#include "platform.h"

#define GPIO_CHANNEL_1 1


int main()
{
	int BRAM_offset;
	int temp_read_value;
	XStatus Status;

	XGpio my_gpio_instance;
	XGpio_Config *my_gpio_instance_config;


init_platform();

	// Disable the caches so that they are not affecting the results!
	printf("Disable the caches to prevent skewing the results with BRAM reads / writes\n\r");
	Xil_DCacheDisable();
	Xil_ICacheDisable();


	my_gpio_instance_config = XGpio_LookupConfig(XPAR_AXI_GPIO_0_DEVICE_ID);
	Status = XGpio_CfgInitialize(&my_gpio_instance, my_gpio_instance_config, my_gpio_instance_config->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		printf("Failed to CfgInitialise.  Halting!\n\r");
		return (1);
	}

	XGpio_SetDataDirection(&my_gpio_instance, GPIO_CHANNEL_1, 0x00000000);

	printf("--AXI4 Custom Master Test--\n\r");
	printf("\n\r");

	printf("Disable the AXI4 Custom Master\n\r");
	XGpio_DiscreteWrite(&my_gpio_instance, GPIO_CHANNEL_1, 0x00000000);

	// Write zeros to fill the BRAM
	printf("Writing zeros to fill the BRAM\n\r");
	for (BRAM_offset = 0; BRAM_offset < (XPAR_AXI_BRAM_CTRL_0_S_AXI_HIGHADDR - XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR)/4; BRAM_offset++)
	{
		Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4), 0x00000000);
	}

	// Read back and display some of the test values
	for (BRAM_offset = 0; BRAM_offset < 10; BRAM_offset++)
	{
		temp_read_value = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4));
		printf("BRAM Address 0x%08X = 0x%08X\n\r", XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4), temp_read_value);
	}

	// Write sequential test values to fill the BRAM
	printf("Writing sequential test values to fill the BRAM\n\r");
	for (BRAM_offset = 0; BRAM_offset < (XPAR_AXI_BRAM_CTRL_0_S_AXI_HIGHADDR - XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR)/4; BRAM_offset++)
	{
		Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4), (0x12340000 + BRAM_offset));
	}

	// Read back and display some of the test values
	for (BRAM_offset = 0; BRAM_offset < 10; BRAM_offset++)
	{
		temp_read_value = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4));
		printf("BRAM Address 0x%08X = 0x%08X\n\r", XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4), temp_read_value);
	}

	printf("Enable the AXI4 Custom Master\n\r");
	XGpio_DiscreteWrite(&my_gpio_instance, GPIO_CHANNEL_1, 0x00000001);
	printf("Disable the AXI4 Custom Master\n\r");
	XGpio_DiscreteWrite(&my_gpio_instance, GPIO_CHANNEL_1, 0x00000000);

	printf("Read back the contents of the BRAM\n\r");
	for (BRAM_offset = 0; BRAM_offset < 10; BRAM_offset++)
	{
		temp_read_value = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4));
		printf("BRAM Address 0x%08X = 0x%08X\n\r", XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + (BRAM_offset*4), temp_read_value);
	}


	printf("--AXI4 Custom Master Test Complete--\n\r");

	cleanup_platform();
	return 0;
}
