module memory  #(parameter WIDTH = 32, DEPTHI = 16)
(
  input  wire               clk,      //Clock Signal
  input  wire               rst,      //Reset Signal
  input  reg                MemRead,  //Reading Enable
  input  reg                MemWrite, //Writting Enable
  input  reg  [(WIDTH-1):0] Address,    //Directioning Address
  input  wire [(WIDTH-1):0] WD,       //Write Data
  output reg  [(WIDTH-1):0] RD        //Read Data
);

reg [(WIDTH-1):0] mem [0:(1<<DEPTHI)-1]; //Storage


  always_ff @(posedge clk) begin

    if(rst)begin //Clean up all addresses
      for (int i=0; i<(1<<DEPTHI)-1; i++) 
        mem[i] <= 'h0;
      end  
    else if(MemWrite) //Write Memory
      mem[Address[DEPTHI-1:0]] <= WD; 
  end

  always_ff @(negedge clk)  begin
    if(MemRead) //Read Memory
      RD <= mem[Address[DEPTHI-1:0]];
  end   
            
endmodule