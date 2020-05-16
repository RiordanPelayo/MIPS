`timescale 1ns/1ps

program tb_decode #( parameter WIDTH =32, DEPTH=5)
(
    input  wire               clk,       //Clock Signal
    input  wire               rst,       //Reset Signal
    output reg                RegWrite,  //Writting Enable
    output reg                memReg,    //Write Data Mux 
    output reg                RegDst,    //Write Reg Mux
    output reg  [(DEPTH-1):0] Reg1,      //Register Specifications
                              Reg2,
    output reg  [15:0]        Inmediate, //Immediate Constant Value          
    output reg  [(WIDTH-1):0] ALUres,    //ALU Result
                              RData,     //Readed Data  
    input  reg  [(WIDTH-1):0] RD1, RD2   //Read Data 
);

integer file;

initial begin

   file = $fopen("output.log","w");
	
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   $fdisplay(file,"Log file begins");
   $fmonitor(file,"RD1: %h, RD2: %h --> %t", RD1, RD2, $realtime);
  
   #400;
end

initial begin

    Reg1      <= 'h00;
    Reg2      <= 'h01;
    Inmediate <= 'h0000;   //xx_(0/8)x_xx_xx
    RData     <= 'h1111_0000;
    RegWrite  <= 0;
    memReg    <= 0;
    RegDst    <= 0;

    #20;

    @(posedge clk);

    RegWrite  <= 1;
    RegDst    <= 1;

    for (int i=0; i<33; i++) begin
        Inmediate[15:11] <= i;
        ALUres           <= i;
        @(posedge clk);
    end

    for (int i=0; i<32 ; i= i+2) begin
        Reg1 <= i;
        Reg2 <= i+1;
        @(posedge clk);
    end
    
end
    
endprogram