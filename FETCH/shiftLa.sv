module ShiftLa #(parameter WIDTH = 32)
(         
    input  reg  [(WIDTH-1):0]  signext, //Sign Extend Value
    output reg  [(WIDTH-1):0]  ADD      //Value to Add    
);

    
assign ADD = signext << 2;  
  
endmodule