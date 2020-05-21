`timescale 1ns/1ps

program tb_mem #(parameter WIDTH = 32, DEPTH = 16)
(
    input   wire               clk,      //Clock Signal
    input   wire               rst,      //Reset Signal
    output  reg                MemRead,  //Reading Enable
    output  reg                MemWrite, //Writting Enable
    output  reg  [(DEPTH-1):0] Address,  //Directioning Address
    output  reg  [(WIDTH-1):0] WD,       //Write Data
    input   reg  [(WIDTH-1):0] RD        //Read Data
);

integer file;

initial begin

   file = $fopen("output.log","w");
	
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   $fdisplay(file,"Log file begins");
   $fmonitor(file,"Read Data: %h --> %t", RD, $realtime);
  #100;
end

initial begin
    
   MemWrite <= 1;
   MemRead <= 0;
   WD <= 'h1111_ffff; 

   #20;

    for (int i=0; i<DEPTH; i++) begin
        Address <= i; 
        WD <= i;
        @(posedge clk); 
        
    end

    MemWrite <= 0;
    MemRead <= 1;

    for (int i=0; i<DEPTH; i++) begin
        Address <= i;
        @(posedge clk);  
        $display("Add: %h,Read Data: %h",i, RD);
    end
    
    



end

endprogram