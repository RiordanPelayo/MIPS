module JumpMux #(parameter  WIDTH =32)
(
    input  wire               Jump,     //Control Mux
    input  reg  [(WIDTH-1):0] Added,    //PC+4
    input  reg  [27:0]        Shift,    //Shift Left Result
    input  reg  [(WIDTH-1):0] bnq,      //Branch Address
    output wire [(WIDTH-1):0] Address   //Write Address
);



assign Address = !Jump ? bnq:(Added[31:28]|Shift);  //Multiplexer

endmodule
