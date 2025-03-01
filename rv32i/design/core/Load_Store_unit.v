//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  Load_Store_unit.v       
// Description: Decide which bytes to load and store among 32 bits 
//  during load and store operations from data memory. 
//  
//###############################################
module Load_Store_unit(
  input       [31:0]      ALU_out,
  input       [31:0]      data_mem_out,
  input       [2:0]       func3,
  output reg  [3:0]       byteenable,
  output reg  [31:0]      load_data

);
  //store
  always @(*) begin
    case (func3) 
      3'd0:       begin 
                  case (ALU_out[1:0])
                    2'd0:     byteenable = 4'b0001;
                    2'd1:     byteenable = 4'b0010;
                    2'd2:     byteenable = 4'b0100;
                    2'd3:     byteenable = 4'b1000;
                  endcase
      end
      3'd1:       begin
                  if(ALU_out[1:0] == 0)
                    byteenable = 4'b0011;
                  else if (ALU_out[1:0] == 2) begin
                    byteenable = 4'b1100;
                  end 

      end
      3'd2:       byteenable = 4'b1111;
      default:    byteenable = 4'b0;
    endcase
  end
  
  //load unit 
  always @(*) begin 
    case(func3)
    3'd0:         begin
                  case(ALU_out[1:0])
                  2'd0:        load_data = {{24{data_mem_out[7]}},data_mem_out[7:0]};                            //sign extend   --> lb
                  2'd1:        load_data = {{24{data_mem_out[15]}},data_mem_out[15:8]};                            //sign extend   --> lb
                  2'd2:        load_data = {{24{data_mem_out[23]}},data_mem_out[23:16]};                            //sign extend   --> lb
                  2'd3:        load_data = {{24{data_mem_out[31]}},data_mem_out[31:24]};                            //sign extend   --> lb
    endcase
    end
    3'd1:         begin 
                  case(ALU_out[1:0])
                  2'd0:        load_data = {{16{data_mem_out[15]}},data_mem_out[15:0]};                          //sign extend   --> lh
                  2'd1:        load_data = {{16{data_mem_out[31]}},data_mem_out[31:16]};                            //sign extend   --> lb             
    endcase
                  
    end
    3'd2:         begin
                  load_data =  data_mem_out[31:0];                                                  //sign extend   --> lw
    end
    3'd4:         begin
                  case(ALU_out[1:0])
                  2'd0:        load_data = {24'd0,data_mem_out[7:0]};                            
                  2'd1:        load_data = {24'd0,data_mem_out[15:8]};                            //sign extend   --> lb
                  2'd2:        load_data = {24'd0,data_mem_out[23:16]};                            //sign extend   --> lb
                  2'd3:        load_data = {24'd0,data_mem_out[31:24]};                            //sign extend   --> lb
                  
                  endcase
                                                             //zero extend   --> lbu
    end
    3'd5:         begin 
                  case(ALU_out[1:0])
                  2'd0:        load_data = {16'd0,data_mem_out[15:0]};                          //zero extend   --> lhu
                  2'd1:        load_data = {16'd0,data_mem_out[31:16]};                                      
                  default:        load_data = data_mem_out;
    endcase
                                                          
    end
    default:      load_data = data_mem_out[31:0];
    endcase

  end

  
endmodule