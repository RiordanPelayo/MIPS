`timescale 1ns/1ps

module top_module();

localparam WIDTH =32, DEPTHI = 8;
time t = 20;

bit                  clk;       //Clock Signal
bit                  rst;       //Reset Signal
wire                 IorD;      //Control of MUX
wire  [(DEPTHI-1):0] Counter;   //Program Counter Input
wire  [(DEPTHI-1):0] Arslt;     //ALU Result
wire  [5:0]          Opcode;    //Specification of Instruction
wire  [4:0]          Reg1;      //Register Specifications
wire  [4:0]          Reg2;      //Register Specifications    
wire  [15:0]         Inmediate; //Immediate Constant Value
wire  [(DEPTHI-1):0] sumed;

Fetch DUT(
  .clk(clk),    
  .rst(rst),  
  .IorD(IorD),    
  .Arslt(Arslt),
  .Opcode(Opcode),   
  .Reg1(Reg1),     
  .Reg2(Reg2),        
  .Inmediate(Inmediate),
  .sumed(sumed) 
);

tb_fetch testbench(
  .clk(clk),    
  .rst(rst),  
  .IorD(IorD),    
  .Arslt(Arslt),
  .Opcode(Opcode),   
  .Reg1(Reg1),     
  .Reg2(Reg2),        
  .Inmediate(Inmediate), 
  .sumed(sumed)  
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