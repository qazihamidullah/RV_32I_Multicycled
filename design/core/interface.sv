//###############################################
// Author:  Qazi Hamid Ullah (hamidullahqazi12@gmail.com)
// Date:	  2/24/2024
// Module:  interface.sv       
// Description: This is an interface module for better 
//  handling of signals.
//  
//###############################################
interface mem_ntv_interface_if ();
        logic [31:0]    addr;
        logic [31:0]    wdata;
        logic [31:0]    rdata;
        logic           wren;
        logic           r_en;
        logic [3:0]     byteenable;

        modport core    ( output addr, 
                        output  wdata,
                        input   rdata,
                        output  wren,
                        output  r_en,
                        output  byteenable );
                        
        modport soc     ( input  addr,
                        input   wdata,
                        output  rdata,
                        input   wren,
                        input   r_en,
                        input   byteenable
                                          );

endinterface
