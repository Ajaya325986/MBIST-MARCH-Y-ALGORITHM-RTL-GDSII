module memory#(parameter RAWIDTH = 2,  CAWIDTH = 4)
(input clk,input rst,input [3:0] CA ,input we,input [7:0] datain,input re,output reg [7:0] dataout);

reg [7:0] memory [15:0];

integer i;

always @(posedge clk)
begin
	if(rst)
	begin
		for(i=0; i <16 ;i=i+1)
			begin
				memory[i] <= 0;

			end
	end
	else
		begin
			if(we)
				memory[CA] <= datain;
		end
end



always @ (posedge clk)
begin
	if(re)
		dataout <= memory[CA];
end

endmodule
