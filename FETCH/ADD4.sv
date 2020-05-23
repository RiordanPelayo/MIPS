module ADD4 #(parameter DEPTHI = 16)
(     
      input  wire                clk,
      input  wire                rst,
      input  reg  [(DEPTHI-1):0] PCin,  //Program Counter    
      output reg  [(DEPTHI-1):0] Added  //Next PC
);

always_ff @(posedge clk) begin
    if (rst) 
      Added <= 'h4;   
    else 
      Added <= PCin + 4;
          
end


endmodule
