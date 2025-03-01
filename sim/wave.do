onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_sel
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_out
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_in5
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_in4
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_in3
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_in2
add wave -noupdate /tb/soc_top_inst/core_inst/mux_imm_data/mux_in1
add wave -noupdate -divider PC
add wave -noupdate /tb/soc_top_inst/core_inst/PC_inst/reset
add wave -noupdate /tb/soc_top_inst/core_inst/PC_inst/PC_out
add wave -noupdate /tb/soc_top_inst/core_inst/PC_inst/PC_en
add wave -noupdate /tb/soc_top_inst/core_inst/PC_inst/in1
add wave -noupdate /tb/soc_top_inst/core_inst/PC_inst/clk
add wave -noupdate -divider PC_Updater
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/rs1_out
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/PC_sel_B
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/PC_sel_A
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/PC_out
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/PC_input
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/in2
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/in1
add wave -noupdate /tb/soc_top_inst/core_inst/PC_update_inst/imm_data
add wave -noupdate -divider Memory
add wave -noupdate /tb/soc_top_inst/memory_inst/wren_b
add wave -noupdate /tb/soc_top_inst/memory_inst/wren_a
add wave -noupdate /tb/soc_top_inst/memory_inst/sub_wire1
add wave -noupdate /tb/soc_top_inst/memory_inst/sub_wire0
add wave -noupdate /tb/soc_top_inst/memory_inst/q_b
add wave -noupdate /tb/soc_top_inst/memory_inst/q_a
add wave -noupdate /tb/soc_top_inst/memory_inst/data_b
add wave -noupdate /tb/soc_top_inst/memory_inst/data_a
add wave -noupdate /tb/soc_top_inst/memory_inst/clock
add wave -noupdate /tb/soc_top_inst/memory_inst/byteena_b
add wave -noupdate /tb/soc_top_inst/memory_inst/address_b
add wave -noupdate /tb/soc_top_inst/memory_inst/address_a
add wave -noupdate -divider IR
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/rs2
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/rs1
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/rd
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/opcode
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/instruction
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/func7
add wave -noupdate /tb/soc_top_inst/core_inst/Instrution_reg_Inst/func3
add wave -noupdate -divider {Register File}
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/write_data
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/we
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/rs2_out
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/rs2
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/rs1_out
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/rs1
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/reset
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/rd
add wave -noupdate -radix hexadecimal -childformat {{{/tb/soc_top_inst/core_inst/register_file_inst/ram[31]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[30]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[29]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[28]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[27]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[26]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[25]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[24]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[23]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[22]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[21]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[20]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[19]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[18]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[17]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[16]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[15]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[14]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[13]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[12]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[11]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[10]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[9]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[8]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[7]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[6]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[5]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[4]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[3]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[2]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[1]} -radix hexadecimal} {{/tb/soc_top_inst/core_inst/register_file_inst/ram[0]} -radix hexadecimal}} -subitemconfig {{/tb/soc_top_inst/core_inst/register_file_inst/ram[31]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[30]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[29]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[28]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[27]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[26]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[25]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[24]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[23]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[22]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[21]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[20]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[19]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[18]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[17]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[16]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[15]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[14]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[13]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[12]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[11]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[10]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[9]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[8]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[7]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[6]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[5]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[4]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[3]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[2]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[1]} {-height 15 -radix hexadecimal} {/tb/soc_top_inst/core_inst/register_file_inst/ram[0]} {-height 15 -radix hexadecimal}} /tb/soc_top_inst/core_inst/register_file_inst/ram
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/i
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/DATA_WIDTH
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/clk
add wave -noupdate /tb/soc_top_inst/core_inst/register_file_inst/ADDR_WIDTH
add wave -noupdate -divider execute
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/rs2_out
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/rs1_out
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/PC_out
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/in2
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/in1
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/imm_data
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/branch_flag
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/ALU_out
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/ALU_operation
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/ALU_B_sel
add wave -noupdate /tb/soc_top_inst/core_inst/execute_inst/ALU_A_sel
add wave -noupdate -divider LSU
add wave -noupdate /tb/soc_top_inst/core_inst/Load_Store_unit_inst/load_data
add wave -noupdate /tb/soc_top_inst/core_inst/Load_Store_unit_inst/ALU_out
add wave -noupdate /tb/soc_top_inst/core_inst/Load_Store_unit_inst/func3
add wave -noupdate /tb/soc_top_inst/core_inst/Load_Store_unit_inst/data_mem_out
add wave -noupdate /tb/soc_top_inst/core_inst/Load_Store_unit_inst/byteenable
add wave -noupdate -divider IR
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/W_en
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/reg_write_data_sel
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/PC_sel_B
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/PC_sel_A
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/imm_data_mux_sel
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/data_mem_W_en
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/branch_flag
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/ALU_sel
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/ALU_B_sel
add wave -noupdate /tb/soc_top_inst/core_inst/Instruction_Decoder_inst/ALU_A_sel
add wave -noupdate -divider uart
add wave -noupdate /tb/soc_top_inst/uart_en
add wave -noupdate /tb/soc_top_inst/data_mem_write_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 332
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {524 ps}
