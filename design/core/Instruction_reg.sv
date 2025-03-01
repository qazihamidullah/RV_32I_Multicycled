//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  Instruction_reg.sv       
// Description: Decode instructions based on opcode 
//  
//  
//###############################################
import risc_v_core_pkg::*;
module Instruction_reg(
                  input     logic                 [31:0]    instruction,
                  input     logic                           branch_flag,
                  input     logic                           reg_file_w_en,
                  output    instruction_t                   instruction_o, 
                  output    Control_signals_t               controls_o
                  // output reg  [6:0]     opcode,
                  // output reg  [4:0]     rd,
                  // output reg  [4:0]     rs1,
                  // output reg  [4:0]     rs2,
                  // output reg  [2:0]     funct3,
                  // output reg  [6:0]     funct7
);

/// assignginging values to instruction sources
    assign  instruction_o.opcode      =  opcode_t'(instruction[ 6: 0]); 

    assign  instruction_o.funct3      =  instruction[14:12]; 
    assign  instruction_o.funct7      =  instruction[31:25]; 

    assign  instruction_o.rs1_addr    =  instruction[19:15]; 
    assign  instruction_o.rs2_addr    =  instruction[24:20]; 
    assign  instruction_o.rd_addr     =  instruction[11: 7]; 

    assign  instruction_o.imm_I       =  instruction[31:20]; 
    assign  instruction_o.imm_S       =  {  instruction[31:25], 
                                            instruction[11:7]}; 

    assign  instruction_o.imm_B       =  {  instruction[31]   ,
                                            instruction[7 ]   ,
                                            instruction[30:25],
                                            instruction[11:8] ,
                                            1'b0            } ;

    assign  instruction_o.imm_U       = { instruction[31:12]  ,
                                          12'b0             } ; 

    assign  instruction_o.imm_J       = { instruction[31]     ,
                                          instruction[19:12]  ,
                                          instruction[20]     ,
                                          instruction[30:21]  ,
                                          1'b0              } ; 
///
   always_comb begin
    case (instruction_o.opcode)
      R_type      : begin
        case (instruction_o.funct3)
          3'b000: instruction_o.instr_name  = (instruction_o.funct7==0)? ADD  : SUB;
          3'b001: instruction_o.instr_name  = SLL   ;
          3'b010: instruction_o.instr_name  = SLT   ;
          3'b011: instruction_o.instr_name  = SLTU  ;
          3'b100: instruction_o.instr_name  = XOR   ;
          3'b101: instruction_o.instr_name  = (instruction_o.funct7==0)? SRL  : SRA;
          3'b110: instruction_o.instr_name  = OR    ;
          3'b111: instruction_o.instr_name  = AND   ;
          default: instruction_o.instr_name  = ADD   ;
        endcase

      end
      load_type   : begin
        case (instruction_o.funct3)
          3'b000: instruction_o.instr_name  = LB    ;
          3'b001: instruction_o.instr_name  = LH    ;
          3'b010: instruction_o.instr_name  = LW    ;
          3'b100: instruction_o.instr_name  = LBU   ;
          3'b101: instruction_o.instr_name  = LHU   ;         
          default: instruction_o.instr_name  = LB    ;
        endcase
      end
      I_type      : begin
        case (instruction_o.funct3)
          3'b000: instruction_o.instr_name  = ADDI  ;
          3'b001: instruction_o.instr_name  = SLLI  ;
          3'b010: instruction_o.instr_name  = SLTI  ;
          3'b011: instruction_o.instr_name  = SLTIU ;
          3'b100: instruction_o.instr_name  = XORI  ;
          3'b101: instruction_o.instr_name  = (instruction_o.funct7==0)? SRLI  : SRAI;
          3'b110: instruction_o.instr_name  = ORI   ;
          3'b111: instruction_o.instr_name  = ANDI  ;
          default: instruction_o.instr_name  = ADDI  ;
        endcase
      end
      jalr_type   : instruction_o.instr_name  = JALR  ;
      S_type      : begin
        case (instruction_o.funct3)
          3'b000: instruction_o.instr_name  = SB    ;
          3'b001: instruction_o.instr_name  = SH    ;
          3'b010: instruction_o.instr_name  = SW    ; 
          default: instruction_o.instr_name  = SB    ;
        endcase
      end
      B_type      : begin
        case (instruction_o.funct3)
          3'b000: instruction_o.instr_name  = BEQ   ;
          3'b001: instruction_o.instr_name  = BNE   ;
          3'b100: instruction_o.instr_name  = BLT   ;
          3'b101: instruction_o.instr_name  = BGE   ;
          3'b110: instruction_o.instr_name  = BLTU  ;
          3'b111: instruction_o.instr_name  = BGEU  ;
          default: instruction_o.instr_name  = BEQ   ;
        endcase
      end
      lui_type    : instruction_o.instr_name  = LUI     ;
      auipc_type  : instruction_o.instr_name  = AUIPC   ;
      J_type      : instruction_o.instr_name  = JAL     ;
      default:    ;
    endcase
   end



      //Controller 

      always_comb begin

        controls_o.PC_A_Sel = 1'd0;
        controls_o.PC_B_Sel = 1'd0;
        controls_o.ALU_A_sel = 1'd0;
        controls_o.ALU_B_sel = 2'd0;
        controls_o.reg_write_data_sel = 1'd0;
        controls_o.reg_file_wren = 1'b1;
        controls_o.ALU_op = 5'b00000;
        controls_o.imm_mux_sel = 3'd0;
        controls_o.data_mem_wren = 1'd0;

    case (instruction_o.opcode)
      R_type      : begin
                    controls_o.PC_A_Sel = 1'd0;
                    controls_o.PC_B_Sel = 1'd0;
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd0;
                    controls_o.reg_write_data_sel = 1'd0;
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
                    case (instruction_o.instr_name)
                            ADD:   controls_o.ALU_op = 5'b00000;             //ALU should add
                            SUB:   controls_o.ALU_op = 5'b00001;             //ALU should sub
                            XOR:   controls_o.ALU_op = 5'b00010;             //ALU should xor
                            OR:    controls_o.ALU_op = 5'b00100;            //ALU should or
                            AND:   controls_o.ALU_op = 5'b00011;            //ALU should and
                            SLL:   controls_o.ALU_op = 5'b00101;            //ALU should shift left logical
                            SRL:   controls_o.ALU_op = 5'b00110;            //shift right logical          
                            SRA:   controls_o.ALU_op = 5'b00111;            //shift right arithmetic 
                            SLT:   controls_o.ALU_op = 5'b01000;           //shift less than
                            SLTU:  controls_o.ALU_op = 5'b01001;           //shift less than immediate
                            default:  begin controls_o.reg_file_wren = 1'b0; controls_o.ALU_op = 5'b11111; end
                            endcase
      end

      I_type:       begin
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd1;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd0;
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
                    case (instruction_o.instr_name)
                            ADDI:   controls_o.ALU_op = 5'b00000;             //ALU should add
                            XORI:   controls_o.ALU_op = 5'b00010;             //ALU should xor
                            ORI:    controls_o.ALU_op = 5'b00100;            //ALU should or
                            ANDI:   controls_o.ALU_op = 5'b00011;            //ALU should and
                            SLLI:   controls_o.ALU_op = 5'b00101;            //ALU should shift left logical
                            SRLI:   controls_o.ALU_op = 5'b00110;            //shift right logical          
                            SRAI:   controls_o.ALU_op = 5'b00111;            //shift right arithmetic 
                            SLTI:   controls_o.ALU_op = 5'b01000;           //shift less than
                            SLTIU:  controls_o.ALU_op = 5'b01001;           //shift less than immediate
                            default:  begin controls_o.reg_file_wren = 1'b0; controls_o.ALU_op = 5'b11111; end
                            endcase
      end 
      load_type:    begin
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd1;
                    controls_o.reg_write_data_sel = 1'd1;
                    controls_o.imm_mux_sel = 3'd0;
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
                    controls_o.ALU_op = 5'b00000;             //ALU should add
                    controls_o.data_mem_wren = 1'd0;
      end

      jalr_type:    begin
                    controls_o.PC_A_Sel = 1'd1;
                    controls_o.PC_B_Sel = 1'd1;
                    controls_o.ALU_A_sel = 1'd1;
                    controls_o.ALU_B_sel = 2'd2;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd0;
                    controls_o.ALU_op = 5'b00000;             //ALU should add
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
      end

      S_type:       begin
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd1;
                    controls_o.ALU_op = 5'b00000;             //ALU should add
                    controls_o.data_mem_wren = 1'd1;
                    controls_o.imm_mux_sel = 3'd4;
      end

      B_type:       begin
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd0;
                    controls_o.imm_mux_sel = 3'd1;
                    if(branch_flag) begin
                      controls_o.PC_A_Sel = 1'd0;
                      controls_o.PC_B_Sel = 1'd1;
                    end
                    else begin 
                      controls_o.PC_A_Sel = 1'd0;
                      controls_o.PC_B_Sel = 1'd0;
                    end
                    case (instruction_o.instr_name)
                      BEQ:         controls_o.ALU_op = 5'd10;
                      BNE:         controls_o.ALU_op = 5'd11;
                      BLT:         controls_o.ALU_op = 5'd12;
                      BGE:         controls_o.ALU_op = 5'd13;
                      BLTU:        controls_o.ALU_op = 5'd14;
                      BGEU:        controls_o.ALU_op = 5'd15;
                      default:     controls_o.ALU_op = 5'dx;
                    endcase
      end

      lui_type:     begin
                    controls_o.ALU_B_sel = 2'd1;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd3;
                    controls_o.ALU_op = 5'd16;
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
      end

      auipc_type:   begin
                    controls_o.ALU_A_sel = 1'd1;
                    controls_o.ALU_B_sel = 2'd1;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd3;
                    controls_o.ALU_op = 5'd17;
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
      end

      J_type:       begin
                    controls_o.PC_A_Sel = 1'd0;
                    controls_o.PC_B_Sel = 1'd1;
                    controls_o.ALU_A_sel = 1'd1;
                    controls_o.ALU_B_sel = 2'd2;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd2;
                    controls_o.ALU_op = 5'b00000;             //ALU should add
                    if(reg_file_w_en)
                      controls_o.reg_file_wren = 1'b1;                           //write enable is on for writeback into the registers
                    else 
                      controls_o.reg_file_wren = 1'b0;
      end

      default:      begin
                    controls_o.reg_file_wren = 1'b0;
                    controls_o.ALU_op = 5'b11111;
                    controls_o.reg_write_data_sel = 1'd0;
                    controls_o.imm_mux_sel = 3'd0;
                    controls_o.data_mem_wren = 1'd0;
                    controls_o.PC_A_Sel = 1'd0;
                    controls_o.PC_B_Sel = 1'd0;
                    controls_o.ALU_A_sel = 1'd0;
                    controls_o.ALU_B_sel = 2'd0;
      end
      endcase

      end





endmodule
