
//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	2/24/2024
// Module:  register_file.v       
// Description: This is a register file with 32 depth 
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock
//###############################################


module register_file
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
  input reset,
	input [(DATA_WIDTH-1):0] write_data,
  input [(ADDR_WIDTH-1):0] rs1, rs2, rd,
	input we, clk,
	output [(DATA_WIDTH-1):0] rs1_out, rs2_out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
  integer i;
  //assign ram[0] = 32'd0;          //The R0 register always have a 0 value 

	always @ (posedge clk or negedge reset)
	begin
		// Write
   // if(rs1 != 32'd0 & rs2 != 32'd0 & rd != 32'd0) begin
    if(!reset)
      for(i = 0; i<32; i = i+1) //: ram_block
        ram[i] <= 32'b0;
		else if (we && rd != 32'd0)
			ram[rd] <= write_data;
    end
 
    //Reading data 
		assign rs1_out = ram[rs1];            //read r1
    assign rs2_out = ram[rs2];            //read r2
endmodule
