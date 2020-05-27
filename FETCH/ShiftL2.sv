module ShiftL2
(
    input  reg  [4:0]   Reg1,      //Register Specifications
                        Reg2,          
    input  reg  [15:0]  Immediate, //Immediate Constant Value
    output reg  [27:0]  Jump       //Jump Address
);
reg [25:0] Instruction;

assign Instruction[25:21] = Reg1;
assign Instruction[20:16] = Reg2;
assign Instruction[15:0]  = Immediate;
    
assign Jump = 28'(Instruction << 2);  

endmodule