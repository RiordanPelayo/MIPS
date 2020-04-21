module aluSrcB_mux #(parameter WIDTH =32)
(
    input reg  [(WIDTH-1):0] Reg2,     //read register 2
    input reg  [(WIDTH-1):0] SignExt,  //read Sign extend
    input reg  [(WIDTH-1):0] ShiftL,   //read Shift Left
    input reg  [1:0]         ALUSrcB,  //Bits of control
    output reg [(WIDTH-1):0] ValueB    //B number of ALU opetarion
);

        
   assign ValueB = !ALUSrcB[1] ? (!ALUSrcB[0] ? Reg2 : 'b100) : (!ALUSrcB[0] ? SignExt : ShiftL); //Multiplexer

   //ALUSrcB  ValueB       |---\__
   //  00      Reg2     -->|      |
   //  01     'b100     -->|  MUX |-->
   //  10     SignExt   -->|      |
   //  11     ShiftL    -->|    __|
   //                      |---/
endmodule
