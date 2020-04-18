module regDst_mux #(parameter INST = 5)
(
    input  reg  [(INST-1):0] Reg2,        //Reg2 Data
    input  reg  [(INST-1):0] Inmediate,   //Inmediate Data
    input  reg  RegDst,                   //Bit of Control
    output wire [(INST-1):0] WR           //Write Register
);

    assign WR = !RegDst ? Reg2:Inmediate; //multiplexer
      
endmodule

