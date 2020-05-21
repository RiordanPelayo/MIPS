`timescale 1ns/1ps

module top_module();

localparam  WIDTH = 32;

bit clk;
bit rst; 
                     
wire MemRead;  
wire MemWrite;              
wire [(WIDTH-1):0] Address;          
wire [(WIDTH-1):0] WD;          
wire [(WIDTH-1):0] RD;  

memory #(.WIDTH(WIDTH)) DUT(
    .clk(clk),
    .rst(rst),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(Address),
    .WD(WD),
    .RD(RD)
);

prog_testbench #(.WIDTH(WIDTH)) prog_testbench(
    .clk(clk),
    .rst(rst),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(Address),
    .WD(WD),
    .RD(RD)
);



always #20 clk = !clk;


initial begin
    rst = 1;
    #20;
    rst = 0;


end

endmodule