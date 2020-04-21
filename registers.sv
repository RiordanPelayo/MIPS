module registers #(parameter WIDTH =32, DEPTH=5)
(
   input wire clk,                      //Clock signal
   input reg RegWrite,                  //Writting Enable
   input reg [(DEPTH-1):0] RR1, RR2,    //Read Register Addresses
   input reg [(DEPTH-1):0] WR,          //Write Register Addresses
   input wire[(WIDTH-1):0] WD,          //Write Data
   output reg[(WIDTH-1):0] RD1, RD2     //Read Data 
);

reg [(WIDTH-1):0]register[0:(1<<DEPTH)-1];  //Storage

  //Read register
  assign RD1 = (!RegWrite &&(RR1 < 33))?register[RR1]:'hzzzz_zzzz; //Show Address on RD1
  assign RD2 = (!RegWrite &&(RR2 < 33))?register[RR2]:'hzzzz_zzzz; //Show Address on RD2
        
  always@(posedge clk)
  begin
    if(RegWrite &&(WR < 33)) //Write Register
      register[WR] <= WD; 
  end      
endmodule