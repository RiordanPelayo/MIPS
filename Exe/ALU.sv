module ALU #(parameter WIDTH = 32)
(
    input  wire               clk,       //Clock Signal
    input  wire               rst,       //Reset Signal
    input  reg  [(WIDTH-1):0] A,B,       //ALU 32-bit Inputs                 
    input  reg  [3:0]         ALU_Sel,   //ALU Selection
    output reg                Zero,      //Zero Flag
    output reg  [(WIDTH-1):0] ALU_Result //ALU 32-bit Output
);

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

always_ff @(posedge clk) begin
        if(rst)begin
            ALU_Result <= 'h0;
            Zero       <=  0;
        end
        else begin
           case(ALU_Sel)

         shla: // Shift Left Immediate
           ALU_Result <= A << B ; 

         shra: // Shift Right Immediate
           ALU_Result <= B >> A ;
           
         mula:  // Multiply
           ALU_Result <= signed'(A) * signed'(B);

         mulua: // Multiply Unsigned
           ALU_Result <= A * B;

         diva:  // Division
           ALU_Result <= signed'(A) / signed'(B);

         divua: //Division Unsigned
           ALU_Result <= A / B;
         
         adda:  // Add
           ALU_Result <= signed'(A) + signed'(B);
         
         addua: // Add Unsigned
           ALU_Result <= unsigned'(A) + unsigned'(B);

         suba:  // Substract  
           ALU_Result <= signed'(A) - signed'(B); 

         subua: // Substract Unsigned
           ALU_Result <= unsigned'(A) - unsigned'(B); 

         anda:  // A AND B
           ALU_Result <= A & B; 

         ora:   // A OR B
            ALU_Result <= A | B;

         xora: // A XOR B
            ALU_Result <= A ^ B;   

         nora: // A nor B      
            ALU_Result <= ~(A | B);

         slta: // Set on Less than
            ALU_Result <= (signed'(A) < signed'(B)) ? 1:0;

         sltua: // Set on Less than Unsigned
            ALU_Result <= (A < B) ? 1:0;   
             
        endcase
            
        Zero = (ALU_Result=='h0)?'h1:'h0;

        end 
    end
endmodule


