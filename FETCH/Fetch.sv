module Fetch #(parameter WIDTH =32, DEPTHI = 16)
(
    input  wire                 clk,       //Clock Signal
                                rst,       //Reset Signal
    input  wire                 Jump,      //Control of Jump MUX
    input  reg                  Branch,    //Control of Branch MUX
    input  reg                  Zero,      //ALU Zero Signal
    input  reg                  stop,      //Signal to Stop Adder
    input  reg   [(WIDTH-1):0]  signext,   //Sign Extend Value
    output reg   [5:0]          Opcode,    //Specification of Instruction
    output reg   [4:0]          Reg1,      //Register Specifications
                                Reg2,          
    output reg   [15:0]         Immediate,  //Immediate Constant Value
    output reg   [27:0]         jumped  

);

wire [4:0]  Reg1S,
            Reg2S;
wire [15:0] ImmediateS;
wire [27:0] Shift; 

wire [(WIDTH-1):0] pc_out, 
                   jump_pc,
                   bnq_jump,
                   add4,
                   Shifted,
                   Shifta;

 
                               

instructionReg u_instructionReg (
    .clk              (clk),
    .rst              (rst),
    .Counter          (pc_out),
    .Opcode           (Opcode),
    .Reg1             (Reg1S),
    .Reg2             (Reg2S),
    .Immediate        (ImmediateS)
);

PC u_PC (
    .clk         (clk),
    .rst         (rst),
    .Next        (jump_pc),
    .Actual      (pc_out)
);

BranchMux u_Branch (
    .Branch (Branch),
    .Zero   (Zero),
    .Added  (add4),
    .Shifta (Shifta),
    .bnq    (bnq_jump)
);

JumpMux u_Jump (
    .Jump    (Jump),
    .Added   (add4),
    .Shift   (Shift),
    .bnq     (bnq_jump), 
    .Address (jump_pc)
);

ADD4 u_ADD4 (
    .clk   (clk),
    .rst   (rst),
    .stop  (stop),
    .PCin  (pc_out),
    .Added (add4)
);

ADD u_ADD (
    .clk   (clk),
    .rst   (rst),
 //   .stop  (stop),
    .A     (add4),
    .B     (Shifted),
    .bnq   (Shifta)
);

ShiftL2 u_ShiftL2(
   .Reg1 (Reg1S),
   .Reg2 (Reg2S),
   .Jump (Shift),
   .Immediate  (ImmediateS)
);

ShiftLa u_ShiftLa (
    .signext (signext),
    .ADD     (Shifted)
);

assign Reg1 = Reg1S;
assign Reg2 = Reg2S;
assign Immediate = ImmediateS;
assign jumped = Shift;
endmodule