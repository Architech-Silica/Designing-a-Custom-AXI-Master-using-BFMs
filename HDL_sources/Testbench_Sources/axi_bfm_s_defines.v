// Define for internal control value
`define DESTVALID_TRUE  1'b1
`define DESTVALID_FALSE 1'b0
`define IDVALID_TRUE  1'b1
`define IDVALID_FALSE 1'b0

// AMBA AXI 4 streaming Bus Size Constants
`define DATA_BUS_WIDTH 32
`define USER_BUS_WIDTH 1
`define ID_BUS_WIDTH 1
`define DEST_BUS_WIDTH 1
`define MAX_PACKET_SIZE 2

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDATA
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDATA(expected,actual)
   // This task checks if the actual tdata is equal to the expected tdata.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDATA;
      input [`DATA_BUS_WIDTH-1:0] expected;
      input [`DATA_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDATA cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TDATA expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TUSER
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TUSER(expected,actual)
   // This task checks if the actual tuser is equal to the expected tuser.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TUSER;
      input [`USER_BUS_WIDTH-1:0] expected;
      input [`USER_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TUSER cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TUSER expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TID
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TID(expected,actual)
   // This task checks if the actual tid is equal to the expected tid.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TID;
      input [`ID_BUS_WIDTH-1:0] expected;
      input [`ID_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TID cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TID expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDEST
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDEST(expected,actual)
   // This task checks if the actual tdest is equal to the expected tdest.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDEST;
      input [`DEST_BUS_WIDTH-1:0] expected;
      input [`DEST_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDEST cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TDEST expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TSTRB
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TSTRB(expected,actual)
   // This task checks if the actual tstrb is equal to the expected tstrb.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TSTRB;
      input [(`DATA_BUS_WIDTH/8)-1:0] expected;
      input [(`DATA_BUS_WIDTH/8)-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TSTRB cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TSTRB expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TKEEP
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TKEEP(expected,actual)
   // This task checks if the actual tkeep is equal to the expected tkeep.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TKEEP;
      input [(`DATA_BUS_WIDTH/8)-1:0] expected;
      input [(`DATA_BUS_WIDTH/8)-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TKEEP cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TKEEP expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TLAST
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TLAST(expected,actual)
   // This task checks if the actual tlast is equal to the expected tlast.
   //------------------------------------------------------------------------
   task automatic COMPARE_TLAST;
      input expected;
      input actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TLAST cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TLAST expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDATA_VECTOR
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDATA_VECTOR(expected,actual)
   // This task checks if the actual data is equal to the expected data.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDATA_VECTOR;
      input [(`DATA_BUS_WIDTH*(`MAX_PACKET_SIZE+1))-1:0] expected;
      input [(`DATA_BUS_WIDTH*(`MAX_PACKET_SIZE+1))-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDATA_VECTOR cannot be performed with an expected or actual vector that is all 'x'!");
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
   // TEST LEVEL API: COMPARE_TUSER_VECTOR
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TUSER_VECTOR(expected,actual)
   // This task checks if the actual user data is equal to the expected user
   // data.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TUSER_VECTOR;
      input [(`USER_BUS_WIDTH*(`MAX_PACKET_SIZE+1))-1:0] expected;
      input [(`USER_BUS_WIDTH*(`MAX_PACKET_SIZE+1))-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TUSER_VECTOR cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! User data expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_DATASIZE
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_DATASIZE(expected,actual)
   // This task checks if the actual datasize is equal to the expected datasize.
   //------------------------------------------------------------------------
   task automatic COMPARE_DATASIZE;
      input integer expected;
      input integer actual;
      begin
         if (actual != expected) begin
            $display("TESTBENCH ERROR! DATASIZE expected is not equal to actual.",
                     "\n expected = %0d",expected,
                     "\n actual   = %0d",actual);
            $stop;
         end
      end
   endtask
