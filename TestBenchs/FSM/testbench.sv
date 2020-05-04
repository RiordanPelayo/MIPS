`timescale 1ns/1ps

program fsm_tb (fsm_if fsm_if_objtb);

   initial begin

       fsm_if_objtb.OpCode = 'h00;
       $display("+------------------+");
       $display("| Start Simulation |");
       $display("+------------------+");
       $display("");
      
       $monitor(">> ALUOp: %b, ALUSrcA: %b, ALUSrcB: %b, PCSrc: %b ", fsm_if_objtb.ALUOp, fsm_if_objtb.ALUSrcA, fsm_if_objtb.ALUSrcB, fsm_if_objtb.PCSrc);
       $monitor(">> RegWrite: %b, MemtoReg: %b, RegDst: %b, PCWrite: %b", fsm_if_objtb.RegWrite, fsm_if_objtb.MemtoReg, fsm_if_objtb.RegDst, fsm_if_objtb.PCWrite);
       $monitor(">> IorD: %b, MemRead: %b, MemWrite: %b, IRWrite: %b --> %t", fsm_if_objtb.IorD, fsm_if_objtb.MemRead, fsm_if_objtb.MemWrite, fsm_if_objtb.IRWrite, $realtime);

      #100;
   end

   initial begin

   end



endprogram

