module shiftL
(
    input  reg [31:0] in,
    output reg [31:0] out
);

    assign out = in<<2;

endmodule