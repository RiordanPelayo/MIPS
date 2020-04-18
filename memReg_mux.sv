module memReg_mux #(parameter WIDTH =32)
(
    input  reg  [(WIDTH-1):0] ALU,         //read ALU
    input  reg  [(WIDTH-1):0] Instrction,  //read ALU
    input  reg  memReg,                    //Bit of control
    output wire [(WIDTH-1):0] WD           //Write data
);

    assign WD = !memReg ? ALU:Instrction;  //multiplexer


endmodule
