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
        .stop(fsm_if_obj.stop),
        .RegDst(fsm_if_obj.RegDst),
        .Jump(fsm_if_obj.Jump),
        .Branch(fsm_if_obj.Branch),
        .MemRead(fsm_if_obj.MemRead),
        .MemtoReg(fsm_if_obj.MemtoReg),
        .ALUOp(fsm_if_obj.ALUOp),
        .ALUSrc(fsm_if_obj.ALUSrc),
        .RegWrite(fsm_if_obj.RegWrite),
        .MemWrite(fsm_if_obj.MemWrite)

    );

    fsm_tb tb ( fsm_if_obj );

    initial begin
        #t;
        rst = 1;
        #t;
        rst = 0;
        
    end

endmodule : top_module
