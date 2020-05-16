module regDst_mux 
(
    input  reg  [4:0]  Reg2,        //Reg2 Data
    input  reg  [15:0] Inmediate,   //Inmediate Data
    input  reg         RegDst,      //Bit of Control
    output wire [4:0]  WR           //Write Register
);

    assign WR = !RegDst ? Reg2: Inmediate[15:11]; //Multiplexer
      
endmodule

