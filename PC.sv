module PC  #(parameter WIDTH =32)
(
   input reg [(WIDTH-1):0] Count,     //Next Address
   output reg[(WIDTH-1):0] Address    //Current Address
);

assign Address = Count;

endmodule

