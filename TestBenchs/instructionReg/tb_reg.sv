`timescale 1ns/1ps

program tb_reg 
(
   input wire        clk,            //Clock signal  
   output reg         IRWrite,        //Bit of control
   output reg [31:0] InstructionIn,  //Instruction Input
   input reg [5:0]  Upcode,         //Specification of Instruction
   input reg [4:0]  Reg1, Reg2,     //Register Specifications
   input reg [15:0] Inmediate       //Immediate Constant Value
);


initial
begin
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   Write();
end



//***********************************************
task Write();
     $display(">> Write verification");
//Write enable
    IRWrite = 0;
    InstructionIn = 'hffff_ffff;
    @(posedge clk);
    $display("Inmediate: %h", Inmediate);
     @(posedge clk);
    IRWrite = 1;
    InstructionIn = 'hffff_ff00;
     @(posedge clk);
    $display("Inmediate: %h", Inmediate);
     @(posedge clk);
    IRWrite = 0; 
    InstructionIn = 'hffff_ff00;
     @(posedge clk);
    $display("Inmediate: %h", Inmediate);



endtask
//***********************************************
endprogram