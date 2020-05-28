`timescale 1ns/1ps

program fsm_tb (fsm_if fsm_if_objtb);

integer file;

   initial begin

       file = $fopen("output.log","w");

       $display("+------------------+");
       $display("| Start Simulation |");
       $display("+------------------+");
       $display("\n");
      
       $fmonitor(file,"RegDst: %h, MemtoReg: %h, ALUOp: %h, ALUSrc: %h, RegWrite: %h --> %t",fsm_if_objtb.RegDst, fsm_if_objtb.MemtoReg, fsm_if_objtb.ALUOp, fsm_if_objtb.ALUSrc, fsm_if_objtb.RegWrite, $realtime);
       
       #100;
   end

   initial begin

       fsm_if_objtb.OpCode<= 'h20;

        for (int i=0; i<5; i++) 
           @(posedge fsm_if_objtb.clk);
   
       fsm_if_objtb.OpCode<= 'h28;

        for (int i=0; i<5; i++) 
           @(posedge fsm_if_objtb.clk);

        fsm_if_objtb.OpCode<= 'h02;

        for (int i=0; i<5; i++) 
           @(posedge fsm_if_objtb.clk);   

        fsm_if_objtb.OpCode<= 'h0b;

        for (int i=0; i<7; i++) 
           @(posedge fsm_if_objtb.clk);   
       
       
   end



endprogram

