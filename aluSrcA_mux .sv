module aluSrcA_mux #(parameter WIDTH =32)
(
    input reg  [(WIDTH-1):0] PC,       //read PC Address
    input reg  [(WIDTH-1):0] Reg1,     //read register 1
    input reg                ALUSrcA,  //Bit of control
    output reg [(WIDTH-1):0] ValueA    //A number of ALU opetarion
);
      
    assign ValueA  = !ALUSrcA ? PC:Reg1;    //Multiplexer

endmodule
