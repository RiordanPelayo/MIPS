module top_logic();
    wire [31:0] A,     //32-bit number A (unsigned, input)
                B,     //32-bit number B (unsigned, input)
                C;     //32-bit number C (unsigned, output)
    wire [2:0] log_op; //Control input, to choose which logic operation will be performed
    wire start,        //Start logic operation flag
         finish;       //Finish logic operation flag

    Logic_op logicOP(
        .A(A),
        .B(B),
        .C(C),
        .log_op(log_op),
        .start(start),
        .finish(finish)
    );

    testbench tb(
        .A(A),
        .B(B),
        .C(C),
        .log_op(log_op),
        .start(start),
        .finish(finish)
    );
endmodule