module instructionReg
(
   input reg         IRWrite,        //Bit of control
   input reg  [31:0] InstructionIn,  //Instruction Input
   output reg [5:0]  Upcode,         //Specification of Instruction
   output reg [4:0]  Reg1, Reg2,     //Register Specifications
   output reg [15:0] Inmediate       //Immediate Constant Value
);

reg [31:0] Instruction;


assign Instruction = IRWrite ? InstructionIn:Instruction;    //Write New Data
                                       //         __________
assign Upcode    = Instruction[31:26]; //  INST-->|        |-->Upcode
assign Reg1      = Instruction[25:21]; //         |  Inst  |-->Reg1
assign Reg2      = Instruction[20:16]; //         |  Reg   |-->Reg2 
assign Inmediate = Instruction[15:0];  //         |________|-->Inmediate



endmodule
