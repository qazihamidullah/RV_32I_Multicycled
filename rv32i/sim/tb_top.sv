// instantiate soc_top .
// give stimulus 
`timescale 1 ps / 1 ps
// synopsys translate_on
module tb();

  reg clk;
  reg reset;

    soc_top soc_top_inst(
                  .clk_i(clk),
                  .rst_n_i(reset)
    );

  initial begin 

    #0 
    clk = 1'b0;
    reset = 1'b0;

    #1 
    reset = 1'b1;


    #100000000
    $stop();
    
  end

    always 
    #10 
    clk = ~clk;

endmodule