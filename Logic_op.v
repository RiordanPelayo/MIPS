module Logic_op(
    input reg [31:0] A,     //32-bit number A (unsigned, input)
                     B,     //32-bit number B (unsigned, input)
    input reg [3:0] log_op, //Control input, to choose which logic operation will be performed
    input wire clock,       //Clock signal
               reset,       //Reset signal 
               start,       //Start signal 
    output reg finish,      //Finish a logic operation flag 
    output reg [31:0] C     //32-bit number C (unsigned, output)
);

    wire [31:0] Z_nota, //Wire that will have the NOT(A) result
                Z_notb, //Wire that will have the NOT(B) result
                Z_and,  //Wire that will have the AND result
                Z_or,   //Wire that will have the OR result
                Z_xor,  //Wire that will have the XOR result
                Z_nand, //Wire that will have the NAND result
                Z_nor,  //Wire that will have the NOR result
                Z_xnor; //Wire that will have the XNOR result

    localparam NOTA = 4'b0000, //OPCODE for NOT(A)
               NOTB = 4'b0001, //OPCODE for NOT(B)
               AND = 4'b0010,  //OPCODE for A AND B
               OR = 4'b0011,   //OPCODE for A OR B
               XOR = 4'b0100,  //OPCODE for A XOR B
               NAND = 4'b0101, //OPCODE for A NAND B
               NOR = 4'b0110,  //OPCODE for A NOR B
               XNOR = 4'b0111; //OPCODE for A XNOR B

    assign Z_nota = ~A;       //NOT(A) operation
    assign Z_notb = ~B;       //NOT(B) operation
    assign Z_and = A & B;     //AND operation
    assign Z_or = A | B;      //OR operation
    assign Z_xor = A ^ B;     //XOR operation
    assign Z_nand = ~(A & B); //NAND operation
    assign Z_nor = ~(A | B);  //NOR operation
    assign Z_xnor = ~(A ^ B); //XNOR operation
    
    always@(posedge clock or posedge reset) begin
        if(reset) begin     //If reset signal is set (1), then...
            C <= 32'b0;     //C is zero
            finish <= 1'b0; //Finish flag is reset
        end                   
        else begin                       //If reset signal is reset (0), and then...
            if(start & ~finish) begin    //If a start is set and the finish flag is zero, then...
                $display("PERFORMING (3)"); //Debug message
                case(log_op)            //The log_op opcode is evaluated, and then...
                    NOTA: begin         
                        C <= Z_nota;     //C is assigned with a wire value, depending on the lop_op value
                        finish <= 1'b1;  //Finish flag is set, in order to indicate the end of an operation 
                    end
                    NOTB: begin
                        C <= Z_notb; 
                        finish <= 1'b1;
                    end
                    AND: begin   
                        C <= Z_and;  
                        finish <= 1'b1;
                    end
                    OR: begin    
                        C <= Z_or;   
                        finish <= 1'b1;
                    end
                    XOR: begin  
                        C <= Z_xor;  
                        finish <= 1'b1;
                    end
                    NAND: begin  
                        C <= Z_nand; 
                        finish <= 1'b1;
                    end
                    NOR: begin   
                        C <= Z_nor;  
                        finish <= 1'b1;
                    end
                    XNOR: begin
                        C <= Z_xnor;
                        finish <= 1'b1;
                    end 
                endcase
            end
            else if(start & finish) //If start is set when finish is set, then....
                finish <= 1'b0;     //Finish flag is zero, because another start flag is present, meaning the start of a new operation
        end 
    end
endmodule