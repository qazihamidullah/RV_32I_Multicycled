//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  soc_top.sv       
// Description: This is the SOC Top module
//  
//  
//###############################################
import risc_v_core_pkg::*;

module soc_top(
  input           logic       clk_i,
  input           logic       rst_n_i

);

  logic            [31:0]            PC_out;
  logic            [31:0]            ALU_out;
  logic            [31:0]            data_mem_write_data;
  logic                              data_mem_W_en;
  logic            [31:0]            inst_mem_out;
  logic            [31:0]            data_mem_out;
  logic            [3:0]             byteenable;
  logic            [7:0]             test;
  logic                              mem_w_en;
  logic                              uart_en;
  mem_ntv_interface_if               mem_ntv_interface_imem();
  mem_ntv_interface_if               mem_ntv_interface_dmem();


  /// RV32_I Core Instanstiation
  RV_32I core_inst  (
   
          .clk(clk_i),                                              //goes to processor
          .reset(rst_n_i) ,                                         //goes to processor
          .mem_ntv_interface_imem(mem_ntv_interface_imem.core),
          .mem_ntv_interface_dmem(mem_ntv_interface_dmem.core)
          
  );

  
  // MEmory Instantiation 
  memory memory_inst (
    .address_a(mem_ntv_interface_imem.addr>>2),                 //This is for Instruction Memory 
    .address_b(mem_ntv_interface_dmem.addr>>2),                //This is for Data Memory 
    .byteena_b(mem_ntv_interface_dmem.byteenable),             //All the 4 bytes are valid data for now in case of testing 
    .clock(clk_i),                               
    .data_a(0),                          //Not required for Instruction Memory 
    .data_b(mem_ntv_interface_dmem.wdata),
    .wren_a(1'b0),                      //Nothing should be written in Instruction Memory 
    .wren_b(mem_ntv_interface_dmem.wren && (mem_ntv_interface_dmem.addr <= 32'h12000) && (mem_ntv_interface_dmem.addr >= 32'h10000)),             //Data Memory write enable 
    .q_a(mem_ntv_interface_imem.rdata),                 //Instruction Memory output 
	  .q_b(mem_ntv_interface_dmem.rdata)                  //Data memory output 
  );

  // Displaying Data in UART 
    assign uart_en = mem_ntv_interface_dmem.addr == 32'h800000 && mem_ntv_interface_dmem.wren == 1;
  always @(*) begin
    if(uart_en) begin 
       $write("%c",mem_ntv_interface_dmem.wdata[7:0]);  
    end

  end


  
endmodule