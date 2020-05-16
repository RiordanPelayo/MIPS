module Logic_op(
    input reg [31:0] A,     //32-bit number A (unsigned, input)
                     B,     //32-bit number B (unsigned, input)
    input reg [2:0] log_op, //Control input, to choose which logic operation will be performed
    input wire start,       //Start logic operation flag
    output reg finish,      //Finish logic operation flag
    output reg [31:0] C     //32-bit number C (unsigned, output)
);

    reg finish_logic = 1'b0;   //Finish logic operation flag wire
    reg [31:0] Z_logic;        //Variable that will store the logic result

    localparam NOTA = 4'b0000, //OPCODE for NOT(A)
               NOTB = 4'b0001, //OPCODE for NOT(B)
               AND = 4'b0010,  //OPCODE for A AND B
               OR = 4'b0011,   //OPCODE for A OR B
               XOR = 4'b0100,  //OPCODE for A XOR B
               NAND = 4'b0101, //OPCODE for A NAND B
               NOR = 4'b0110,  //OPCODE for A NOR B
               XNOR = 4'b0111; //OPCODE for A XNOR B

    always @(*) begin
        if(start & ~finish_logic) begin
	        finish = 1'b0;
	        C = 32'b0;
            case(log_op)                  //The log_op is evaluated to choose a operation...
                NOTA: Z_logic = ~A;       //NOT(A) operation
                NOTB: Z_logic = ~B;       //NOT(B) operation
                AND:  Z_logic = A & B;    //AND operation
                OR:   Z_logic = A | B;    //OR operation
                XOR:  Z_logic = A ^ B;    //XOR operation
                NAND: Z_logic = ~(A & B); //NAND operation
                NOR:  Z_logic = ~(A | B); //NOR operation
                XNOR: Z_logic = ~(A ^ B); //XNOR operation
            endcase
	        finish_logic = 1'b1;          //Any logic operation has been completed
        end 
        else if(~start & finish_logic) begin //If any logic operation has finished, then...
	        finish_logic = 1'b0;             //The previous result now will be stored until a new operation process starts
            finish = 1'b1;                   //The finish flag is set
            C = Z_logic;                     //The result Z_logic is displayed on the C output
        end
        else begin                           //If there is an error on the finish, start and/or finish_logic, it is secured that the variables
            finish_logic = 1'b0;             //are zero
            finish = 1'b0;
        end
    end
endmodule