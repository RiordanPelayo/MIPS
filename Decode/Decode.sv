module Decode #( parameter WIDTH =32, DEPTH=5)
(
    input  wire               clk,       //Clock Signal
    input  wire               rst,       //Reset Signal
    input  reg                RegWrite,  //Writting Enable
    input  reg                memReg,    //Write Data Mux 
    input  reg                RegDst,    //Write Reg Mux
    input  reg  [(DEPTH-1):0] Reg1,      //Register Specifications
                              Reg2,
    input  reg  [15:0]        Inmediate, //Immediate Constant Value          
    input  reg  [(WIDTH-1):0] ALUres,    //ALU Result
                              RData,     //Readed Data  
    output reg  [(WIDTH-1):0] RD1, RD2   //Read Data                                            
);

wire [(DEPTH-1):0] regmux;
wire [(WIDTH-1):0] datamux;

registers u_registers(
    .clk      (clk),
    .rst      (rst),
    .RegWrite (RegWrite),
    .RR1      (Reg1),
    .RR2      (Reg2),
    .WR       (regmux),
    .WD       (datamux),
    .RD1      (RD1),
    .RD2      (RD2)
);

regDst_mux u_regDst_mux (
    .Reg2         (Reg2),
    .Inmediate    (Inmediate),
    .RegDst       (RegDst),
    .WR           (regmux)
);

memReg_mux u_memReg_mux (
    .ALU         (ALUres),
    .ReadData    (RData),
    .memReg      (memReg),
    .WD          (datamux)
);

    
endmodule