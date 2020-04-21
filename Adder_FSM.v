module Adder_FSM(
	input reg [32:0] A,    //32-bit signed number A
	input reg [32:0] B,    //32-bit signed number B
	input wire clock,      //Clock signal
	input wire reset,      //Reset system flag
	input wire start_add,  //The addition is going to start
	output reg finish_add, //The addition has been completed
	output reg [33:0] S    //Final value of the addition (signed)
);

reg [31:0] C;      //Inner carries, from all the ten individual additions
reg [1:0] state;   //Variable for controling all the states in the FSM
reg [5:0] counter; //Counter for all the bits in the inputs
reg An, Bn, Cin;   //Inner variables for addition (inputs)
wire Sn, Con;      //Inner variables for resulting addition (output)

localparam STR = 2'b00, //The addition is waiting to start
		   ADD = 2'b01, //The addition is loading data
	  	   RES = 2'b10, //The addition is obtaining results
		   FNS = 2'b11; //Result of the addition, and the finish of the operation

Full_Adder full_adder_module( //Full-adder submodule
	.A(An),   //First bit
	.B(Bn),   //Second bit
	.Ci(Cin), //Input carry
	.Co(Con), //Output carry (sum MSB)
	.S(Sn)    //Output (sum LSB)
);

always@(posedge clock or posedge reset) begin
	if(reset) begin         //If a reset occurs...
		An <= 1'b0;         //Number A goes to zero
		Bn <= 1'b0;         //Number B goes to zero
		Cin <= 1'b0;        //Input carry goes to zero
		C <= 1'b0;          //Internal carries goes to zero
		S <= 1'b0;          //The general output goes to zero
		counter <= 1'b0;    //Counter goes to zero
		finish_add <= 1'b0; //The finish flag is zero
		state <= ADD;       //The FSM goes to the first state
	end
	else begin              //If a reset is not present...
		case(state)
			STR: begin      /* START STATE */
				if(start_add & ~finish_add)
					state <= ADD;
				else
					state <= STR;
			end
			ADD: begin      /* VALUES ASSIGNATION */
				An = A[counter];
				Bn = B[counter];
				if(counter == 1'b0)
					Cin = 1'b0;
				else
					Cin = C[counter - 1];
				state <= RES;
			end
		  RES: begin        /* GETTING RESULTS */
				S[counter] <= Sn;
				if(counter < 6'b100000) begin
					C[counter] <= Con;
					counter <= counter + 1'b1;
					finish_add <= 1'b0;
					state <= ADD;
				end
				else begin
					S[33] <= Con;
					counter <= 1'b0;
					finish_add <= 1'b1;
					state <= FNS;
				end
		  end
			FNS: begin       /* FINISHING THE OPERATION */
				if(start_add & finish_add) begin
					finish_add <= 1'b0;
					state <= STR;
				end
				else
					state <= FNS;
			end
		endcase
	end
end
endmodule
