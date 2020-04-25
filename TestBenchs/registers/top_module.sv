`timescale 1ns/1ps

module top_module();

localparam DEPTH = 5, WIDTH = 32;

bit clk; 
                     
wire RegWrite;                
wire [(DEPTH-1):0] RR1, RR2;  
wire [(DEPTH-1):0] WR;        
wire [(WIDTH-1):0] WD;          
wire [(WIDTH-1):0] RD1, RD2;  

registers #(.WIDTH(WIDTH),.DEPTH(DEPTH)) registers(
    .clk(clk),
    .RegWrite(RegWrite),
    .RR1(RR1),
    .RR2(RR2),
    .RD1(RD1),
    .RD2(RD2),
    .WR(WR),
    .WD(WD) 
);

prog_testbench #(.WIDTH(WIDTH),.DEPTH(DEPTH)) prog_testbench(
    .clk(clk),
    .RegWrite(RegWrite),
    .RR1(RR1),
    .RR2(RR2),
    .RD1(RD1),
    .RD2(RD2),
    .WR(WR),
    .WD(WD) 
);



always
    #20 clk = !clk;

endmodule