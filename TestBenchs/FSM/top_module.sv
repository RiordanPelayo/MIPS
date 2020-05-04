`timescale 1ns/1ps

module top_module ();
    
    time t = 20;
    bit clk;
    bit rst;

    fsm_if fsm_if_obj ( clk, rst);

    always  #t clk = !clk;

    fsm dut(

        .clk(fsm_if_obj.clk),
        .rst(fsm_if_obj.rst),
        .OpCode(fsm_if_obj.OpCode),
        .ALUOp(fsm_if_obj.ALUOp),
        .ALUSrcB(fsm_if_obj.ALUSrcB),
        .ALUSrcA(fsm_if_obj.ALUSrcA),
        .PCSrc(fsm_if_obj.PCSrc),
        .RegWrite(fsm_if_obj.RegWrite),
        .MemtoReg(fsm_if_obj.MemtoReg),
        .RegDst(fsm_if_obj.RegDst),
        .PCWrite(fsm_if_obj.PCWrite),
        .IorD(fsm_if_obj.IorD),
        .MemRead(fsm_if_obj.MemRead),
        .MemWrite(fsm_if_obj.MemWrite),
        .IRWrite(fsm_if_obj.IRWrite)

    );

    fsm_tb tb ( fsm_if_obj );

    initial begin
        #t;
        rst = 1;
        #t;
        rst = 0;
        #(20*t);
    end

endmodule : top_module
