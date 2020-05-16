module IorD_mux #(parameter  DEPTHI = 8)
(
    input  reg  [(DEPTHI-1):0] PC,       //read PC
    input  reg  [(DEPTHI-1):0] ALU,      //read ALU
    input  reg  IorD,                    //Bit of Control
    output wire [(DEPTHI-1):0] Address   //Write Address
);

    assign Address = !IorD ? PC:ALU;     //Multiplexer


endmodule
