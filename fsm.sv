module fms 
(
  input wire clk,                  //Clock
  input reg [5:0] upcode, func,    //Operations
  input reg [4:0] shamt,           //Constant Value 
  output reg RegDst,               //Register Destination
  output reg ALUsrc,               //Surce of Data to ALU
  output reg RWE,                  //Register Write Enable
  output reg [2:0] AluOP  //ALU Operation
);

//******************** STATES ****************************************
localparam [2:0] fetch  = 'b000, //Instruction Fetch
                 decode = 'b001, //Instruction Decode
                 exe    = 'b010, //Execute Instruction
                 mem    = 'b011; //Memory Storage
//********************************************************************                 

//******************** UPCODE ****************************************
localparam [5:0] R    = 'b00_0000, //Register Operations
                 RI   = 'b00_0001, //Branches
                 addi = 'b00_1000; //Add Immediate
//******************************************************************** 

//******************** UPCODE ****************************************
localparam [5:0] Add = 'b10_0000,
                 Sub = 'b10_0010;
//******************************************************************** 


reg [2:0] state;



endmodule