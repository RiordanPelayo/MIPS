module signExtend
(
    input  reg [15:0] in,
    output reg [31:0] out
);

    assign out = 32'(signed'(in));

endmodule