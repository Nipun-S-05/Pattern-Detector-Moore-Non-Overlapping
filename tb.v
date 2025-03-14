`include "moore_non_over.v"

module tb;


	parameter S_R=5'b00001;
	parameter S_B=5'b00010;
	parameter S_BC=5'b00100;
	parameter S_BCB=5'b01000;
	parameter S_BCBB=5'b10000;

	reg clk_i,rst_i,in,valid_i;
	 wire out;
	integer count;

 moore_non_over dut (clk_i,rst_i,in,valid_i,out);

always begin
	clk_i=0;#5;
	clk_i=1;#5;
end

initial begin
	clk_i=0;rst_i=1;
	in=0;
	valid_i=0;
	count=0;
	repeat(2)@(posedge clk_i);
	rst_i=0;
	repeat(50) begin
	@(posedge clk_i);
	valid_i=1;
	in=$random;
	end
	@(posedge clk_i);
	valid_i=0;
	in=0;
	$display("number of times pattern is detected=%d",count);
end

initial #1000 $finish();

always @(posedge out) count=count+1; 

endmodule
