//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:    2/24/2024
// Module:  execute.v       
// Description: This is execute stage where ALU do 
//  the calculations and the inputs of ALU are selected
//  
//###############################################
module execute(
  input       [31:0]      rs1_out,
  input       [31:0]      PC_out,
  input       [31:0]      rs2_out,
  input       [31:0]      imm_data,
  input                   ALU_A_sel,
  input       [1:0]       ALU_B_sel,
  input       [4:0]       ALU_operation,
  output      [31:0]      ALU_out,
  output                  branch_flag
);

    wire      [31:0]      in1;
    reg       [31:0]      in2;

    assign in1 = (ALU_A_sel) ? PC_out   : rs1_out;

    always @(*) begin
      case (ALU_B_sel)
        2'd0:         in2 = rs2_out;
        2'd1:         in2 = imm_data;
        2'd2:         in2 = 32'd4;
        default:      in2 = 32'd4;
      endcase
    end
    

    ALU ALU_inst(
                .input_1(in1),
                .input_2(in2),
                .ALU_sel(ALU_operation),
                .branch_flag(branch_flag),
                .ALU_out(ALU_out)
    ); 

  
endmodule