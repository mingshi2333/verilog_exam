// counter.v

`timescale 1ns / 1ps

module counter(
  input clk,
  input clr,
  output [3:0] q
);
reg [3:0] q_temp;
assign q = q_temp;
always @(posedge clk or negedge clr)
  if (~clr)
    q_temp <= 4'b0000;
  else if (q_temp == 4'b1001)
    q_temp <= 4'b0000;
  else
    q_temp <= q_temp + 1'b1;
endmodule


module counter_tb;
reg clr;
reg clk;
wire [3:0] q;

counter tb(
  .clr(clr),
  .clk(clk),
  .q(q)
);

initial begin
  $dumpfile("run.vcd");
  $dumpvars;
  clr = 0;
  clk = 0;
  #40
  clr = 1;
end

always #10 clk = ~clk;

initial #500 $finish;
endmodule