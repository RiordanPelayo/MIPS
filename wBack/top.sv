`timescale 1ns/1ps

module top();

localparam WIDTH = 32, DEPTH = 16;
time t = 20;

bit                 clk;      //Clock Signal
bit                 rst;      //Reset Signal
wire                MemRead;  //Reading Enable
wire                MemWrite; //Writting Enable
wire  [(DEPTH-1):0] Address;  //Directioning Address
wire  [(WIDTH-1):0] WD;       //Write Data
wire  [(WIDTH-1):0] RD;        //Read Data


memory DUT 
(
    .clk(clk),
    .rst(rst), 
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(Address), 
    .WD(WD),       
    .RD(RD)        
);

tb_mem testbench 
(
    .clk(clk),
    .rst(rst), 
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(Address), 
    .WD(WD),       
    .RD(RD)        
);

always #t clk = !clk;

initial begin
    #t;
    rst = 1;
    #t;
    rst = 0;

end
endmodule