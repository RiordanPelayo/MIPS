module BranchMux #(parameter  WIDTH =32)
(
    input  reg                Branch,  //Control Mux
    input  reg                Zero,    //ALU Zero Signal
    input  reg  [(WIDTH-1):0] Added,   //PC+4
    input  reg  [(WIDTH-1):0] Shifta,  //Shift Added
    output wire [(WIDTH-1):0] bnq      //Write Address
);

    assign bnq = !(Branch & Zero) ? Added:Shifta;  //Multiplexer


endmodule
