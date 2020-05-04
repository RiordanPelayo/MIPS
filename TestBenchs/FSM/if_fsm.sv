interface fsm_if ( input bit clk, input bit rst );

  logic [5:0] OpCode;     //Operations
  logic [3:0] ALUOp;      //ALU Operation 
  logic [1:0] ALUSrcB;    //ALU Source for B
  logic [1:0] PCSrc;      //Source for PC mux
  logic ALUSrcA;          //ALU Source for A
  logic RegWrite;         //Register Write Enable
  logic MemtoReg;         //Write Data mux
  logic RegDst;           //Register Destination Enable
  logic PCWrite;          //PC Write Enable
  logic IorD;             //Instruction or Direction mux
  logic MemRead;          //Read Memory
  logic MemWrite;         //Write on Memory
  logic IRWrite;          //Instruction Write 

endinterface //FSM_IF