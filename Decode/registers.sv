module registers #(parameter WIDTH =32, DEPTH=5)
(
   input wire              clk,         //Clock Signal
   input wire              rst,         //Reset Signal
   input reg               RegWrite,    //Writting Enable
   input reg [(DEPTH-1):0] RR1, RR2,    //Read Register Addresses
   input reg [(DEPTH-1):0] WR,          //Write Register Addresses
   input wire[(WIDTH-1):0] WD,          //Write Data
   output reg[(WIDTH-1):0] RD1, RD2     //Read Data 
);

reg [(WIDTH-1):0] register [0:(1<<DEPTH)-1];  //Storage

  
  always_ff @(posedge clk) begin

    if(rst)begin //Clean up all addresses
      for (int i=0; i<(1<<DEPTH)-1; i++)   
        register[i] = 'h0;
    end  
    else if(RegWrite && (WR < 33)) //Write Register
      register[WR] <= WD; 
  end

  always_ff @(negedge clk)  begin
    RD1 <= register[RR1]; //Read address RR1
    RD2 <= register[RR2]; //Read address RR2
  end   

endmodule