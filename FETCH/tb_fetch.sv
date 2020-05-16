`timescale 1ns/1ps

program tb_fetch #(parameter  DEPTHI = 8, WIDTH = 32)
(  
   input  wire                  clk,       //Clock Signal
                                rst,       //Reset Signal
   output  reg                  IorD,      //Control of MUX
   output  reg   [(DEPTHI-1):0] Arslt,     //ALU Result
   input   reg   [5:0]          Opcode,    //Specification of Instruction
   input   reg   [4:0]          Reg1,      //Register Specifications
                                Reg2,          
   input   reg   [15:0]         Inmediate,  //Immediate Constant Value
   input   reg   [(DEPTHI-1):0] sumed
);

integer file;

initial begin

   file = $fopen("output.log","w");
	
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   $fdisplay(file,"Log file begins");
   $fmonitor(file,"OP: %h, Reg1: %h, Reg2: %h, Inm: %h --> %t", Opcode, Reg1, Reg2, Inmediate, $realtime);
  
   #400;
end

initial begin

   Arslt <= 'h10;
   IorD  <= 0;
   #20;
   
   for (int i=0; i<10; i++) begin
      @(posedge clk);
   end
   
   IorD  <= 1;
   @(posedge clk);

 

end

endprogram