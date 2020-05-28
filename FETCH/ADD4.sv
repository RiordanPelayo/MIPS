module ADD4 #(parameter WIDTH =32)
(     
      input  wire                clk,
      input  wire                rst,
      input  reg                 stop,  //Signal to Stop Adder
      input  reg  [(WIDTH-1):0]  PCin,  //Program Counter    
      output reg  [(WIDTH-1):0]  Added  //Next PC
);

always_ff @(posedge clk) begin
    if (rst) 
      Added <= 'h0;   
    else if ( !stop )
      Added <= PCin + 4;
    else
      Added <= PCin;   
          
end

endmodule
