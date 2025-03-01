//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  pkg.sv       
// Description: This module contains enums which are
//  used in the design. 
//  
//###############################################

package risc_v_core_pkg;


typedef enum logic [6:0] { 
    R_type        =   7'b0110011,
    load_type     =   7'b0000011,
    I_type        =   7'b0010011,
    jalr_type     =   7'b1100111,
    S_type        =   7'b0100011,
    B_type        =   7'b1100011,
    lui_type      =   7'b0110111,
    auipc_type    =   7'b0010111,
    J_type        =   7'b1101111
 } opcode_t;   // instruction I, R, SB etc



 typedef enum logic [15:0] { 
  // NOP
    NOP,
  // R_type 
    ADD,  SUB,  SLL,    SLT,  SLTU,
    XOR,  SRL,  SRA,    OR,   AND,
  
  // I_type
    ADDI, SLTI, SLTIU,  XORI, ORI,
    ANDI, SLLI, SRAI,   SRLI, 

    // load 
    LB,   LH,   LW,     LBU,  LHU,

    // jump and link
    JALR, 
  
  // S_type
    SB,   SH,   SW,     
  
  // B_type 
    BEQ,  BNE,  BLT,    BGE,  BLTU,
    BGEU,
  
  // U_type 
    LUI,  AUIPC,
  
  // J_type 
    JAL

  } instr_name_t;

typedef logic [4:0] rs1_addr_t;
typedef logic [4:0] rs2_addr_t;
typedef logic [4:0] rd_addr_t;

typedef logic [2:0] funct3_t;
typedef logic [6:0] funct7_t;

typedef logic [11:0]  imm_I_t;
typedef logic [11:0]  imm_S_t;
typedef logic [12:0]  imm_B_t;
typedef logic [31:0]  imm_U_t;
typedef logic [20:0]  imm_J_t;

typedef logic         PC_sel_t;
typedef logic         ALU_A_sel_t;
typedef logic [1:0]   ALU_B_sel_t;
typedef logic [4:0]   ALU_op_t;
typedef logic         wren_t;
typedef logic [2:0]   imm_mux_sel_t;


typedef struct packed {


  instr_name_t  instr_name;
  opcode_t      opcode    ;
  
  // R type 
  funct3_t      funct3    ;
  rs1_addr_t    rs1_addr  ;
  rs2_addr_t    rs2_addr  ;
  rd_addr_t     rd_addr   ;
  funct7_t      funct7    ;

  // I typed 
  imm_I_t       imm_I     ;

  // S typed 
  imm_S_t       imm_S     ;

  // B typed 
  imm_B_t       imm_B     ;

  // B typed 
  imm_U_t       imm_U     ;

  // J typed 
  imm_J_t       imm_J     ;
  
  
} instruction_t;

typedef struct packed {
  
  //PC Control Lines
  PC_sel_t        PC_A_Sel;
  PC_sel_t        PC_B_Sel;


  //ALU Control Lines 
  ALU_A_sel_t     ALU_A_sel;
  ALU_B_sel_t     ALU_B_sel;
  ALU_op_t        ALU_op;



  //Write enable signals
  wren_t          reg_file_wren;
  wren_t          reg_write_data_sel;
  wren_t          data_mem_wren;


  //Immediate Value Select
  imm_mux_sel_t   imm_mux_sel ;



} Control_signals_t;


  

endpackage

 