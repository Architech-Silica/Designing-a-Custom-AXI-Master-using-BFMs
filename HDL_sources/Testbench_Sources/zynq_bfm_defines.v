// Burst Type Defines
`define ZYNQ_BURST_TYPE_FIXED 2'b00
`define ZYNQ_BURST_TYPE_INCR  2'b01
`define ZYNQ_BURST_TYPE_WRAP  2'b10

// Memory Type
`define ZYNQ_MEM_TYPE_DEV_NONBUF 4'b0000
`define ZYNQ_MEM_TYPE_DEV_BUF    4'b0001
`define ZYNQ_MEM_TYPE_NORM_NONCACHE_NONBUF 4'b0010
`define ZYNQ_MEM_TYPE_NORM_NONCACHE_BUF 4'b0011

// Protect Type
`define ZYNQ_PROT_DATA_SECURE_UNPRIV       3'b000
`define ZYNQ_PROT_DATA_SECURE_PRIV         3'b001
`define ZYNQ_PROT_DATA_NONSECURE_UNPRIV    3'b010
`define ZYNQ_PROT_DATA_NONSECURE_PRIV      3'b011

// Burst Size Defines
`define ZYNQ_BURST_SIZE_1_BYTE    3'b000
`define ZYNQ_BURST_SIZE_2_BYTES   3'b001
`define ZYNQ_BURST_SIZE_4_BYTES   3'b010
`define ZYNQ_BURST_SIZE_8_BYTES   3'b011
`define ZYNQ_BURST_SIZE_16_BYTES  3'b100
`define ZYNQ_BURST_SIZE_32_BYTES  3'b101
`define ZYNQ_BURST_SIZE_64_BYTES  3'b110
`define ZYNQ_BURST_SIZE_128_BYTES 3'b111

// Lock Type Defines
`define ZYNQ_LOCK_TYPE_NORMAL    2'b00
`define ZYNQ_LOCK_TYPE_EXCLUSIVE 2'b01
`define ZYNQ_LOCK_TYPE_LOCKED    2'b10

// Response Type Defines
`define ZYNQ_RESPONSE_OKAY 2'b00
`define ZYNQ_RESPONSE_EXOKAY 2'b01
`define ZYNQ_RESPONSE_SLVERR 2'b10
`define ZYNQ_RESPONSE_DECERR 2'b11

// AMBA AXI 3 Bus Size Constants
`define ZYNQ_DATA_BUS_WIDTH 32
`define ZYNQ_SIZE_BUS_WIDTH 3
`define ZYNQ_BURST_BUS_WIDTH 2
`define ZYNQ_LOCK_BUS_WIDTH 2
`define ZYNQ_CACHE_BUS_WIDTH 4
`define ZYNQ_PROT_BUS_WIDTH 3
`define ZYNQ_RESP_BUS_WIDTH 2

// AMBA AXI 3 Range Constants
`define ZYNQ_MAX_BURST_LENGTH 4'b1111
`define ZYNQ_MAX_DATA_SIZE (`ZYNQ_DATA_BUS_WIDTH*(`ZYNQ_MAX_BURST_LENGTH+1))

  
//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_OKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to OKAY
//------------------------------------------------------------------------
task automatic ZYNQ_CHECK_RESPONSE_VECTOR_OKAY;
   input [(`ZYNQ_RESP_BUS_WIDTH*(`ZYNQ_MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         ZYNQ_CHECK_RESPONSE_OKAY(response[i*`ZYNQ_RESP_BUS_WIDTH +: `ZYNQ_RESP_BUS_WIDTH]);
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
task automatic ZYNQ_CHECK_RESPONSE_VECTOR_EXOKAY;
   input [(`ZYNQ_RESP_BUS_WIDTH*(`ZYNQ_MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         ZYNQ_CHECK_RESPONSE_EXOKAY(response[i*`ZYNQ_RESP_BUS_WIDTH +: `ZYNQ_RESP_BUS_WIDTH]);
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
task automatic ZYNQ_CHECK_RESPONSE_OKAY;
   input [`ZYNQ_RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `ZYNQ_RESPONSE_OKAY) begin
         $display("TESTBENCH ERROR! Response is not OKAY",
                  "\n expected = 0x%h",`ZYNQ_RESPONSE_OKAY,
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
task automatic ZYNQ_CHECK_RESPONSE_EXOKAY;
   input [`ZYNQ_RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `ZYNQ_RESPONSE_EXOKAY) begin
         $display("TESTBENCH ERROR! Response is not EXOKAY",
                  "\n expected = 0x%h",`ZYNQ_RESPONSE_EXOKAY,
                  "\n actual   = 0x%h",response);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_DATA_BURST
//------------------------------------------------------------------------
// Description:
// COMPARE_DATA(expected,actual)
// This task checks if the actual data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic ZYNQ_COMPARE_DATA_BURST;
   input [(`ZYNQ_DATA_BUS_WIDTH*(`ZYNQ_MAX_BURST_LENGTH+1))-1:0] expected;
   input [(`ZYNQ_DATA_BUS_WIDTH*(`ZYNQ_MAX_BURST_LENGTH+1))-1:0] actual;
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


//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_DATA_SINGLE
//------------------------------------------------------------------------
// Description:
// COMPARE_DATA(expected,actual)
// This task checks if the actual data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic ZYNQ_COMPARE_DATA_SINGLE;
   input [`ZYNQ_DATA_BUS_WIDTH-1:0] expected;
   input [`ZYNQ_DATA_BUS_WIDTH-1:0] actual;
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

