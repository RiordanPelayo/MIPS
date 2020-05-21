module signExtend
(
    input  reg [15:0] in,   //Immediate 
    output reg [31:0] out   //Immediate Extend
);


assign  out = 32'(signed'(in));

   
endmodule