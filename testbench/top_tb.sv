`timescale 1ns / 1ps

module top_tb #(
	parameter SEG_COUNT = 2,
	parameter SEG_DATA_WIDTH = 256,
	parameter SEG_EMPTY_WIDTH = $clog2(SEG_DATA_WIDTH/32),
	parameter TX_SEQ_NUM_WIDTH = 6,
	parameter PCIE_TAG_COUNT = 256,
	parameter BAR0_APERTURE = 24,
	parameter BAR2_APERTURE = 24,
	parameter BAR4_APERTURE = 16
);

	reg                                  clk;
	reg                                  rst;

	reg [3:0]                            user_led;

	reg [SEG_COUNT*SEG_DATA_WIDTH-1:0]   rx_st_data;
	reg [SEG_COUNT*SEG_EMPTY_WIDTH-1:0]  rx_st_empty;
	reg [SEG_COUNT-1:0]                  rx_st_sop;
	reg [SEG_COUNT-1:0]                  rx_st_eop;
	reg [SEG_COUNT-1:0]                  rx_st_valid;
	reg                                  rx_st_ready;
	reg [SEG_COUNT-1:0]                  rx_st_vf_active;
	reg [SEG_COUNT*2-1:0]                rx_st_func_num;
	reg [SEG_COUNT*11-1:0]               rx_st_vf_num;
	reg [SEG_COUNT*3-1:0]                rx_st_bar_range;

	reg [SEG_COUNT*SEG_DATA_WIDTH-1:0]   tx_st_data;
	reg [SEG_COUNT-1:0]                  tx_st_sop;
	reg [SEG_COUNT-1:0]                  tx_st_eop;
	reg [SEG_COUNT-1:0]                  tx_st_valid;
	reg                                  tx_st_ready;
	reg [SEG_COUNT-1:0]                  tx_st_err;

	reg [7:0]                            tx_ph_cdts;
	reg [11:0]                           tx_pd_cdts;
	reg [7:0]                            tx_nph_cdts;
	reg [11:0]                           tx_npd_cdts;
	reg [7:0]                            tx_cplh_cdts;
	reg [11:0]                           tx_cpld_cdts;
	reg [SEG_COUNT-1:0]                  tx_hdr_cdts_consumed;
	reg [SEG_COUNT-1:0]                  tx_data_cdts_consumed;
	reg [SEG_COUNT*2-1:0]                tx_cdts_type;
	reg [SEG_COUNT*1-1:0]                tx_cdts_data_value;

	reg [31:0]                           tl_cfg_ctl;
	reg [4:0]                            tl_cfg_add;
	reg [1:0]                            tl_cfg_func;

	fpga_core top(
		.clk(clk),
		.rst(rst),
		.user_led(user_led),
		.rx_st_data(rx_st_data),
		.rx_st_empty(rx_st_empty),
		.rx_st_sop(rx_st_sop),
		.rx_st_eop(rx_st_eop),
		.rx_st_valid(rx_st_valid),
		.rx_st_ready(rx_st_ready),
		.rx_st_vf_active(rx_st_vf_active),
		.rx_st_func_num(rx_st_func_num),
		.rx_st_vf_num(rx_st_vf_num),
		.rx_st_bar_range(rx_st_bar_range),
		.tx_st_data(tx_st_data),
		.tx_st_sop(tx_st_sop),
		.tx_st_eop(tx_st_eop),
		.tx_st_valid(tx_st_valid),
		.tx_st_ready(tx_st_ready),
		.tx_st_err(tx_st_err),
		.tx_ph_cdts(tx_ph_cdts),
		.tx_pd_cdts(tx_pd_cdts),
		.tx_nph_cdts(tx_nph_cdts),
		.tx_npd_cdts(tx_npd_cdts),
		.tx_cplh_cdts(tx_cplh_cdts),
		.tx_cpld_cdts(tx_cpld_cdts),
		.tx_hdr_cdts_consumed(tx_hdr_cdts_consumed),
		.tx_data_cdts_consumed(tx_data_cdts_consumed),
		.tx_cdts_type(tx_cdts_type),
		.tx_cdts_data_value(tx_cdts_data_value),
		.tl_cfg_ctl(tl_cfg_ctl),
		.tl_cfg_add(tl_cfg_add),
		.tl_cfg_func(tl_cfg_func)
	);
	
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		#50;
		rst = 1'b1;
	end
	
	initial forever #10 clk = !clk;
endmodule
