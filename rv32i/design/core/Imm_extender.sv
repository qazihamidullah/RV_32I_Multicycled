//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  Imm_extender.sv       
// Description: Generates 32 bit Immediate value
//  in case where Immediate is required like load
//  immediate
//###############################################
import risc_v_core_pkg::*;

module Imm_extender(
  input         instruction_t                 instruction_o,
  input         logic           [2:0]         imm_mux_sel,
  output        logic           [31:0]        imm_data

);

    logic                       [31:0]        imm_data_I;
    logic                       [31:0]        imm_data_B;                //in case of branch instructions
    logic                       [31:0]        imm_data_J;               //in case of jump instructions
    logic                       [31:0]        imm_data_U;               //in case of U_type instructions
    logic                       [31:0]        imm_data_S;               //in case of S type instructions
  

  //Immediate values for different Instruction Types 
    assign imm_data_I = {{20{instruction_o.imm_I[11]}},instruction_o.imm_I};
    assign imm_data_B = {{19{instruction_o.imm_B[12]}},instruction_o.imm_B};
    assign imm_data_J = {{11{instruction_o.imm_J[20]}},instruction_o.imm_J};
    assign imm_data_U = instruction_o.imm_U;
    assign imm_data_S = {{20{instruction_o.imm_S[11]}},instruction_o.imm_S};
    

  // MUX that selects one of the Immediate 
    MUX mux_imm_data(
                  .mux_in1(imm_data_I),
                  .mux_in2(imm_data_B),
                  .mux_in3(imm_data_J),
                  .mux_in4(imm_data_U),
                  .mux_in5(imm_data_S),
                  .mux_sel(imm_mux_sel),
                  .mux_out(imm_data)
  );





endmodule