`timescale 1ns/1ps

program fsm_tb (fsm_if fsm_if_objtb);

   initial begin

       fsm_if_objtb.OpCode = 'h00;
       $display("+------------------+");
       $display("| Start Simulation |");
       $display("+------------------+");
       $display("\n");
      


       @(posedge fsm_if_objtb.clk);
       Fetch();
       @(posedge fsm_if_objtb.clk);
       Decode();
       @(posedge fsm_if_objtb.clk);    
       R_Type();  
       @(posedge fsm_if_objtb.clk); 
       Fetch();
   end

task Fetch();
    $display("-------------- Fetch -------------");
    $display(">> MemRead: %b, ALUSrcA: %b, IorD: %h, IRWrite: %b ", fsm_if_objtb.MemRead, fsm_if_objtb.ALUSrcA, fsm_if_objtb.IorD, fsm_if_objtb.IRWrite);
    $display(">> ALUSrcB: %b, ALUOp: %b, PCWrite: %h, PCSrc: %b --> %t", fsm_if_objtb.ALUSrcB, fsm_if_objtb.ALUOp, fsm_if_objtb.PCWrite, fsm_if_objtb.PCSrc, $realtime);
endtask

task Decode();
    $display("------------- Decode -------------");
    $display(">> ALUSrcA: %b, ALUSrcB: %b, ALUOp: %b --> %t", fsm_if_objtb.ALUSrcA, fsm_if_objtb.ALUSrcB, fsm_if_objtb.ALUOp,  $realtime);
endtask

task R_Type();
    $display("------------- R_type -------------");
    $display(">> RegDst: %b, RegWrite: %b, MemtoReg: %b --> %t", fsm_if_objtb.RegDst, fsm_if_objtb.RegWrite, fsm_if_objtb.MemtoReg,  $realtime);

endtask

endprogram

