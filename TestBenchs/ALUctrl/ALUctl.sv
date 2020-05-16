module ALUctl (
   input  wire        clk,       //Clock
   input  reg [15:0]  Inmediate, //[15:0] of instruction 
   input  reg [4:0]   Itp,       //I-Type instruction
   output reg [3:0]   Operation  //Operation for ALU      
);

reg [5:0] Funct;                 //Second part of opcode

assign Funct = Inmediate[5:0];   //Only use the Funct part

/* Params for ALU operations */
 localparam    NOTA  = 'b0000,   //OPCODE for NOT(A)
               NOTB  = 'b0001,   //OPCODE for NOT(B)
               AND   = 'b0010,   //OPCODE for A AND B
               OR    = 'b0011,   //OPCODE for A OR B
               XOR   = 'b0100,   //OPCODE for A XOR B
               NAND  = 'b0101,   //OPCODE for A NAND B
               NOR   = 'b0110,   //OPCODE for A NOR B
               XNOR  = 'b0111,   //OPCODE for A XNOR B
               ADDPP = 'b1000,   //Both numbers are positive (A+B)
               ADDPN = 'b1001,   //Number A is positive and number B is negative (A-B)
               ADDNP = 'b1010,   //Number A is negative and number B is positive (-A+B)
               ADDNN = 'b1011;   //Both numbers are negative (A-B)

/* Params for Func inputs */
 localparam    add   = 'h20,     //Funct for Add  
               addU  = 'h21,     //Funct for Add Unsigned
               sub   = 'h22,     //Funct for Substract
               subU  = 'h23,     //Funct for Substract Unsigned
               andf  = 'h24,     //Funct for A AND B 
               orf   = 'h25,     //Funct for A or B
               xorf  = 'h26,     //Funct for A xor B
               norf  = 'h27;     //Funct for A nor B

/* Paramas for I-Types inputs*/               
   
endmodule