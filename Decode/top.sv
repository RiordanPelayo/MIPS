`timescale 1ns/1ps

module top ();

localparam WIDTH =32, DEPTH=5; 
time t = 20;

bit                clk;       //Clock Signal
bit                rst;       //Reset Signal
wire               RegWrite;  //Writting Enable
wire               memReg;    //Write Data Mux 
wire               RegDst;    //Write Reg Mux
wire [(DEPTH-1):0] Reg1;      //Register Specifications
wire [(DEPTH-1):0] Reg2; 
wire [15:0]        Inmediate; //Immediate Constant Value          
wire [(WIDTH-1):0] ALUres;    //ALU Result
wire [(WIDTH-1):0] RData;     //Readed Data  
wire [(WIDTH-1):0] RD1, RD2;  //Read Data 

Decode u_Decode (

    .clk(clk),
    .rst(rst),
    .RegWrite(RegWrite), 
    .memReg(memReg),
    .RegDst(RegDst),
    .Reg1(Reg1),
    .Reg2(Reg2),
    .Inmediate(Inmediate),
    .ALUres(ALUres),
    .RData(RData),
    .RD1(RD1),
    .RD2(RD2) 
);

tb_decode u_tb_decode(

    .clk(clk),
    .rst(rst),
    .RegWrite(RegWrite), 
    .memReg(memReg),
    .RegDst(RegDst),
    .Reg1(Reg1),
    .Reg2(Reg2),
    .Inmediate(Inmediate),
    .ALUres(ALUres),
    .RData(RData),
    .RD1(RD1),
    .RD2(RD2)   
);

always #t clk = !clk;

initial begin
    #(t*2);
    rst = 1;
    #(t*2);
    rst = 0;
    #(t*60);

end

endmodule