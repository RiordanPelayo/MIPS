module instructionReg #(parameter WIDTH =32, DEPTHI = 8)
(  
   input  wire                clk,       //Clock Signal
                              rst,       //Reset Signal
   input  reg  [(DEPTHI-1):0] Counter,   //Program Counter Input
   output reg  [5:0]          Opcode,    //Specification of Instruction
   output reg  [4:0]          Reg1,      //Register Specifications
                              Reg2,          
   output reg  [15:0]         Inmediate  //Immediate Constant Value
);

reg [(DEPTHI-1):0] Instr [0:(1<<DEPTHI-1)];  //Array of instructions
reg [(WIDTH-1):0] Instruction;

initial begin

   $readmemh("Instr.mem", Instr);

end

always_ff @(posedge clk) begin
   if(rst)begin
      Opcode = 'h0;
      Reg1   = 'h0;
      Reg2   = 'h0;
      Inmediate   = 'h0;
      Instruction = 'h0;
   end
   else begin
         Instruction [7:0]   = Instr[Counter+3];
         Instruction [15:8]  = Instr[Counter+2];
         Instruction [23:16] = Instr[Counter+1];
         Instruction [31:24] = Instr[Counter];

         Opcode = Instruction[31:26];
         Reg1   = Instruction[25:21];
         Reg2   = Instruction[20:16];
         Inmediate = Instruction[15:0];
   end  
end   


endmodule
