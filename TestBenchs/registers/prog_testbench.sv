program prog_testbench #(parameter WIDTH =32, DEPTH=5)
(
   input wire clk,                       //Clock signal
   output reg RegWrite,                  //Writting Enable
   output reg [(DEPTH-1):0] RR1, RR2,    //Read Register Addresses
   output reg [(DEPTH-1):0] WR,          //Write Register Addresses
   output reg [(WIDTH-1):0] WD,          //Write Data
   input reg  [(WIDTH-1):0] RD1, RD2     //Read Data 
);

import class_instr_pkg::*;     //Import pakage class

write_instr write_obj;         //Declare the objects
save_instr save_obj;           //to use

initial
begin
write_obj = new();    //Create write object
save_obj  = new();    //Create write object


   $display("+-------------------+");
   $display("| Start simulation! |");
   $display("+-------------------+");
  
   resetArray();
   showArray();
   write_obj.writeData('h1111_FFFF, 'h00);
   write_obj.writeData('h1111_FFFF, 'h10);
   writeArray();
   showArray();
   saving('h12);
   showSaved();

end
 
task resetArray();
//import reset function from write class
automatic memory_array_T reset_mem = write_obj.reset;   

   RegWrite = 1;                           //Enable writing

   for( byte i = 0; i<32; i++)             //Reset all the 
     begin                                 //locations in
         WR = i;                           //memory
         WD = reset_mem.mem_data[i];
         @(posedge clk);
     end    
   
endtask


task writeArray();
//import writeMem function from write class
automatic memory_array_T written_mem = write_obj.writeMem;
//Read enable     
   RegWrite = 1;                           //Enable writing

   for(byte i = 0; i<32; i++)       
      begin                                //Update the value
         WR = i;                           //of all the
         WD = written_mem.mem_data[i];     //locations in memory
         @(posedge clk);
  
      end
endtask

task showArray();
$display("====================");
$display(" Memory Array Data  ");
$display("====================");
    
   RegWrite = 0;                        //Read enable 

     for( byte i = 0; i<32; i++)
     begin
         RR1 = i;                       //Displays the value 
         @(posedge clk);                //of all loactions
         $display("0x%h - %h", i, RD1); //in memory
      end   

endtask 

task saving(bit [4:0] add);
   RegWrite = 0;                        //Read enable

   RR1 = add; 
   @(posedge clk); 
   save_obj.saveData(RD1, add);
endtask

task showSaved();
//import savedMem function from save class
automatic memory_array_T saved_mem = save_obj.savedMem;

$display("====================");
$display("  Saved Array Data  ");
$display("====================");

   for (byte i=0; i<32; i++) 
      $display("0x%h - %h",i, saved_mem.mem_data[i]);
endtask

endprogram