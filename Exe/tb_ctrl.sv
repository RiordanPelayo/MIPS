`timescale 1ns/1ps

program tb_ctl #(parameter WIDTH =32)
(
    input   wire              clk,        //Clock Signal
    input   wire              rst,        //Clock Signal
    output  reg               ALUSrc,     //Mux Control   
    output  reg [3:0]         ALUOp,      //ALU Opcode            
    output  reg [15:0]        Immediate,  //[15:0] of Instruction 
    output  reg [(WIDTH-1):0] Reg1,       //Register 1 Data
    output  reg [(WIDTH-1):0] Reg2,       //Register 2 Data
    input   reg [(WIDTH-1):0] ALUOut,     //Result of ALU
    input   reg               zero        //Zero Flag Signal
);


integer file;

initial begin

   file  = $fopen("output.log","w");
   
   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");

   $fdisplay(file,"Log file begins");
    
end

initial begin

    #20;

    Reg1      <= 'h0000_0003;
    Reg2      <= 'hffff_fffe;
    Immediate <= 'h0020;
    ALUOp     <= 'hf;
    ALUSrc    <=  1;

    for (int i=20; i<'h2b; i++) begin
        Immediate <= i;
        @(posedge clk);
        $fdisplay(file,"Result: %h, Zero: %b", ALUOut, zero);
    end

    ALUSrc    <=  0;

    for (int i=20; i<'h2b; i++) begin
        Immediate <= i;
        @(posedge clk);
        $fdisplay(file,"Result: %h, Zero: %b", ALUOut, zero);
    end

end

endprogram