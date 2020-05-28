module fsm 
(
  input  wire       clk,       //Clock
  input  wire       rst,       //Reset
  input  reg  [5:0] OpCode,    //Operations
  output reg        stop,      //Signal to Stop Adder
  output reg        RegDst,    //Register Destination Enable
  output reg        Jump,      //Control of Jump MUX
  output reg        Branch,    //Control of Branch MUX
  output reg        MemRead,   //Read Memory
  output reg        MemtoReg,  //Write Data mux
  output reg        ALUSrc,    //ALU Source mux
  output reg        RegWrite,  //Register Write Enable
  output reg        MemWrite,  //Write on Memory
  output reg  [3:0] ALUOp      //ALU Operation 
);

//************** Opcode Inputs *************************************
localparam    rtyp  = 'h00,   //R-type instructions
              jump  = 'h02,   //Jump Unconditional
              beq   = 'h04,   //Branch on Equal
              addi  = 'h08,   //Add
              addiu = 'h09,   //Add Immediate
              slti  = 'h0a,   //Set on less than Immediate
              stliu = 'h0b,   //Set on less than Immediate Unsigned         
              andi  = 'h0c,   //AND with Immediate
              ori   = 'h0d,   //OR with Immediate
              xori  = 'h0e,   //XOR with Immediate
              load  = 'h20,   //Load 
              store = 'h28;   //Storage
//*******************************************************************                 

//******************** STATES ***************************************
localparam [2:0] fetch  = 'b000, //Instruction Fetch
                 decode = 'b001, //Instruction Decode
                 exe    = 'b010, //Execution
                 memA   = 'b011, //Memory Access
                 wback  = 'b100; //Write-back Step
//*******************************************************************                 

reg [2:0] PresentState, NextState;


always @( posedge clk, posedge rst ) begin
  if (rst == 1'b1) 
    PresentState <= fetch;
  else begin
    PresentState <= NextState;  
    end
end

always @( PresentState )begin

  case ( PresentState )

//****************** Fetch *********************************
    fetch:begin             
      
      stop     <= 0;
      Jump     <= 0;
      Branch   <= 0;
      RegDst   <= 0;
      RegWrite <= 0;
      ALUSrc   <= 0;
      ALUOp    <= rtyp;
      ALUSrc   <= 0;
      MemtoReg <= 0;
      MemRead  <= 0;
      MemWrite <= 0;

      NextState <= decode;
    end
//***********************************************************
//****************** Decode *********************************
    decode:begin   
          
          stop <= 1;
        
          case ( OpCode )

            rtyp:begin
              RegDst <= 1;  
              ALUOp  <= rtyp;
              ALUSrc <= 0;  
            end

            jump:
              Jump <= 1;

            beq:begin
              Branch <= 1;
              ALUOp  <= addi;
            end

            addi: begin
              RegDst <= 1;        
              ALUSrc <= 1;
              ALUOp  <= addi;

            end

            addiu: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= addiu;
            end

            slti: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= slti;
            end
  
            stliu: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= stliu;
            end  

            andi: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= andi;
            end

            ori: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= ori;
            end

            xori: begin
              RegDst <= 1;       
              ALUSrc <= 1;
              ALUOp  <= xori;
            end

            load: begin
              ALUSrc <= 1;
              ALUOp  <= 'hf;
              MemtoReg <= 1;
            end

            store: begin
              ALUSrc <= 0;
              ALUOp  <= 'hf; 
            end

  
          endcase

      NextState <= exe;
    
    end
//********************* Execution ***************************
    exe:begin
     
          
      NextState <= wback;
    end
//***********************************************************

//******************** Write-Back ***************************
    wback: begin   
           case ( OpCode )

            jump:begin
              
            end

            beq:begin
              
            end

            load: begin
              MemRead  <= 1;
              RegWrite <= 1;
            end

            store: begin
              MemWrite = 1;
            end

            default:
              RegWrite <= 1;

          endcase

          stop <= 0;
      
      NextState <=fetch;
    end
//***********************************************************

  endcase    
          
end


endmodule