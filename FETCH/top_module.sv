`timescale 1ns/1ps

module top_module();

localparam WIDTH =32, DEPTHI = 16;
time t = 20;

bit                  clk;       //Clock Signal
bit                  rst;       //Reset Signal
wire                 Jump;      //Control of Jump MUX
wire                 Branch;    //Control of Branch MUX
wire                 Zero;      //ALU Zero Signal
wire                 stop;      //Signal to Stop Adder
wire  [(WIDTH-1):0]  signext;   //Sign Extend Value
wire  [5:0]          Opcode;    //Specification of Instruction
wire  [4:0]          Reg1;      //Register Specifications
wire  [4:0]          Reg2;      //Register Specifications    
wire  [15:0]         Immediate; //Immediate Constant Value
wire  [27:0]         jumped;



Fetch u_Fetch (
    .clk(clk),
    .rst(rst),
    .Jump(Jump),
    .Branch(Branch),
    .Zero(Zero),
    .stop(stop),
    .signext(signext),   
    .Opcode(Opcode),
    .Reg1(Reg1),
    .Reg2(Reg2),
    .Immediate(Immediate),
    .jumped(jumped)
);



tb_fetch testbench(
    .clk(clk),
    .rst(rst),
    .Jump(Jump),
    .Branch(Branch),
    .Zero(Zero),
    .stop(stop),
    .signext(signext),   
    .Opcode(Opcode),
    .Reg1(Reg1),
    .Reg2(Reg2),
    .Immediate(Immediate),
    .jumped(jumped)
);



always #t clk = !clk;

initial begin
    #(t);
    rst = 1;
    #(t);
    rst = 0;

end

endmodule