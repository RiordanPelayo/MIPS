module memoryRegister  #(parameter WIDTH =32)
(
   input reg [(WIDTH-1):0] Address,     //Current Address
   output reg[(WIDTH-1):0] Instruction  //Current Instruction
);

assign Instruction = Address;

endmodule
