// AXI4/AXI3 Burst Type Defines
`define BURST_TYPE_FIXED 2'b00
`define BURST_TYPE_INCR  2'b01
`define BURST_TYPE_WRAP  2'b10

// AXI4/AXI3 Memory Type
`define MEM_TYPE_DEV_NONBUF 4'b0000
`define MEM_TYPE_DEV_BUF    4'b0001
`define MEM_TYPE_NORM_NONCACHE_NONBUF 4'b0010
`define MEM_TYPE_NORM_NONCACHE_BUF 4'b0011

// AXI4/AXI3 Protect Type
`define PROT_DATA_SECURE_UNPRIV       3'b000
`define PROT_DATA_SECURE_PRIV         3'b001
`define PROT_DATA_NONSECURE_UNPRIV    3'b010
`define PROT_DATA_NONSECURE_PRIV      3'b011

// AXI4/AXI3 Burst Size Defines
`define BURST_SIZE_1_BYTE    3'b000
`define BURST_SIZE_2_BYTES   3'b001
`define BURST_SIZE_4_BYTES   3'b010
`define BURST_SIZE_8_BYTES   3'b011
`define BURST_SIZE_16_BYTES  3'b100
`define BURST_SIZE_32_BYTES  3'b101
`define BURST_SIZE_64_BYTES  3'b110
`define BURST_SIZE_128_BYTES 3'b111

// AXI4 Lock Type Defines
`define LOCK_TYPE_NORMAL    1'b0
`define LOCK_TYPE_EXCLUSIVE 1'b1

// AXI3 Lock Type Defines
`define AXI3_LOCK_TYPE_NORMAL    2'b00
`define AXI3_LOCK_TYPE_EXCLUSIVE 2'b01
`define AXI3_LOCK_TYPE_LOCKED    2'b10

// AXI4/AXI4LITE/AXI3 Response Type Defines
`define RESPONSE_OKAY 2'b00
`define RESPONSE_EXOKAY 2'b01
`define RESPONSE_SLVERR 2'b10
`define RESPONSE_DECERR 2'b11

// AMBA AXI 4 Bus Size Constants

`define LOCK_BUS_WIDTH 1
`define QOS_BUS_WIDTH 4
`define REGION_BUS_WIDTH 4
`define RUSER_BUS_WIDTH  1
`define WUSER_BUS_WIDTH  1

// AMBA AXI 3 Bus Size Constants
`define AXI3_LOCK_BUS_WIDTH 2


// AMBA AXI 4/3 Bus Size Constants
`define ADDR_BUS_WIDTH 32
`define DATA_BUS_WIDTH 32
`define DATA_BUS_WIDTH_32 32
`define DATA_BUS_WIDTH_64 64
`define DATA_BUS_WIDTH_128 128
`define DATA_BUS_WIDTH_256 256
`define DATA_BUS_WIDTH_512 512
`define DATA_BUS_WIDTH_1024 1024  

`define SIZE_BUS_WIDTH 3
`define BURST_BUS_WIDTH 2
`define CACHE_BUS_WIDTH 4
`define TYPE_BUS_WIDTH 2

// AMBA AXI 3 Range Constants
// Required for test of WRAP and FIXED max bursts lengths
`define AXI3_MAX_BURST_LENGTH 8'b0000_1111
`define AXI3_MAX_DATA_SIZE (`DATA_BUS_WIDTH*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_32 (`DATA_BUS_WIDTH_32*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_64 (`DATA_BUS_WIDTH_64*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_128 (`DATA_BUS_WIDTH_128*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_256 (`DATA_BUS_WIDTH_256*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_512 (`DATA_BUS_WIDTH_512*(`AXI3_MAX_BURST_LENGTH+1))/8
`define AXI3_MAX_DATA_SIZE_1024 (`DATA_BUS_WIDTH_1024*(`AXI3_MAX_BURST_LENGTH+1))/8

// AMBA AXI 4 Range Constants
// Required for test of WRAP and FIXED max bursts lengths
`define MAX_BURST_LENGTH 8'b1111_1111
`define MAX_DATA_SIZE (`DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_32 (`DATA_BUS_WIDTH_32*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_64 (`DATA_BUS_WIDTH_64*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_128 (`DATA_BUS_WIDTH_128*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_256 (`DATA_BUS_WIDTH_256*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_512 (`DATA_BUS_WIDTH_512*(`MAX_BURST_LENGTH+1))/8
`define MAX_DATA_SIZE_1024 (`DATA_BUS_WIDTH_1024*(`MAX_BURST_LENGTH+1))/8

// AXI4/AXI4LITE/AXI3 Bus Size Constants
`define PROT_BUS_WIDTH 3
`define RESP_BUS_WIDTH 2
`define ID_WIDTH 12 
 

// AMBA AXI 4 Lite Range Constants
`define AXI4LITE_DATA_BUS_WIDTH 32
`define AXI4LITE_MAX_DATA_SIZE (`AXI4LITE_DATA_BUS_WIDTH)/8

// Message defines
`define MSG_WARNING WARNING
`define MSG_INFO    INFO
`define MSG_ERROR   ERROR

// Define for intenal control value
`define ANY_ID_NEXT 100
`define IDVALID_TRUE  1'b1
`define IDVALID_FALSE 1'b0

// Define for intenal control value AXI4LITE
`define ADDRVALID_FALSE 0
`define ADDRVALID_TRUE  1

//------------------------------------------------------------------------
// TEST LEVEL API TASKS
//------------------------------------------------------------------------

         

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_OKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to OKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_VECTOR_OKAY;
   input [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_OKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_OKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to OKAY
//------------------------------------------------------------------------
task automatic AXI3_CHECK_RESPONSE_VECTOR_OKAY;
   input [(`RESP_BUS_WIDTH*(`AXI3_MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_OKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask


//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_EXOKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_EXOKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to EXOKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_VECTOR_EXOKAY;
   input [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_EXOKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask


//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_EXOKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_EXOKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to EXOKAY
//------------------------------------------------------------------------
task automatic AXI3_CHECK_RESPONSE_VECTOR_EXOKAY;
   input [(`RESP_BUS_WIDTH*(`AXI3_MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_EXOKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_OKAY(response)
// This task checks if the return response is equal to OKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_OKAY;
   input [`RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `RESPONSE_OKAY) begin
         $display("TESTBENCH ERROR! Response is not OKAY",
                  "\n expected = 0x%h",`RESPONSE_OKAY,
                  "\n actual   = 0x%h",response);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_EXOKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_EXOKAY(response)
// This task checks if the return response is equal to EXOKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_EXOKAY;
   input [`RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `RESPONSE_EXOKAY) begin
         $display("TESTBENCH ERROR! Response is not EXOKAY",
                  "\n expected = 0x%h",`RESPONSE_EXOKAY,
                  "\n actual   = 0x%h",response);
         $stop;
      end
   end
endtask


//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_WUSER
//------------------------------------------------------------------------
// Description:
// COMPARE_WUSER(expected,actual)
// This task checks if the actual wuser data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_WUSER;
   input [(`WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(`WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_WUSER cannot be performed with an expected or actual vector that is all 'x'!");
         $stop;
      end
      
      if (actual != expected) begin
         $display("TESTBENCH ERROR! WUSER data expected is not equal to actual.",
                  "\n expected = 0x%h",expected,
                  "\n actual   = 0x%h",actual);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_RUSER
//------------------------------------------------------------------------
// Description:
// COMPARE_RUSER(expected,actual)
// This task checks if the actual wuser data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_RUSER;
   input [(`RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(`RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_RUSER cannot be performed with an expected or actual vector that is all 'x'!");
         $stop;
      end
      
      if (actual != expected) begin
         $display("TESTBENCH ERROR! RUSER data expected is not equal to actual.",
                  "\n expected = 0x%h",expected,
                  "\n actual   = 0x%h",actual);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_DATA
//------------------------------------------------------------------------
// Description:
// COMPARE_DATA(expected,actual)
// This task checks if the actual data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_DATA;
   input [(`DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(`DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_DATA cannot be performed with an expected or actual vector that is all 'x'!");
         $stop;
      end
      
      if (actual != expected) begin
         $display("TESTBENCH ERROR! Data expected is not equal to actual.",
                  "\n expected = 0x%h",expected,
                  "\n actual   = 0x%h",actual);
         $stop;
      end
   end
endtask