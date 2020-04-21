module A #(parameter WIDTH =32)
(
    input reg [(WIDTH-1):0] in,   //Input Data
    output reg[(WIDTH-1):0] out   //Output Data 
);


assign out = in;

endmodule 
