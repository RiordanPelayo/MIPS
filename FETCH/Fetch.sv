module Fetch #(parameter WIDTH =32, DEPTHI = 16)
(
    input  wire                 clk,       //Clock Signal
                                rst,       //Reset Signal
    input  wire                 IorD,      //Control of MUX
    input  reg   [(WIDTH-1):0]  Arslt,     //ALU Result
    output reg   [5:0]          Opcode,    //Specification of Instruction
    output reg   [4:0]          Reg1,      //Register Specifications
                                Reg2,          
    output reg   [15:0]         Immediate, //Immediate Constant Value
    output reg   [(DEPTHI-1):0] sumed
);

wire [(DEPTHI-1):0] pc_out, 
                    mux_pc,
                    add_mux;

instructionReg u_instructionReg (
    .clk              (clk),
    .rst              (rst),
    .Counter          (pc_out),
    .Opcode           (Opcode),
    .Reg1             (Reg1),
    .Reg2             (Reg2),
    .Immediate        (Immediate)
);

PC u_PC (
    .clk         (clk),
    .rst         (rst),
    .Next        (mux_pc),
    .Actual      (pc_out)
);

IorD_mux u_IorD (
    .PC      (add_mux),
    .ALU     (Arslt),
    .IorD    (IorD), 
    .Address (mux_pc)
);

ADD4 u_ADD4(
    .clk   (clk),
    .rst   (rst),
    .PCin  (mux_pc),
    .Added (add_mux)
);

assign sumed = add_mux;

endmodule