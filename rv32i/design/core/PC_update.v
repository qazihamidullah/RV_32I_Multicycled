//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  PC_update.v       
// Description: Calculate the value of next PC 
//  
//  
//###############################################
module PC_update(
  input         [31:0]        PC_out,
  input         [31:0]        rs1_out,
  input         [31:0]        imm_data,
  input                       PC_sel_A,
  input                       PC_sel_B,
  output        [31:0]        PC_input

);

    wire        [31:0]        in1;
    wire        [31:0]        in2;

    assign in1 = (PC_sel_A) ? rs1_out  : PC_out;
    assign in2 = (PC_sel_B) ? imm_data : 32'd4;

    assign PC_input = in1 + in2;      


endmodule