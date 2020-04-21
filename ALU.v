module ALU(
    input reg [31:0] A,       //32-bit number A (unsigned, input)
                     B,       //32-bit number B (unsigned, input)
    input reg [3:0] control,  //Control input, to choose which logic operation will be performed
    input wire clock,         //Clock signal
               reset,         //Reset signal
               start,         //Start signal
    output reg finish,        //Finish signal
               sign,          //Sign flag (0 = positive, 1 = negative)
    output reg [31:0] C       //32-bit number C (unsigned, output)
);
    reg [31:0] A_arithmetic,  //32-bit number A for arithmetic purposes (unsigned)
               B_arithmetic,  //32-bit number B for arithmetic purposes (unsigned)
               A_logic,       //32-bit number A for logic purposes (unsigned, wire)
               B_logic;       //32-bit number B for logic purposes (unsigned, wire)
    reg start_arithmetic,     //Start flag for arithmetic purposes
        start_logic;          //Start flag for logic purposes
    wire finish_arithmetic,   //Finish flag for arithmetic purposes
         finish_logic,        //Finish flag for logic purposes
         sign_flag;           //Sign flag for arithmetic purposes
    wire [31:0] C_arithmetic, //32-bit number C for arithmetic purposes 
                C_logic;      //32-bit number C for logic purposes 

    localparam NOTA = 4'b0000,  //OPCODE for NOT(A)
               NOTB = 4'b0001,  //OPCODE for NOT(B)
               AND = 4'b0010,   //OPCODE for A AND B
               OR = 4'b0011,    //OPCODE for A OR B
               XOR = 4'b0100,   //OPCODE for A XOR B
               NAND = 4'b0101,  //OPCODE for A NAND B
               NOR = 4'b0110,   //OPCODE for A NOR B
               XNOR = 4'b0111,  //OPCODE for A XNOR B
               ADDPP = 4'b1000, //Both numbers are positive (A+B)
               ADDPN = 4'b1001, //Number A is positive and number B is negative (A-B)
               ADDNP = 4'b1010, //Number A is negative and number B is positive (-A+B)
               ADDNN = 4'b1011; //Both numbers are negative (A-B)

    AddSub arithmetic_op(            //Addition/Substraction (arithmetic operations) submodule
        .A(A_arithmetic),
        .B(B_arithmetic),
        .control(control),
        .clock(clock),
        .reset(reset),
        .start(start_arithmetic),
        .finish(finish_arithmetic),
        .sign(sign_flag),
        .C(C_arithmetic)
    );

    Logic_op  logic_op(              //Logic operations submodule 
        .A(A_logic),
        .B(B_logic),
        .log_op(control),
        .clock(clock),
        .reset(reset),
        .start(start_logic),
        .finish(finish_logic),
        .C(C_logic)
    );

    always@(posedge clock or posedge reset) begin
        if(reset) begin             //If a reset occurs...
            sign <= 1'b0;           //Sign flag is zero (positive by default)
            C <= 32'b0;             //Output C is zero
            finish <= 1'b0;         //Finish flag (general) is zero
            A_arithmetic <= 32'bz;  //All the inner regs are putted in high impedance state
            B_arithmetic <= 32'bz;  
            A_logic <= 32'bz;
            B_logic <= 32'bz; 
        end
        else begin
            if(control <= XNOR) begin                        //If the opcode is between 0 (NOTA) and 7 (XNOR), a logic operation will be performed
                $display("LOGIC OP (1)");                    //Debug message
                if(start & ~finish_logic) begin              //If a start flag is set and the finish_logic flag is zero, then...
                    $display("LOADING LOGIC DATA (2)");      //Debug message
                    A_logic <= A;                            //Loading input A data to A_logic 
                    B_logic <= B;                            //Loading input B data to B_logic 
                    start_logic <= 1'b1;                     //The start_logic flag is set, to start the logic operation
                end
                else if(finish_logic) begin                  //If the operation has finished, then...
                    $display("DISPLAYING LOGIC RESULT (4)"); //Debug message
                    finish <= finish_logic;                  //Loading finish_logic data to finish flag
                    sign <= 1'b0;                            //Due to be a logic operation, a sign flag is not necessary, so it is zero (positive)
                    C <= C_logic;                            //Loading C_logic to output C
                end
                else begin                                   //If an operation has not started nor finished, then...
                    finish <= finish_logic;                  //Loading finish_logic data to finish flag
                    start_logic <= 1'b0;                     //The start_logic flag is zero
                end
            end
            else begin                                       //If the opcode is equal or greater than 8 (ADDPP), an arithmetic operation will be performed
                $display("ARITHMETIC OP (1)");               //Debug message
                if(start & ~finish_arithmetic) begin         //If a start flag is set and the finish_arithmetic flag is zero, then...
                   $display("LOADING LOGIC DATA (2)");       //Debug message
                   A_arithmetic <= A;                        //Loading input A data to A_arithmetic 
                   B_arithmetic <= B;                        //Loading input A data to B_arithmetic
                   start_arithmetic <= 1'b1;                 //The start_arithmetic flag is set, to start the logic operation
                end
                else if(finish_arithmetic) begin             //If the operation has finished, then...
                    $display("DISPLAYING LOGIC RESULT (4)"); //Debug message
                    finish <= finish_arithmetic;             //Loading finish_arithmetic data to finish flag
                    C <= C_arithmetic;                       //Loading C_logic to output C
                    sign <= sign_flag;                       //Loading sign_flag data to sign (remember 0 = positive and 1 = negative)
                end
                else begin
                    finish <= finish_arithmetic;             //Loading finish_arithmetic data to finish flag
                    start_arithmetic <= 1'b0;                //The start_logic flag is zero
                end
            end
        end
    end
endmodule