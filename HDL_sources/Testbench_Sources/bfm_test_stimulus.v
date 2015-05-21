`timescale 1 ns/10 ps

// Defines for BFM Paths
// AXI BFM Module Paths 
// `define AXI4_M_BFM_0 <testbench_inst>.<bd_top_inst>.<bd_inst>.<bfm_inst>.<bfm_type(see below)>

// BFM Types:
// AXI3 Master/Slave - cdn_axi3_master_bfm_inst/cdn_axi3_slave_bfm_inst
// AXI4 Master/Slave - cdn_axi4_master_bfm_inst/cdn_axi4_slave_bfm_inst
// AXI4LITE Master/Slave - cdn_axi4_lite_master_bfm_inst/cdn_axi4_lite_slave_bfm_inst
// AXI4Stream Master/Slave - cdn_axi4_streaming_master_bfm_inst/cdn_axi4_streaming_slave_bfm_inst

// Zynq BFM Module Paths
// `define ZYNQ_BFM_0 <testbench_inst>.<bd_top_inst>.<bd_inst>.<ps7_bfm_inst>.inst

// Add `define for all AXI BFM Instances and ZYNQ BFM Instances
// `define AXI4_M_BFM_0 axi_master_tb.design_1_wrapper_inst.design_1_i.AXI4_M_BFM_0.cdn_axi4_master_bfm_inst
`define AXI4_S_BFM_0 axi_master_tb.design_1_wrapper_inst.design_1_i.AXI4_S_BFM_0.cdn_axi4_slave_bfm_inst

// Add `define for base addresses used by AXI BFM Instances and ZYNQ BFM Instances
// `define AXI4_M_BFM_0_ADDR_RD_BASE 32'hC0000000
// `define AXI4_M_BFM_0_ADDR_WR_BASE 32'hC0000000
`define AXI4_S_BFM_0_ADDR_RD_BASE 32'hC0000000
`define AXI4_S_BFM_0_ADDR_WR_BASE 32'hC0000000


module bfm_test
    (
    input clk,
    input rst_n,
    input sys_rst_n,
    input init_done,    
    output interrupt
    );

// Include Required BFM defines based upon the added AXI BFM(protocol) and/or ZYNQ BFM
// Possible options are zynq_bfm_defines.v, // axi_bfm_defines.v, axi_bfm_s_defines.v

// Add required BFM define files
`include "zynq_bfm_defines.v"
`include "axi_bfm_defines.v"
`include "axi_bfm_s_defines.v"

    
    // AXI BFM Slave Channel API
    // Read AXI4 Protocol signals which are used as outputs/inputs to APIs
    
    reg [`ID_WIDTH-1:0] AXI4_S_BFM_0_ID;
    
    reg [`ADDR_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_ADDR;
    reg [`MAX_BURST_LENGTH:0] AXI4_S_BFM_0_R_BURST_LENGTH;
    reg [`SIZE_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_BURST_SIZE;
    reg [`TYPE_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_BURST_TYPE;
    reg [`LOCK_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_LOCK;
    reg [`CACHE_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_CACHE;
    reg [`PROT_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_PROT;
    reg [`REGION_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_REGION;
    reg [`QOS_BUS_WIDTH-1:0] AXI4_S_BFM_0_R_QOS;
    reg [`RUSER_BUS_WIDTH-1:0] AXI4_S_BFM_0_ARUSER;
    reg [`ID_WIDTH-1:0] AXI4_S_BFM_0_R_IDTAG;
    reg [(`RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] AXI4_S_BFM_0_RUSER = 0;
    
    // Added for AXI BFM Transaction level API
    reg [`ID_WIDTH-1:0] AXI4_S_BFM_0_IDTAG;
    reg [`RUSER_BUS_WIDTH-1:0] AXI4_S_BFM_0_BUSER;
    reg [(`MAX_DATA_SIZE_32*8)-1:0] AXI4_S_BFM_0_DATA;
    
    // Write AXI4 Protocol read signals which are used as outputs/inputs to APIs     
    reg [`ADDR_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_ADDR;
    reg [`MAX_BURST_LENGTH:0] AXI4_S_BFM_0_W_BURST_LENGTH;
    reg [`SIZE_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_BURST_SIZE;
    reg [`TYPE_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_BURST_TYPE;
    reg [`LOCK_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_LOCK;
    reg [`CACHE_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_CACHE;
    reg [`PROT_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_PROT;
    reg [`REGION_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_REGION;
    reg [`QOS_BUS_WIDTH-1:0] AXI4_S_BFM_0_W_QOS;
    reg [`WUSER_BUS_WIDTH-1:0] AXI4_S_BFM_0_AWUSER;
    reg [`ID_WIDTH-1:0] AXI4_S_BFM_0_W_IDTAG;
    
    reg [(`MAX_DATA_SIZE_32*8)-1:0] AXI4_S_BFM_0_W_DATA;
    reg [(`MAX_DATA_SIZE_32*8)-1:0] AXI4_S_BFM_0_R_DATA;
    integer AXI4_S_BFM_0_DATA_SIZE;
    integer S_BUSER = 0;     
    reg [(`WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] AXI4_S_BFM_0_W_USER;


    // Process setting constants and internal variables APIs for BFMs 
    initial
        begin
        // AXI BFM Channel Level Info
        `AXI4_S_BFM_0.set_channel_level_info(1);   
        `AXI4_S_BFM_0.set_function_level_info(1);   
        end  
    
    // Write Transaction Process for APIs serial or parallel
    initial
        begin
        // Check for the deassertion(0) and assertion(1) of the reset on rising edge of clock.
        wait(rst_n === 0) @(posedge clk);
        wait(rst_n === 1) @(posedge clk);
        
        fork
            begin
            AXI4_S_BFM_0_ID = 0;  // Set up the transation ID to listen for.
            forever
                begin
                // AXI4 Slave Channel Write_Burst APIs
                // AXI4 Slave Channel Write RECEIVE_WRITE_ADDRESS API
                
                `AXI4_S_BFM_0.RECEIVE_WRITE_ADDRESS
                    (
                    AXI4_S_BFM_0_ID,
                    `IDVALID_FALSE,
                    AXI4_S_BFM_0_W_ADDR,
                    AXI4_S_BFM_0_W_BURST_LENGTH,
                    AXI4_S_BFM_0_W_BURST_SIZE,
                    AXI4_S_BFM_0_W_BURST_TYPE,
                    AXI4_S_BFM_0_W_LOCK,
                    AXI4_S_BFM_0_W_CACHE,
                    AXI4_S_BFM_0_W_PROT,
                    AXI4_S_BFM_0_W_REGION,
                    AXI4_S_BFM_0_W_QOS,
                    AXI4_S_BFM_0_AWUSER,
                    AXI4_S_BFM_0_W_IDTAG
                    );

                @(posedge clk);
                @(posedge clk);
                
                // AXI4 Slave Channel Write WRITE_BURST API
                `AXI4_S_BFM_0.RECEIVE_WRITE_BURST
                    (
                    AXI4_S_BFM_0_W_ADDR,
                    AXI4_S_BFM_0_W_BURST_LENGTH,
                    AXI4_S_BFM_0_W_BURST_SIZE,
                    AXI4_S_BFM_0_W_BURST_TYPE,
                    AXI4_S_BFM_0_W_DATA,
                    AXI4_S_BFM_0_DATA_SIZE,
                    AXI4_S_BFM_0_W_USER
                    );

                @(posedge clk);
                @(posedge clk);

                // AXI4 Slave Channel Write SEND_WRITE_RESPONSE API      
                `AXI4_S_BFM_0.SEND_WRITE_RESPONSE
                    (
                    AXI4_S_BFM_0_W_IDTAG,
                    `RESPONSE_OKAY,
                    S_BUSER
                    );
                end
            end  
        join
        end

    // Read Transaction Process for APIs serial or parallel
    initial
        begin
        // Check for the deassertion(0) and assertion(1) of the reset on rising edge of clock.
        wait(rst_n === 0) @(posedge clk);
        wait(rst_n === 1) @(posedge clk);
        
        fork
            begin
            forever
                begin
                AXI4_S_BFM_0_R_DATA = 192'hCAFECAFE0000000400000003000000020000000100000000;
                // AXI4_S_BFM_0_R_DATA = 256'hDEADBEEFACEDACEDCAFECAFE0000000500000004000000030000000200000001;
    
    
                // AXI4 Slave Channel Read Burst APIs
                // AXI4 Slave Channel Read RECEIVE_READ_ADDRESS API      
                `AXI4_S_BFM_0.RECEIVE_READ_ADDRESS
                    (
                    0,  // Listen for transactions with Transaction ID = 0000
                    `IDVALID_FALSE,
                    AXI4_S_BFM_0_R_ADDR,
                    AXI4_S_BFM_0_R_BURST_LENGTH,
                    AXI4_S_BFM_0_R_BURST_SIZE,
                    AXI4_S_BFM_0_R_BURST_TYPE,
                    AXI4_S_BFM_0_R_LOCK,
                    AXI4_S_BFM_0_R_CACHE,
                    AXI4_S_BFM_0_R_PROT,
                    AXI4_S_BFM_0_R_REGION,
                    AXI4_S_BFM_0_R_QOS,
                    AXI4_S_BFM_0_ARUSER,
                    AXI4_S_BFM_0_R_IDTAG
                    );

                @(posedge clk);
                @(posedge clk);
                
                // AXI4 Slave Channel Read SEND_READ_BURST API            
                `AXI4_S_BFM_0.SEND_READ_BURST
                    (
                    AXI4_S_BFM_0_R_IDTAG,
                    AXI4_S_BFM_0_R_ADDR,
                    AXI4_S_BFM_0_R_BURST_LENGTH,
                    AXI4_S_BFM_0_R_BURST_SIZE,
                    AXI4_S_BFM_0_R_BURST_TYPE,
                    AXI4_S_BFM_0_R_LOCK,
                    AXI4_S_BFM_0_R_DATA,
                    AXI4_S_BFM_0_RUSER
                    );
                end
            end  
        join
        end
        

    // Fourth Process for APIs serial or parallel
    initial
        begin
        // Check for the deassertion(0) and assertion(1) of the reset on rising edge of clock.
        wait(rst_n === 0) @(posedge clk);
        wait(rst_n === 1) @(posedge clk);
        end
     
endmodule