interface fsm_if ( input bit clk, input bit rst );

logic [5:0] OpCode;   //Operations
logic       stop;     //Signal to Stop Adder
logic       RegDst;   //Register Destination Enable
logic       Jump;     //Control of Jump MUX
logic       Branch;   //Control of Branch MUX
logic       MemRead;  //Read Memory
logic       MemtoReg; //Write Data mux
logic       ALUSrc;   //ALU Source mux
logic       RegWrite; //Register Write Enable
logic       MemWrite; //Write on Memory
logic [3:0] ALUOp;    //ALU Operation 

endinterface //FSM_IF