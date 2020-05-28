module ALUctl (
   input  wire        clk,       //Clock Signal
   input  wire        rst,       //Reset Signal
   input  reg [15:0]  Immediate, //[15:0] of instruction 
   input  reg [3:0]   ALUOp,     //ALU Opcode
   output reg [4:0]   ALU_Sel    //Selection of ALU Operation   
);

reg [5:0] Funct;                 //Second part of opcode

assign Funct = Immediate[5:0];   //Only use the Funct part

/* Params for ALU Selection  */
localparam     shla   = 'h0,   //Shift Left 
               shra   = 'h1,   //Shift Right
               mula   = 'h2,   //Multiply
               mulua  = 'h3,   //Multiply Unsigned
               diva   = 'h4,   //Division
               divua  = 'h5,   //Division Unsigned
               adda   = 'h6,   //Add  
               addua  = 'h7,   //Add Unsigned
               suba   = 'h8,   //Substract
               subua  = 'h9,   //Substract Unsigned
               anda   = 'ha,   //A AND B 
               ora    = 'hb,   //A or  B
               xora   = 'hc,   //A xor B
               nora   = 'hd,   //A nor B
               slta   = 'he,   //Set on Less than
               sltua  = 'hf;   //Set on Less than Unsigned
 
/* Params for Funct inputs */  
localparam     shli  = 'h00,   //Shift Left Immediate
               shri  = 'h02,   //Shift Right Immediate
               shl   = 'h04,   //Shift Left
               shr   = 'h06,   //Shift Right
               mul   = 'h18,   //Multiply
               mulu  = 'h19,   //Multiply Unsigned
               div   = 'h1a,   //Division
               divu  = 'h1b,   //Division Unsigned
               add   = 'h20,   //Add  
               addu  = 'h21,   //Add Unsigned
               sub   = 'h22,   //Substract
               subu  = 'h23,   //Substract Unsigned
               andf  = 'h24,   //A AND B 
               orf   = 'h25,   //A or  B
               xorf  = 'h26,   //A xor B
               norf  = 'h27,   //A nor B
               slt   = 'h2a,   //Set on Less than
               sltu  = 'h2a;   //Set on Less than Unsigned

/* Paramas for Opcode inputs  */ 
localparam    rtyp  = 'h0,    //R-type instructions
              addi  = 'h8,    //Add
              addiu = 'h9,    //Add Immediate
              slti  = 'ha,    //Set on less than Immediate
              stliu = 'hb,    //Set on less than Immediate Unsigned         
              andi  = 'hc,    //AND with Immediate
              ori   = 'hd,    //OR with Immediate
              xori  = 'he,    //XOR with Immediate
              yesB  = 'hf;    //B yes

always_ff @(posedge clk) begin

   if (rst) 
      ALU_Sel <= 'h0;
   
   else begin

   case(ALUOp)

   rtyp: begin
        
        case(Funct)

         shli:
            ALU_Sel <= shla;
        
         shri:
            ALU_Sel <= shra;

         shl:
            ALU_Sel <= shla;

         shr:
            ALU_Sel <= shra;

         mul:
            ALU_Sel <= mula;

         mulu:   
            ALU_Sel <= mulua;

         div: 
            ALU_Sel <= diva;

         divu:
            ALU_Sel <= diva;

         add:
            ALU_Sel <= adda; 

         addu:
            ALU_Sel <= addua;

         sub:
            ALU_Sel <= suba;

         subu:
            ALU_Sel <= subua;

         andf:
            ALU_Sel <= anda;

         orf:
            ALU_Sel <= ora;

         xorf:
            ALU_Sel <= xora;

         norf:
            ALU_Sel <= nora;
         
         slt:
            ALU_Sel <= slta;

         sltu:
            ALU_Sel <= sltua; 
    
         endcase
   end   
   
   addi:
      ALU_Sel <= adda;

   addiu:
      ALU_Sel <= addua;
   
   slti:
      ALU_Sel <= slta;

   stliu:
      ALU_Sel <= sltua;
   
   andi:
      ALU_Sel <= anda;

   ori:
      ALU_Sel <= ora;

   xori:
      ALU_Sel <= xora; 

   yesB:
      ALU_Sel <= 'h10;  
    

   endcase        
   end   
end
endmodule