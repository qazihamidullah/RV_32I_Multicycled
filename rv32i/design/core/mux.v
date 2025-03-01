//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  mux.v       
// Description: 5x1 mux 
//   
//  
//###############################################
module MUX (
        input [31:0]   mux_in1,
        input [31:0]  mux_in2,
        input [31:0]  mux_in3,
        input [31:0]   mux_in4,                            //zero extended
        input [31:0]  mux_in5,                            //zero extended   
        input [2:0]   mux_sel,
        output reg [31:0] mux_out                             
);

      always @ (*) begin
      case(mux_sel)
      3'd0:     mux_out = mux_in1;
      3'd1:     mux_out = mux_in2;
      3'd2:     mux_out = mux_in3;
      3'd3:     mux_out = mux_in4;
      3'd4:     mux_out = mux_in5;
      default:  mux_out = 32'dx;
      endcase
      end
endmodule
