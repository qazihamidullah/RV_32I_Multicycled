//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  Instruction_Decoder.v       
// Description: Decode instructions based on opcode 
//  
//  
//###############################################

module Instruction_Decoder (
  input        [6:0]      opcode,
  input        [2:0]      func3,
  input        [6:0]      func7,
  input                   branch_flag,
  input                   reg_file_w_en,
  output reg              PC_sel_A,
  output reg              PC_sel_B,
  output reg              ALU_A_sel,
  output reg   [1:0]      ALU_B_sel,
  output reg   [4:0]      ALU_sel,
  output reg              W_en,
  output reg   [3:0]      imm_data_mux_sel,
  output reg              data_mem_W_en,
  output reg 	            reg_write_data_sel                                                                                        //will select what should be load into register ALU_out or data_mem
);
  

  //Declaring Parameters
    parameter R_type = 7'b0110011, I_type = 7'b0010011, Load_type = 7'b0000011, St_type = 7'b0100011, J_type = 7'b1101111;          //for opcode
    parameter B_type = 7'b1100011, U_type_lui = 7'b0110111, U_type_auipc = 7'b0010111, JALR_Type = 7'b1100111;
    parameter addsub = 3'h0, xor_ = 3'h4, or_ = 3'h6, and_ = 3'h7, sll = 3'h1, srla = 3'h5, slt = 3'h2, sltu = 3'h3;
    parameter ld_byte= 3'h0, lh   = 3'h1, lw  = 3'h2, lbu  = 3'h4, lhu = 3'h5;                                                      //for load inst
    parameter sb = 3'h0, sh = 3'h1, sw = 3'h2;                                                                                      //for store inst

  
    always @(*) begin
    W_en = 1'b0; ALU_sel = 5'b01111; reg_write_data_sel = 1'd0; data_mem_W_en = 1'b0; 
    PC_sel_A = 1'd0; PC_sel_B = 1'b0; ALU_A_sel = 1'b0; ALU_B_sel = 2'd0; imm_data_mux_sel = 3'd0;

                            
    case (opcode)
      R_type:               begin
                            PC_sel_A = 1'd0;
                            PC_sel_B = 1'b0;
                            ALU_A_sel = 1'b0;
                            ALU_B_sel = 2'd0;
                            reg_write_data_sel = 1'd0;
                            if(reg_file_w_en)
                              W_en = 1'b1;                          //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            case (func3)
                            addsub:   begin
                                      if(func7 == 7'h00)    
                                        ALU_sel = 5'b00000;         //ALU should add
                                      else
                                        ALU_sel = 5'b00001;         //ALU should sub
                            end
                            xor_:     ALU_sel = 5'b00010;           //ALU should xor
                            or_:      ALU_sel = 5'b00100;           //ALU should or
                            and_:     ALU_sel = 5'b00011;           //ALU should and
                            sll:      ALU_sel = 5'b00101;           //ALU should shift left logical
                            srla:     begin
                                      if(func7 == 7'h00)  
                                        ALU_sel = 5'b00110;         //shift right logical 
                                      else
                                        ALU_sel = 5'b00111;         //shift right arithmetic
                            end
                            slt:      ALU_sel = 5'b01000;           //shift less than
                            sltu:     ALU_sel = 5'b01001;           //shift less than immediate
                            default:  begin W_en = 1'b0; ALU_sel = 5'b11111; end
                            endcase
                            end


      I_type:               begin
                            ALU_A_sel = 1'b0;
                            imm_data_mux_sel = 3'd0;
                            ALU_B_sel = 2'd1;
                            reg_write_data_sel = 1'd0;
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            case (func3)
                                addsub:   ALU_sel = 5'b00000;           //ALU should add        
                                xor_:     ALU_sel = 5'b00010;           //ALU should xor
                                or_:      ALU_sel = 5'b00100;           //ALU should or
                                and_:     ALU_sel = 5'b00011;           //ALU should and
                                sll:      ALU_sel = 5'd18;           //ALU should shift left logical
                                srla:     begin
                                          if(func7 == 7'h00)         //for this case Immediate[11:5] = func7
                                            ALU_sel = 5'd19;         //shift right logical 
                                          else
                                            ALU_sel = 5'd20;         //shift right arithmetic
                                end 
                                slt:      ALU_sel = 5'b01000;           //shift less than
                                sltu:     ALU_sel = 5'b01001;           //shift less than immediate
                                default:  begin 
                                          W_en = 1'b0; ALU_sel = 5'b11111;   
                                end
                            endcase
						                end


      Load_type:            begin
                            ALU_A_sel = 1'b0;
                            ALU_B_sel = 2'd1;
                            imm_data_mux_sel = 3'd0;
                            reg_write_data_sel = 1'd1;
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            ALU_sel = 5'b00000;                    //ALU should add
                            data_mem_W_en = 1'b0;                 //data to be read from memory
                            end


      St_type:              begin
                            ALU_A_sel = 1'b0;
                            ALU_B_sel = 2'd1;
                            imm_data_mux_sel = 3'd4;
                            data_mem_W_en = 1'b1;                 //data to be write from memory
                            ALU_sel = 5'b00000;                    //ALU should add
                            end


      B_type:               begin
                            if(branch_flag) begin
                              PC_sel_A = 1'b0;
                              PC_sel_B = 1'b1;
                            end
                            else begin 
                              PC_sel_A = 1'b0;
                              PC_sel_B = 1'b0;
                            end
                            case (func3)
                              3'h0:         ALU_sel = 5'd10;
                              3'h1:         ALU_sel = 5'd11;
                              3'h4:         ALU_sel = 5'd12;
                              3'h5:         ALU_sel = 5'd13;
                              3'h6:         ALU_sel = 5'd14;
                              3'h7:         ALU_sel = 5'd15;
                              default:      ALU_sel = 5'dx;
                            endcase
                            ALU_A_sel = 1'b0;
                            ALU_B_sel = 2'd0;
                            
                            imm_data_mux_sel = 3'd1;
                            end


      J_type:               begin
                            ALU_A_sel = 1'b1;
                            ALU_B_sel = 2'd2;
                            PC_sel_A = 1'b0;
                            PC_sel_B = 1'b1;
                            ALU_sel = 5'b00000;
                            imm_data_mux_sel = 3'd2;
                            reg_write_data_sel = 1'd0;
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            end


      JALR_Type:            begin
                            ALU_A_sel = 1'b1;
                            ALU_B_sel = 2'd2;
                            PC_sel_A = 1'b1;
                            PC_sel_B = 1'b1;
                            ALU_sel = 5'b00000;
                            imm_data_mux_sel = 3'd0;
                            reg_write_data_sel = 1'd0;
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            end


      U_type_lui:           begin
                            ALU_B_sel = 2'd1;
                            reg_write_data_sel = 1'd0;
                            imm_data_mux_sel = 3'd3;
                            ALU_sel = 5'd16;                           //doing imm << 12 in ALU
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
      end


      U_type_auipc:         begin
                            ALU_A_sel = 1'b1;
                            ALU_B_sel = 2'd1;
                            if(reg_file_w_en)
                              W_en = 1'b1;                           //write enable is on for writeback into the registers
                            else 
                              W_en = 1'b0;
                            imm_data_mux_sel = 3'd3;
                            reg_write_data_sel = 1'd0;
                            ALU_sel = 5'd17;                           //doing PC + (imm << 12) in ALU  
                            end


      default: 	            begin
                            W_en = 1'b0;
                            ALU_sel = 5'b11111; 
                            reg_write_data_sel = 1'd0;
                            imm_data_mux_sel = 3'd0;
                            data_mem_W_en = 1'b0;
                            ALU_B_sel = 2'd0;
                            ALU_A_sel = 1'd0;
                            PC_sel_A = 1'd0;
                            PC_sel_B = 1'd0;
                            end
                        endcase
    end


endmodule