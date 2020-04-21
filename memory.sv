module memory  #(parameter WIDTH =32, DEPTH=5)
(
   input wire clk,                      //Clock Signal
   input reg MemRead,                   //Reading Enable
   input reg MemWrite,                  //Writting Enable
   input reg [(DEPTH-1):0] Address,     //Directioning Address
   input wire[(WIDTH-1):0] WD,          //Write Data
   output reg[(WIDTH-1):0] RD           //Read Data
);

reg [(WIDTH-1):0]register[0:(1<<DEPTH)-1];   //Storage

  //Read register
  assign RD = (MemRead &&(Address < 33))?register[Address]:'hzzzz_zzzz; 
        
  always@(posedge clk)
  begin
    if(MemWrite &&(Address < 33)) //Write register
      register[Address] <= WD; 
  end      
endmodule