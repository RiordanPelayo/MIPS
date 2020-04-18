module PCSrc_mux #(parameter WIDTH =32)
(
    input reg  [(WIDTH-1):0] AluRes,   //Read ALU Result
    input reg  [(WIDTH-1):0] AluOut,   //Read ALU OUT
    input reg  [(WIDTH-1):0] PCIn,     //Current PC Address
    input reg  [27:0]        Shift,    //Read Shift Left    
    input reg  [1:0]         PCSrc,    //Bits of control
    output reg [(WIDTH-1):0] PCOut     //Next PC Address
);

reg [(WIDTH-1):0] Jump;

   assign Jump[27:0] = Shift;
   assign Jump[31:28] = PCIn[31:28];
        
   assign PCOut = !PCSrc[1] ? (!PCSrc[0] ? AluRes : AluOut) : (!PCSrc[0] ? Jump : 'hffff_ffff); //Multiplexer

   //PCSrc   PCOut        |---\__
   //  00    AluRes    -->|      |
   //  01    AluOut    -->| MUX  |-->
   //  10    Jump      -->|    __|
   //                     |---/
endmodule