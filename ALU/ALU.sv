module ALU(
    input  wire       clock,
                      reset,
    input  reg [31:0] A,
                      B,
    input  reg [3:0]  opcode, 
    input  wire       start,
    output reg        sign,
                      finish,
    output reg [31:0] C
);

    reg [31:0] A_logic,
               A_arith,
               B_logic,
               B_arith,
               C_logic,
               C_arith;
    wire sign_arith;
    reg start_logic  = 1'b0,
        start_arith  = 1'b0,
        finish_logic = 1'b0,
        finish_arith = 1'b0;

    localparam NOTA  = 4'b0000,   //OPCODE for NOT(A)
               NOTB  = 4'b0001,   //OPCODE for NOT(B)
               AND   = 4'b0010,   //OPCODE for A AND B
               OR    = 4'b0011,   //OPCODE for A OR B
               XOR   = 4'b0100,   //OPCODE for A XOR B
               NAND  = 4'b0101,   //OPCODE for A NAND B
               NOR   = 4'b0110,   //OPCODE for A NOR B
               XNOR  = 4'b0111,   //OPCODE for A XNOR B
               ADDPP = 4'b1000,   //Both numbers are positive (A+B)
               ADDPN = 4'b1001,   //Number A is positive and number B is negative (A-B)
               ADDNP = 4'b1010,   //Number A is negative and number B is positive (-A+B)
               ADDNN = 4'b1011;   //Both numbers are negative (A-B)

    AddSub ARITHMETIC (
        .A(A_arith),      
        .B(B_arith),    
        .control(opcode), 
        .clock(clock),   
        .reset(reset),   
        .start(start_arith),   
        .sign(sign_arith),    
        .finish(finish_arith),  
        .C(C_arith) 
    );

    Logic_op LOGIC(
        .A(A_logic),     
        .B(B_logic),     
        .log_op(opcode), 
        .start(start_logic),       
        .finish(finish_logic),     
        .C(C_logic)    
    );

    always@(posedge clock or posedge reset) begin
        if(reset) begin
            C <= 32'b0;
            finish <= 1'b0;
        end
        else begin
            if(opcode <= XNOR) begin
                A_logic <= A;
                B_logic <= B;
                if(start)
                    start_logic <= 1'b1;
                else 
                    start_logic <= 1'b0;
                if(~start_logic & finish_logic) begin
                    C <= C_logic;
                    sign   <= 1'b0;
                    finish <= 1'b1;
                end
                else begin                        
                    finish_logic <= 1'b0;             
                    finish       <= 1'b0;
                end
            end
            else if(opcode >= ADDPP) begin
                A_arith <= A;
                B_arith <= B; 
                if(start)
                    start_arith <= 1'b1;
                else 
                    start_arith <= 1'b0;
                if(~start_arith & finish_arith) begin
                    C      <= C_arith;
                    sign   <= sign_arith;
                    finish <= 1'b1;
                end
                else begin                        
                    finish_arith <= 1'b0;             
                    finish <= 1'b0;
                end
            end
        end
    end
endmodule