module shiftL2
(
    input  reg [4:0] Reg1,        //instruction [25:21]
    input  reg [4:0] Reg2,        //instruction [20:16]
    input  reg [4:0] Inmediate,   //instruction [15:0]
    output reg [27:0] out
);

reg [25:0] in;

// in = [Reg1+Reg2+Inmediate]
assign in[25:21] = Reg1;
assign in[20:16] = Reg2;      
assign in[15:0]  = Inmediate; 

    assign out = in<<2;

endmodule
