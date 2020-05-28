module ADD #(parameter WIDTH =32)
(     
      input  wire                clk,
      input  wire                rst,
      //input  reg                 stop,  //Signal to Stop Adder
      input  reg  [(WIDTH-1):0]  A,     //PC+4 Result    
      input  reg  [(WIDTH-1):0]  B,     //Shift Left Result
      output reg  [(WIDTH-1):0]  bnq    //Branch
);

always_ff @(posedge clk) begin
    if (rst) 
      bnq <= 'h0;   
    else //if ( !stop )
      bnq <= A + B;
    //else
    //  bnq <= bnq;   
          
end


endmodule
