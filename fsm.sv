module fsm 
(
  input wire clk,              //Clock
  input wire rst,              //Reset
  input reg  [5:0] OpCode,     //Operations
  output reg [3:0] ALUOp,      //ALU Operation 
  output reg [1:0] ALUSrcB,    //ALU Source for B
  output reg [1:0] PCSrc,      //Source for PC mux
  output reg ALUSrcA,          //ALU Source for A
  output reg RegWrite,         //Register Write Enable
  output reg MemtoReg,         //Write Data mux
  output reg RegDst,           //Register Destination Enable
  output reg PCWrite,          //PC Write Enable
  output reg IorD,             //Instruction or Direction mux
  output reg MemRead,          //Read Memory
  output reg MemWrite,         //Write on Memory
  output reg IRWrite           //Instruction Write
);


//******************** STATES ****************************************
localparam [3:0] fetch  = 'b0000, //Instruction Fetch
                 decode = 'b0001, //Instruction Decode
                 mem    = 'b0010, //Memory Address Computation
                 memA   = 'b0011, //Memory Access
                 wback  = 'b0100, //Write-back Step
                 exe    = 'b0101, //Execution
                 rcomp  = 'b0110, //R-type Completion
                 branch = 'b0111, //Branch Completion
                 jcomp  = 'b1000; //Jump Completion 
//********************************************************************                 

//******************** OpCode ****************************************
localparam [5:0] rtype  = 'h00, //
                 rityp  = 'h01, //
                 jump   = 'h02, //
                 jal    = 'h03, //
                 beq    = 'h04, //
                 bne    = 'h05, //
                 blez   = 'h06, //
                 lw     = 'h07, //
                 sw     = 'h08; //
//********************************************************************   

reg [3:0] PresentState, NextState;


always @( posedge clk, posedge rst ) begin
  if (rst == 1'b1) 
    PresentState <= fetch;
  else begin
    PresentState <= NextState;  
    end
end

always @( PresentState )begin

  case ( PresentState )

//****************** Fetch **********************************
    fetch:begin             
      MemRead <= 1;
      ALUSrcA <= 0;
      IorD    <= 0;
      IRWrite <= 1;
      ALUSrcB <= 'b01;
      ALUOp   <= 'b00;
      PCWrite <= 1;
      PCSrc   <= 'b00;

      NextState <= decode;
    end
//***********************************************************
//****************** Decode *********************************
    decode:begin   
      ALUSrcA <= 0;
      ALUSrcB <= 'b11;
      ALUOp   <= 'b00;
      
      if (OpCode == rtype) begin
        NextState <= rcomp;
      end
      else if (OpCode == beq) begin
        NextState <= branch;
      end
      else if (OpCode == jump) begin
        NextState <= jcomp;
      end
      else begin
        NextState <= mem;
      end
    
    end
//***********************************************************
//********************* Memory ******************************
    mem: begin        
      ALUSrcA <= 1;
      ALUSrcB <= 'b10;
      ALUOp   <= 'b00;

      NextState <= memA;
    end
//***********************************************************
//****************** Memory Access **************************
    memA: begin       
      IorD    <= 1;
      
   if (OpCode == lw) begin
      MemRead <= 1;

      NextState <= wback;
   end
      else if ( OpCode == sw ) begin
        MemWrite <= 1;

        NextState <= fetch;
      end
 
    end
//***********************************************************
//******************** Write-Back ***************************
    wback: begin
      RegDst   <= 0;
      RegWrite <= 1;
      MemtoReg <= 1;

      NextState <= fetch;
    end
//***********************************************************
//********************* Execution ***************************
    exe:begin
      ALUSrcA <= 1;
      ALUSrcB <= 'b00;
      ALUOp   <= 'b10;

      NextState <= rcomp;
    end
//***********************************************************
//******************** R-Completion *************************
    rcomp:begin
      RegDst   <= 1;
      RegWrite <= 1;
      MemtoReg <= 0;

      NextState <= fetch;
    end
//***********************************************************
//****************** Branch-Completion **********************      
    branch: begin
      ALUSrcA <= 1;
      ALUSrcB <= 'b00;
      ALUOp   <= 'b01;
      PCSrc   <= 'b01;
    
      NextState <= fetch;
    end  
//***********************************************************
//******************* Jump-Completion *********************** 
    jcomp:begin
      PCWrite <= 1;
      PCSrc   <= 'b10;

      NextState <= fetch;
    end

    default: begin
    end
//***********************************************************    
  endcase    
          
end


endmodule