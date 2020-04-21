`timescale 1ns/1ps
module top_module();

    reg clock;
    wire reset,
         start,
         finish,
         sign;
    reg [31:0] A,
               B,
               C;
    reg [3:0] opcode;

    initial begin
        clock = 'b0;
        forever #0.5 clock = ~clock;        
    end

    ALU alu_dut(
        .A(A), 
        .B(A),
        .control(opcode),
        .clock(clock),
        .reset(reset),
        .start(start),
        .finish(finish),
        .sign(sign),
        .C(C)
    );

    testbench tb(
        .A(A),
        .B(B),
        .C(C),
        .sign(sign),
        .clock(clock),
        .reset(reset),
        .start(start),
        .opcode(opcode)
    );
endmodule