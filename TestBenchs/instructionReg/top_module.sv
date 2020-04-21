`timescale 1ns/1ps

module top_module();

localparam DEPTH = 10, WIDTH = 32;

  bit clk; 
  wire         IRWrite;        //Bit of control
  wire [31:0] InstructionIn;  //Instruction Input
  wire [5:0]  Upcode;  //Specification of Instruction
  wire [4:0]  Reg1, Reg2;     //Register Specifications
 wire[15:0] Inmediate;       //Immediate Constant Value

instructionReg instructionReg (
    .IRWrite          (IRWrite),
    .InstructionIn    (InstructionIn),
    .Upcode           (Upcode),
    .Reg1             (Reg1),
    .Reg2             (Reg2),
    .Inmediate        (Inmediate)
);

tb_reg tb_reg (
    .clk              (clk),
    .IRWrite          (IRWrite),
    .InstructionIn    (InstructionIn),
    .Upcode           (Upcode),
    .Reg1             (Reg1),
    .Reg2             (Reg2),
    .Inmediate        (Inmediate)
);




always
    #20 clk = !clk;

endmodule