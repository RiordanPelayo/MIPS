module AddSub(
  input reg [31:0] A,      //32-bit number A (unsigned)
                   B,      //32-bit number B (unsigned)
  input reg [3:0] control, //Control input. It chooses with operation will be performed
  input wire clock,   //Clock signal
             reset,   //Reset signal
             start,   //Start of an operation signal
  output reg sign,    //Sign of the final result (0 = positive, 1 = negative)
  output reg finish,  //Finish of an operation signal
  output reg [31:0] C //Result of the operation
  );

  reg [32:0] As,   //Two complement variable
             Bs;   //Two complement variable
  wire [33:0] Cs;  //Output with the result, sign and dummy carry
  wire finish_add; //Finish addition flag wire
  reg carry_dummy; //Dummy carry

  localparam  ADDPP = 4'b1000, //Both numbers are positive (A+B)
              ADDPN = 4'b1001, //Number A is positive and number B is negative (A-B)
              ADDNP = 4'b1010, //Number A is negative and number B is positive (-A+B)
              ADDNN = 4'b1011; //Both numbers are negative (A-B)

  Adder_FSM adder( //Adder Finite State Machine submodule
    .A(As),
    .B(Bs),
    .clock(clock),
    .reset(reset),
    .start_add(start),
    .finish_add(finish_add),
    .S(Cs)
    );

  always@(*) begin
    if(start & ~finish_add) begin //If a start signal is present (1) and the finish flag is not present (no operation), then...
      case(control)
        ADDPP: begin //Adding both numbers positive
          As <= A;
          Bs <= B;
        end
        ADDPN: begin //Adding number A positive and number B negative
          As <= A;
          Bs <= ((~B) + 1'b1); //Doing two complement to number B
        end
        ADDNP: begin //Adding number A negative and number B positive
          As <= ((~A) + 1'b1); //Doing two complement to number A
          Bs <= B;
        end
        ADDNN: begin //Adding both numbers negative
          As <= ((~A) + 1'b1);
          Bs <= ((~B) + 1'b1);
        end
      endcase
    end
    else if(~start & finish_add) begin //Once the addition has finished, all the values 
        finish <= 1'b1;
        C <= Cs[31:0];  //Obtaining the final result 
        sign <= Cs[32]; //Obtaining the sign of the result
        carry_dummy <= Cs[33]; //Obtaining the dummy carry of the result
    end
    else 
      finish <= 1'b0;
  end
endmodule
