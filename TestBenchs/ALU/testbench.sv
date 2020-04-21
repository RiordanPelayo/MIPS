`timescale 1ns/1ps
program testbench(
    output bit [31:0] A,    //32-bit number A (unsigned, ALU input)
                      B,    //32-bit number B (unsigned, ALU input)
    input bit [31:0] C,     //32-bit number C (unsigned, ALU output)
    input bit sign,         //Sign flag (0 = positive, 1 = negative)
              clock,        //Clock signal
    output bit reset,       //Reset signal 
               start,       //Start signal 
    output bit [3:0] opcode //Control input, to choose which logic operation will be performed
);

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

    initial begin
        RESET();     //Reset task
        ARITH_OP();  //Arithmetic operations task
        LOGIC_OP();  //Logic operations task
    end

    task RESET();
        reset = 1'b1;     //A reset is set
        $display(">>Beginning reset...");
        @(posedge clock); //A clock cycle after...
        reset = 1'b0;     //The reset signal is reset
        $display(">>Ending reset...");
    endtask

    task ARITH_OP();
        $display(">>Starting simulation...");
        $display(">>Starting arithmetic operations...");
        $display("-----ADD POSITIVE-POSITIVE----");
        A = 'h218B643E;        //Loading a value into number A (unsigned)
        $display("A = %h", A); //Printing the value loading previously
        B = 'h021C7B4D;        //Loading a value into number A (unsigned)
        $display("B = %h", B); //Printing the value loading previously
        opcode = ADDPP;        //Control signal is equal to add positive with positive
        start = 1'b1;          //Start flag is set, which means the operation will start
        @(posedge clock)       
        @(posedge clock)             //Two clock cycles after...
        start = 1'b0;                //Start flag is reset
        #70;                         //70 nanoseconds after...
        $display("Sign = %h", sign); //Printing the value of the sign
        $display("Result = %h", C);  //Printing the value of the result
        /* ---------------------------------- */
        $display("-----ADD POSITIVE-NEGATIVE----");
        A = 'h0B09F;           //Loading a value into number A (unsigned)
        $display("A = %h", A); //Printing the value loading previously
        B = 'h5E09E;           //Loading a value into number A (unsigned)
        $display("B = %h", B); //Printing the value loading previously
        opcode = ADDPN;        //Control signal is equal to add positive with negative
        start = 1'b1;          //Start flag is set, which means the operation will start
        @(posedge clock)       
        @(posedge clock)             //Two clock cycles after...
        start = 1'b0;                //Start flag is reset
        #70;                         //70 nanoseconds after...
        $display("Sign = %h", sign); //Printing the value of the sign
        $display("Result = %h", C);  //Printing the value of the result
        /* ---------------------------------- */
        $display("-----ADD NEGATIVE-POSITIVE----");
        A = 'hA;
        $display("A = %h", A);
        B = 'hF;
        $display("B = %h", B);
        opcode = ADDNP;         //Control signal is equal to add negative with positive
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        #70;
        $display("Sign = %h", sign);
        $display("Result = %h", C);
        /* ---------------------------------- */
        $display("-----ADD NEGATIVE-NEGATIVE----");
        A = 'h10000;
        $display("A = %h", A);
        B = 'h5;
        $display("B = %h", B);
        opcode = ADDNN;        //Control signal is equal to add negative with negative
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        #70;
        $display("Sign = %h", sign);
        $display("Result = %h", C);
        $display("-------------------------------");
        $display(">>Ending arithmetic operations...");
    endtask
  
    task LOGIC_OP();
        $display(">>Starting logic operations...");
        /* ********************************** */
        $display("-------NOT(A) operation-------");
        opcode = NOTA;
        A = 'hFEDC3210;
        $display("A: %h", A);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("-------NOT(B) operation-------");
        opcode = NOTB;
        B = 'h0123CDEF;
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("---------AND operation---------");
        opcode = AND;
        A = 'hAAAACCCC;
        B = 'hFFFF1248;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);  
        /* ********************************** */
        $display("----------OR operation---------");
        opcode = OR;
        A = 'h55555555;
        B = 'hAAAAAAAA;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("---------XOR operation---------");
        opcode = XOR;
        A = 'h548FC690;
        B = 'hABE50123;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("---------NAND operation--------");
        opcode = NAND;
        A = 'hAAAACCCC;
        B = 'hFFFF1248;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("---------NOR operation---------");
        opcode = NOR;
        A = 'h55555555;
        B = 'hAAAAAAAA;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("---------XNOR operation--------");
        opcode = XNOR;
        A = 'h548FC690;
        B = 'hABE50123;
        $display("A: %h", A);
        $display("B: %h", B);
        start = 1'b1;
        @(posedge clock)
        @(posedge clock)
        start = 1'b0;
        $display("Result: %h", C);
        /* ********************************** */
        $display("-------------------------------");
        $display(">>Ending logic operations...");
        $display(">>Ending simulation...");
    endtask
endprogram
