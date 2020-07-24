module sc_fifo(
input clk,rst,
input [7:0] din,
input wr,
output full,
output[7:0] dout,
input rd,
output empty
);
reg [7:0] buff[0:7];
reg [2:0] wr_ptr;
reg [2:0] rd_ptr;
reg [3:0] fifo_cntr;
assign full=fifo_cntr==8;
assign empty =fifo_cntr==0;
//valid read
wire valid_rd = ~empty & rd;
//valid write
wire valid_wr = ~full & wr;
