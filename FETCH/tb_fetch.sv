`timescale 1ns/1ps

program tb_fetch #(parameter  DEPTHI = 16, WIDTH = 32)
(  
    input  wire                 clk,       //Clock Signal
                                rst,       //Reset Signal
    output reg                  Jump,      //Control of Jump MUX
    output reg                  Branch,    //Control of Branch MUX
    output reg                  Zero,      //ALU Zero Signal
    output reg                  stop,      //Signal to Stop Adder
    output reg   [(WIDTH-1):0]  signext,   //Sign Extend Value
    input  reg   [5:0]          Opcode,    //Specification of Instruction
    input  reg   [4:0]          Reg1,      //Register Specifications
                                Reg2,          
    input  reg   [15:0]         Immediate,  //Immediate Constant Value
    input  reg   [27:0]         jumped
);

integer file;

initial begin

   file = $fopen("output.log","w");
	
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   $fdisplay(file,"Log file begins");
   $fmonitor(file,"OP: %h, Reg1: %h, Reg2: %h, Imm: %h, jumped:%h --> %t", Opcode, Reg1, Reg2, Immediate, jumped, $realtime);
  
end

initial begin
  
   signext <= 'h0000_004;
   Jump    <= 1;
   Branch  <= 0;
   Zero    <= 1; 
   stop    <= 0;
   
   #40;

  
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      Jump    <= 0;
      
      for (int i=0; i<6; i++) begin
         @(posedge clk);
         @(posedge clk);
      end

   Branch  <= 1;
   Zero    <= 1;

      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
 




end

endprogram