`timescale 1 ns/10 ps

module axi_master_tb
    (
    );

    // SIMULATION CONSTANTS
    parameter DATA_WIDTH = 32;
    defparam master_stimulus.MINIMUM_BURST_LENGTH = 8;
    defparam master_stimulus.MAXIMUM_BURST_LENGTH = 8;
    
    defparam master_stimulus.DATA_WIDTH = DATA_WIDTH;
    defparam UUT.data_width = DATA_WIDTH;

    //Add wires to connect signals from IPI design to the testbench
    wire interrupt;
    wire go;   
    wire error;
    wire RNW;  
    wire busy; 
    wire done; 
    wire request_to_go;
    wire [31:0] address;   
    wire [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] read_data; 
    wire [7:0] burst_length;        //: in integer range 1 to 256; -- number of beats in a burst
    wire [6:0] burst_size;          //: in integer range 1 to 128;  -- number of byte lanes in each beat
    wire increment_burst;   
    wire clear_data_fifos;  
    wire write_fifo_en;     
    wire write_fifo_empty;  
    wire write_fifo_full;   
    wire read_fifo_en;      
    wire read_fifo_empty;   
    wire read_fifo_full;    
    wire [31:0] AXI_araddr;
    wire [1:0] AXI_arburst;
    wire [3:0] AXI_arcache;
    wire [3:0] AXI_arid;
    wire [7:0] AXI_arlen;
    wire AXI_arlock;
    wire [2:0] AXI_arprot;
    wire [3:0] AXI_arqos;
    wire AXI_arready;
    wire [3:0] AXI_arregion;
    wire [2:0] AXI_arsize;
    wire AXI_aruser;
    wire AXI_arvalid;
    wire [31:0] AXI_awaddr;
    wire [1:0] AXI_awburst;
    wire [3:0] AXI_awcache;
    wire [3:0] AXI_awid;
    wire [7:0] AXI_awlen;
    wire AXI_awlock;
    wire [2:0] AXI_awprot;
    wire [3:0] AXI_awqos;
    wire AXI_awready;
    wire [3:0] AXI_awregion;
    wire [2:0] AXI_awsize;
    wire AXI_awuser;
    wire AXI_awvalid;
    wire [3:0] AXI_bid;
    wire AXI_bready;
    wire [1:0] AXI_bresp;
    wire AXI_buser;
    wire AXI_bvalid;
    wire [DATA_WIDTH-1:0] AXI_rdata;
    wire [3:0] AXI_rid;
    wire AXI_rlast;
    wire AXI_rready;
    wire [1:0] AXI_rresp;
    wire AXI_ruser;
    wire AXI_rvalid;
    wire [DATA_WIDTH-1:0] AXI_wdata;
    wire AXI_wlast;
    wire AXI_wready;
    wire [3:0] AXI_wstrb;
    wire AXI_wuser;
    wire AXI_wvalid;
    wire AXI_aclk;
    wire AXI_aresetn;

    
    // Add UUT instance   
    AXI_master UUT
        ( 
        .go(go),                 
        .error(error),           
        .RNW(RNW),               
        .busy(busy),             
        .done(done),             
        .address(address),       
        .write_data(write_data), 
        .read_data(read_data),   
        .burst_length(burst_length),     
        .burst_size(burst_size),         
        .increment_burst(increment_burst),
        .clear_data_fifos(clear_data_fifos), 
        .write_fifo_en(write_fifo_en),       
        .write_fifo_empty(write_fifo_empty), 
        .write_fifo_full(write_fifo_full),   
        .read_fifo_en(read_fifo_en),    
        .read_fifo_empty(read_fifo_empty),   
        .read_fifo_full(read_fifo_full),     
        .M_AXI_aclk(AXI_aclk),
        .M_AXI_aresetn(AXI_aresetn),
        .M_AXI_araddr(AXI_araddr),
        .M_AXI_arburst(AXI_arburst),
        .M_AXI_arcache(AXI_arcache),
        .M_AXI_arid(AXI_arid),
        .M_AXI_arlen(AXI_arlen),
        .M_AXI_arlock(AXI_arlock),
        .M_AXI_arprot(AXI_arprot),
        .M_AXI_arqos(AXI_arqos),
        .M_AXI_arready(AXI_arready),
        .M_AXI_arregion(AXI_arregion),
        .M_AXI_arsize(AXI_arsize),
        .M_AXI_arvalid(AXI_arvalid),
        .M_AXI_awaddr(AXI_awaddr),
        .M_AXI_awburst(AXI_awburst),
        .M_AXI_awcache(AXI_awcache),
        .M_AXI_awid(AXI_awid),
        .M_AXI_awlen(AXI_awlen),
        .M_AXI_awlock(AXI_awlock),
        .M_AXI_awprot(AXI_awprot),
        .M_AXI_awqos(AXI_awqos),
        .M_AXI_awready(AXI_awready),
        .M_AXI_awregion(AXI_awregion),
        .M_AXI_awsize(AXI_awsize),
        .M_AXI_awvalid(AXI_awvalid),
        .M_AXI_bid(AXI_bid),
        .M_AXI_bready(AXI_bready),
        .M_AXI_bresp(AXI_bresp),
        .M_AXI_bvalid(AXI_bvalid),
        .M_AXI_rdata(AXI_rdata),
        .M_AXI_rid(AXI_rid),
        .M_AXI_rlast(AXI_rlast),
        .M_AXI_rready(AXI_rready),
        .M_AXI_rresp(AXI_rresp),
        .M_AXI_rvalid(AXI_rvalid),
        .M_AXI_wdata(AXI_wdata),
        .M_AXI_wlast(AXI_wlast),
        .M_AXI_wready(AXI_wready),
        .M_AXI_wstrb(AXI_wstrb),
        .M_AXI_wvalid(AXI_wvalid)
        );


    // Add Block Diagram design
    design_1_wrapper design_1_wrapper_inst
        ( 
        .S_AXI_araddr(AXI_araddr),
        .S_AXI_arburst(AXI_arburst),
        .S_AXI_arcache(AXI_arcache),
        .S_AXI_arid(AXI_arid),
        .S_AXI_arlen(AXI_arlen),
        .S_AXI_arlock(AXI_arlock),
        .S_AXI_arprot(AXI_arprot),
        .S_AXI_arqos(AXI_arqos),
        .S_AXI_arready(AXI_arready),
        .S_AXI_arregion(AXI_arregion),
        .S_AXI_arsize(AXI_arsize),
        .S_AXI_aruser(AXI_aruser),
        .S_AXI_arvalid(AXI_arvalid),
        .S_AXI_awaddr(AXI_awaddr),
        .S_AXI_awburst(AXI_awburst),
        .S_AXI_awcache(AXI_awcache),
        .S_AXI_awid(AXI_awid),
        .S_AXI_awlen(AXI_awlen),
        .S_AXI_awlock(AXI_awlock),
        .S_AXI_awprot(AXI_awprot),
        .S_AXI_awqos(AXI_awqos),
        .S_AXI_awready(AXI_awready),
        .S_AXI_awregion(AXI_awregion),
        .S_AXI_awsize(AXI_awsize),
        .S_AXI_awuser(AXI_awuser),
        .S_AXI_awvalid(AXI_awvalid),
        .S_AXI_bid(AXI_bid),
        .S_AXI_bready(AXI_bready),
        .S_AXI_bresp(AXI_bresp),
        .S_AXI_buser(AXI_buser),
        .S_AXI_bvalid(AXI_bvalid),
        .S_AXI_rdata(AXI_rdata),
        .S_AXI_rid(AXI_rid),
        .S_AXI_rlast(AXI_rlast),
        .S_AXI_rready(AXI_rready),
        .S_AXI_rresp(AXI_rresp),
        .S_AXI_ruser(AXI_ruser),
        .S_AXI_rvalid(AXI_rvalid),
        .S_AXI_wdata(AXI_wdata),
        .S_AXI_wlast(AXI_wlast),
        .S_AXI_wready(AXI_wready),
        .S_AXI_wstrb(AXI_wstrb),
        .S_AXI_wuser(AXI_wuser),
        .S_AXI_wvalid(AXI_wvalid),
        .s_axi_aclk(AXI_aclk),
        .s_axi_aresetn(AXI_aresetn)        
        );


    // Add module to generate the go signal
    generate_go_signal generate_go_signal
        (
        .clk(AXI_aclk),
        .resetn(AXI_aresetn),
        .request_to_go(request_to_go),
        .done(done),
        .busy(busy)
        );


    // Add BFM Test Module
    // Unused inputs can be tied to 0 and outputs not connected
    bfm_test bfm_test_stimuli
        (
        .clk(AXI_aclk),
        .rst_n(AXI_aresetn),
        .sys_rst_n(sys_rst_n),
        .init_done(1'b0),
        .interrupt()
        );
    
    // Add an instance which represents the rest of the user's design
    master_stimulus master_stimulus
        (
        .clk(AXI_aclk),
        .resetn(AXI_aresetn),
        .request_to_go(request_to_go),
        .go(go),
        .error(error),
        .RNW(RNW),
        .busy(busy),
        .done(done),
        .address(address),
        .write_data(write_data),
        .read_data(read_data),
        .burst_length(burst_length),
        .burst_size(burst_size),
        .increment_burst(increment_burst),
        .clear_data_fifos(clear_data_fifos),
        .write_fifo_en(write_fifo_en),
        .write_fifo_empty(write_fifo_empty),
        .write_fifo_full(write_fifo_full),
        .read_fifo_en(read_fifo_en),
        .read_fifo_empty(read_fifo_empty),
        .read_fifo_full(read_fifo_full)
        );


    // Generate clocks and resets via a simple module
    clk_reset_gen sim_clock_reset_generator
        (
        .clk(AXI_aclk),
        .resetn(AXI_aresetn)
        );

endmodule

