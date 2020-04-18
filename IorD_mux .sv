module IorD_mux #(parameter WIDTH = 32)
(
    input  reg  [(WIDTH-1):0] PC,       //read PC
    input  reg  [(WIDTH-1):0] ALU,      //read ALU
    input  reg  IorD,                   //Bit of Control
    output wire [(WIDTH-1):0] Address   //Write Address
);

    assign Address = !IorD ? PC:ALU;    //Multiplexer


endmodule
