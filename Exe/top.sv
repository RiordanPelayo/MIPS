`timescale 1ns/1ps

module top();

localparam WIDTH = 32;

time t = 20;

bit                clk;        //Clock
bit                rst;        //Clock Signal
wire               ALUsrc;     //Bit of Mux Control
wire [3:0]         ALUOp;      //ALU Opcode            
wire [15:0]        Immediate;  //[15:0] of Instruction 
wire [(WIDTH-1):0] Reg1;       //Register 1 Data
wire [(WIDTH-1):0] Reg2;       //Register 2 Data
wire [(WIDTH-1):0] ALUOut;     //Result of ALU
wire               zero;       //Zero Flag Signal

exe u_exe
(
    .clk(clk),     
    .rst(rst),     
    .ALUSrc(ALUSrc),         
    .ALUOp(ALUOp),                 
    .Immediate(Immediate),   
    .Reg1(Reg1),      
    .Reg2(Reg2),       
    .ALUOut(ALUOut),    
    .zero(zero)
);



tb_ctl u_tb_ctl
(
    .clk(clk),     
    .rst(rst), 
    .ALUSrc(ALUSrc),            
    .ALUOp(ALUOp),                 
    .Immediate(Immediate),   
    .Reg1(Reg1),      
    .Reg2(Reg2),       
    .ALUOut(ALUOut),    
    .zero(zero)
);

always #20 clk = !clk;

initial begin
    rst <= 1;
    #20;
    rst <= 0;
   
end

    
endmodule