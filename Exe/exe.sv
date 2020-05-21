module exe #(parameter WIDTH =32)
(
    input  wire              clk,        //Clock Signal
    input  wire              rst,        //Clock Signal
    input  reg [3:0]         ALUSrc,     //Mux Control   
    input  reg [3:0]         ALUOp,      //ALU Opcode            
    input  reg [15:0]        Immediate,  //[15:0] of Instruction 
    input  reg [(WIDTH-1):0] Reg1,       //Register 1 Data
    input  reg [(WIDTH-1):0] Reg2,       //Register 2 Data
    output reg [(WIDTH-1):0] ALUOut,     //Result of ALU
    output reg               zero        //Zero Flag Signal
);

reg [3:0]         ALU_Sel;
reg [(WIDTH-1):0] sign;
reg [(WIDTH-1):0] muxOut;

ALUctl u_ALUctl
(
    .clk          (clk),
    .rst          (rst),
    .Immediate    (Immediate),
    .ALUOp        (ALUOp),   
    .ALU_Sel      (ALU_Sel)
);

ALU u_ALU
(
    .clk        (clk),
    .rst        (rst),
    .A          (Reg1),
    .B          (muxOut),
    .ALU_Sel    (ALU_Sel),
    .Zero       (zero),
    .ALU_Result (ALUOut)
);

signExtend u_signExtend
(
    .in    (Immediate),
    .out   (sign)
);

aluSrc_mux u_aluSrc_mux
(
    .ALUSrc    (ALUSrc),
    .Reg2      (Reg2),
    .SignExt   (sign),
    .ValueB    (muxOut)
);


endmodule