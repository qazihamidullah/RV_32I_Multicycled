//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  RISCV32I.sv       
// Description: This is the core top module
//  
//  
//###############################################
import risc_v_core_pkg::*;

module RV_32I(
  input                                       clk                         ,
  input                                       reset                       ,
  mem_ntv_interface_if                        mem_ntv_interface_imem      ,
  mem_ntv_interface_if                        mem_ntv_interface_dmem 

);
    

  ///Declaring wires 
    logic                 [31:0]              PC_input                    ;
    instruction_t                             instruction_o               ;
    Control_signals_t                         controls_o                  ;
    logic                 [31:0]              rs1_out                     ;
    logic                 [31:0]              pc_out                      ;
    logic                 [31:0]              imm_data                    ;                   //sign extended immediate data 
    logic                 [31:0]              reg_write_data              ;             //this will be stored in register file
    logic                 [31:0]              data_mem_write_data         ;        //this will be store in data memory                       
    logic                                     branch_flag                 ;                //to select the branch imm data in case of branch in PC input
    logic                 [31:0]              load_data                   ;
    logic                                     PC_en                       ;
    logic                                     reg_file_w_en               ;
    logic                 [31:0]              alu_out                     ;
    logic                                     mem_w_en                    ;
    logic                                     data_mem_wren               ;
    logic                 [31:0]              data_mem_out                ;
    logic                 [31:0]              inst_mem_out                ;
    logic                 [3:0]               byteenable                  ;
    logic                 [31:0]              rs2_out                     ;
    logic                 [31:0]              ALU_out                     ;
    logic                 [31:0]              PC_out                      ;
    logic                 [2:0]               count                       ;

    
    
    ///////////////////////////////////////////////////////////////
  //assigning values to IMEM
    assign            mem_w_en                                =   controls_o.data_mem_wren          ;
    assign            inst_mem_out                            =   mem_ntv_interface_imem.rdata      ;
    assign            mem_ntv_interface_imem.addr             =   PC_out                            ;

    //assigning values to DMEM
    assign            mem_ntv_interface_dmem.byteenable       =   byteenable                        ;
    assign            mem_ntv_interface_dmem.wdata            =   rs2_out                           ;
    assign            mem_ntv_interface_dmem.wren             =   data_mem_wren                     ;
    assign            data_mem_out                            =   mem_ntv_interface_dmem.rdata      ;
    assign            mem_ntv_interface_dmem.addr             =   ALU_out                           ;


  ///////////////////////////////////////////////////////////////
  
  //Immediate Extender 
    Imm_extender      Imm_extender_inst(
                                .instruction_o    (instruction_o)               ,
                                .imm_mux_sel      (controls_o.imm_mux_sel)      ,
                                .imm_data         (imm_data)
  );

  //PC update unit 
    PC_update         PC_update_inst(
                                .PC_out           (PC_out)                      ,                                  //comes from PC
                                .rs1_out          (rs1_out)                     ,                                //comes from register file
                                .imm_data         ({2'd0,imm_data[31:0]})       ,                 //comes from mux
                                .PC_sel_A         (controls_o.PC_A_Sel)         ,                   //comes from decoder
                                .PC_sel_B         (controls_o.PC_B_Sel)         ,                   //comes from decoder
                                .PC_input         (PC_input)                               //goes to PC
          );

  //Program Counter 
    PC                PC_inst(
                                .clk              (clk)                         ,
                                .reset            (reset)                       ,
                                .in1              (PC_input)                    ,                                   //comes from PC_update
                                .PC_en            (PC_en)                       ,                                    //comes from decoder
                                .PC_out           (PC_out)                                   //Goes to PC_update, ALU input
    );


  ///////////////////////////////////////////////////////////////////
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      count                   <=        0                                       ;
    end
    else if (count == 4) begin
      count                   <=        0                                       ;
    end
    else begin
      count                   <=        count + 1                               ;
    end
    end
  always @(posedge clk) begin
    if(count == 3)
      PC_en                   <=        1                                        ;
    else PC_en                <=        0                                        ;
  end
  always @(posedge clk) begin
    if(count == 3)
      reg_file_w_en <= 1;
    else
      reg_file_w_en <= 0;
  end

      //setting data mem wren for only 1 second 
       always @(*) begin
      if(count == 3)
        data_mem_wren         =         mem_w_en                                  ;
      else begin
        data_mem_wren         =         0                                         ;
      end
    end
  //Delaying PC by 1 cycle
    always @(posedge clk) begin
      pc_out                  <=        PC_out                                    ;
    end
  
  //Registering ALU out 
    always @(posedge clk) begin
        ALU_out               <=        alu_out                                   ;
    end
///////////////////////////////////////////////////////////////////////
  Instruction_reg   Instrution_reg_Inst(
                                  .instruction    (inst_mem_out )                 ,
                                  .branch_flag    (branch_flag)                   ,
                                  .reg_file_w_en  (reg_file_w_en)                 ,
                                  .instruction_o  (instruction_o)                 ,
                                  .controls_o     (controls_o) 
    );

  register_file     register_file_inst(
                                  .clk            (clk)                           ,
                                  .reset          (reset)                         ,
                                  .write_data     (reg_write_data)                ,
                                  .rs1            (instruction_o.rs1_addr)        ,                              //address of rs1 reg
                                  .rs2            (instruction_o.rs2_addr)        ,                              //address of rs2 reg
                                  .rd             (instruction_o.rd_addr)         ,
                                  .rs1_out        (rs1_out)                       ,
                                  .rs2_out        (rs2_out)                       ,
                                  .we             (controls_o.reg_file_wren)                                    //comes from decoder
    );

  execute           execute_inst(
                                  .rs1_out        (rs1_out)                       ,                             //comes from register file
                                  .PC_out         (pc_out)                        ,                             //comes from PC after being registered
                                  .rs2_out        (rs2_out)                       ,                             //comes from register file
                                  .imm_data       (imm_data)                      ,                             //comes from mux
                                  .ALU_A_sel      (controls_o.ALU_A_sel)          ,                             //comes from decoder
                                  .ALU_B_sel      (controls_o.ALU_B_sel)          ,                             //comes from decoder
                                  .ALU_operation  (controls_o.ALU_op)             ,                             //comes from decoder
                                  .ALU_out        (alu_out)                       ,                             //goes to data mem, Load store unit 
                                  .branch_flag    (branch_flag)                                                 //goes to PC_update
  );

  Load_Store_unit   Load_Store_unit_inst(
                                  .ALU_out        (ALU_out)                       ,
                                  .data_mem_out   (data_mem_out)                  ,
                                  .func3          (instruction_o.funct3)          ,
                                  .byteenable     (byteenable)                    ,
                                  .load_data      (load_data)
  );

  assign            reg_write_data   =   (controls_o.reg_write_data_sel) ? load_data : ALU_out   ;

endmodule