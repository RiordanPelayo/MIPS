program testbench(
    output reg [31:0] A,     //32-bit number A (unsigned, input)
                      B,     //32-bit number B (unsigned, input)
    output reg [2:0] log_op, //Control input, to choose which logic operation will be performed
    output reg start,        //Start logic operation flag
    input wire finish,       //Finish logic operation flag
    input reg [31:0] C       //32-bit number C (unsigned, output)
);

    localparam NOTA = 3'b000, //OPCODE for NOT(A)
               NOTB = 3'b001, //OPCODE for NOT(B)
               AND = 3'b010,  //OPCODE for A AND B
               OR = 3'b011,   //OPCODE for A OR B
               XOR = 3'b100,  //OPCODE for A XOR B
               NAND = 3'b101, //OPCODE for A NAND B
               NOR = 3'b110,  //OPCODE for A NOR B
               XNOR = 3'b111; //OPCODE for A XNOR B

    initial begin
        $display(">>> Starting simulation...");
        $display(">>NOT(A) operation");
        LOGIC_OP('h0123_CDEF, 'h0000_0000, NOTA);
        $display("--------------------------");
        $display(">>NOT(B) operation");
        LOGIC_OP('h0000_0000, 'hFEDC_3210, NOTB);
        $display("--------------------------");
        $display(">>AND operation");
        LOGIC_OP('hAAAA_AAAA, 'hAAAA_AAAA, AND);
        $display("--------------------------");
        $display(">>OR operation");
        LOGIC_OP('h5555_5555, 'hAAAA_AAAA, OR);
        $display("--------------------------");
        $display(">>XOR operation");
        LOGIC_OP('h001F_54C3, 'h09C5_F637, XOR);
        $display("--------------------------");
        $display(">>NAND operation");
        LOGIC_OP('hAAAA_AAAA, 'hAAAA_AAAA, NAND);
        $display("--------------------------");
        $display(">>NOR operation");
        LOGIC_OP('h5555_5555, 'hAAAA_AAAA, NOR);
        $display("--------------------------");
        $display(">>XNOR operation");
        LOGIC_OP('h001F_54C3, 'h09C5_F637, XNOR);
        $display("--------------------------");
        
    end

    task LOGIC_OP(input reg [31:0] a, b, input reg [2:0] opcode);
        A = a;
        B = b;
        log_op = opcode;
        if(opcode == NOTA)
            $display("A value: %h", a);
        else if(opcode == NOTB)
            $display("B value: %h", b);
        else begin
            $display("A value: %h", a);
            $display("B value: %h", b);
        end
        start = 1;
        #100ns;
        start = 0;
        #100ns;
        $display("Result: %h", C);
    endtask
endprogram