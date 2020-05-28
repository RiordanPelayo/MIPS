module PC  #(parameter WIDTH = 32)
(  
   input  wire              clk,    //Clock Signal
   input  wire              rst,    //Reset Signal
   input  reg [(WIDTH-1):0] Next,   //Next Number Instruction
   output reg [(WIDTH-1):0] Actual  //Actual Number Instruction
);

always @(posedge clk) begin
  
   if(rst)
      Actual <= 'h0;
   else
      Actual <= Next;

end

endmodule

