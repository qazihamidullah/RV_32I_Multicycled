//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:    2/24/2024
// Module:  ALU.v       
// Description: This is an ALU Module which performs
//  all the operations like +,-,*,/
//  
//###############################################
module ALU (
  input         [31:0]    input_1,
  input         [31:0]    input_2,
  input         [4:0]     ALU_sel,              //will determine which operation ALU will perform. This wil come from Decoder
  output reg              branch_flag,
  output reg    [31:0]    ALU_out           
);

      wire [4:0]  shamt;

      assign shamt = input_2[4:0];
    //Declaring Paramteres 
      parameter add = 5'd0, sub = 5'd1, xor_ = 5'd2, and_ = 5'd3, or_ = 5'd4;
      parameter sll = 5'd5, srl = 5'd6, sra  = 5'd7, slt  = 5'd8, sltu= 7'd9;
      parameter beq = 5'd10, bne =5'd11, blt = 5'd12, bge = 5'd13, bltu = 5'd14, bgeu = 5'd15, lui = 5'd16, auipc = 5'd17, slli = 5'd18, srli = 5'd19, srai = 5'd20; 

  //ALU Operations     
    always @(*) begin
		branch_flag = 1'b0; ALU_out = 32'd0;
      case (ALU_sel)
        add:    ALU_out = input_1 + input_2;
        sub:    ALU_out = input_1 - input_2;
        xor_:   ALU_out = input_1 ^ input_2;
        and_:   ALU_out = input_1 & input_2;
        or_:    ALU_out = input_1 | input_2;
        sll:    ALU_out = input_1 << input_2;
        slli:   ALU_out = input_1 << shamt;
        srl:    ALU_out = input_1 >> input_2;
        srli:   ALU_out = input_1 >> shamt;
        sra:    ALU_out = $signed(input_1) >>> input_2;                                        //MSB extends
        srai:   ALU_out = $signed(input_1) >>> shamt;
        slt:    ALU_out = ($signed(input_1) < $signed(input_2)) ? 1:0;
        sltu:   ALU_out = (input_1 < input_2) ? 1:0;                                  //zero extended output     
        beq:    branch_flag = (input_1 == input_2) ? 1'b1 : 1'b0;
        bne:    branch_flag = (input_1 != input_2) ? 1'b1 : 1'b0;
        blt:    branch_flag = (input_1 < input_2) ? 1'b1 : 1'b0;
        bge:    branch_flag = (input_1 >= input_2) ? 1'b1 : 1'b0;
        bltu:   branch_flag = (input_1 < input_2) ? 1'b1 : 1'b0;                      //zero extended
        bgeu:   branch_flag = (input_1 >= input_2) ? 1'b1 : 1'b0;                     //zero extended
        lui:    ALU_out = input_2 ;
        auipc:  begin 
                ALU_out = input_1 + input_2;
        end
        default: begin ALU_out = 32'd0;branch_flag = 1'b0; end            //default value zero 
      endcase
    end

endmodule