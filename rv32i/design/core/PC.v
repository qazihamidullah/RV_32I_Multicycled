//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  PC.v       
// Description: Program Counter register which  
//  provides addresses to Intsructions Memory
//  
//###############################################

module PC (
    input               clk,
    input               reset,
    input      [31:0]   in1,
    input               PC_en,
    output reg [31:0]   PC_out                        
);

  always @(posedge clk or negedge reset) 
    if(!reset)
      PC_out <= 0;
    else if(PC_en)
      PC_out <= in1;  
    else 
      PC_out <= PC_out;                         

endmodule