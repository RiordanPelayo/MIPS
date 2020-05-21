module aluSrc_mux #(parameter WIDTH =32)
(
    input reg                ALUSrc,   //Bit of Control
    input reg  [(WIDTH-1):0] Reg2,     //Read register 2
    input reg  [(WIDTH-1):0] SignExt,  //Read Sign extend
    output reg [(WIDTH-1):0] ValueB    //B number of ALU opetarion
);
   
   assign ValueB = !ALUSrc ? Reg2:SignExt;

endmodule
