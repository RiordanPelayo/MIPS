module regDst_mux 
(
    input  reg  [4:0]  Reg2,        //Reg2 Data
    input  reg  [15:0] Inmediate,   //Inmediate Data
    input  reg  RegDst,             //Bit of Control
    output wire [4:0] WR            //Write Register
);

reg [4:0] number; //Register to save the inmediate value

    assign number =  Inmediate[15:11];    //Take only the inmediate value
    assign WR = !RegDst ? Reg2:Inmediate; //multiplexer
      
endmodule

