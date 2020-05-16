module Full_Adder(
	input  A,B,Ci, //Input values for the addition
	output Co,S    //Output values resulting from the addition
);
assign S = Ci ^ A ^ B;                //Output sum (LSB)
assign Co = (A & B) + (Ci & (A ^ B)); //Output carry (MSB)
endmodule  
