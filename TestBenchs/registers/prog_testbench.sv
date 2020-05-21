program prog_testbench #(parameter WIDTH =32)
(
   input  wire              clk,      //Clock signal
   input  wire              rst,      //Reset Signal
   output reg               MemRead,  //Reading Enable
   output reg               MemWrite, //Writting Enable
   output reg [(WIDTH-1):0] Address,  //Directioning Address
   output reg [(WIDTH-1):0] WD,       //Write Data
   input reg  [(WIDTH-1):0] RD        //Read Data
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
  
//   resetArray();
   showArray();
   write_obj.writeData('h1111_FFFF, 'h00);
   write_obj.writeData('h1111_FFFF, 'h10);
//   writeArray();
//   showArray();
   saving('h12);
   showSaved();

end
 
task resetArray();
//import reset function from write class
automatic memory_array_T reset_mem = write_obj.reset;   

   MemWrite = 1;                           //Enable writing
   MemRead  = 0;

   for( byte i = 0; i<(1<<WIDTH)-1; i++)   //Reset all the 
     begin                                 //locations in
         Address <= i;                           //memory
         WD <= reset_mem.mem_data[i];
         @(posedge clk);
     end    
   
endtask


task writeArray();
//import writeMem function from write class
automatic memory_array_T written_mem = write_obj.writeMem;
//Read enable     
   MemWrite = 1;                           //Enable writing
   MemRead  = 0;
   for(byte i = 0; i<(1<<WIDTH)-1; i++)       
      begin                                //Update the value
         Address = i;                      //of all the
         WD = written_mem.mem_data[i];     //locations in memory
         @(posedge clk);
  
      end
endtask

task showArray();
$display("====================");
$display(" Memory Array Data  ");
$display("====================");
    
      MemWrite = 0;                    //Read enable
      MemRead  = 1; 
      WD = 'h1111_FFFF;

     for( byte i = 0; i<(1<<WIDTH)-1; i++)
     begin
         Address = i;                     //Displays the value 
         @(posedge clk);                  //of all loactions
         $display("0x%h - %h", i, RD);    //in memory
      end   

endtask 

task saving(bit [31:0] add);
      MemWrite = 0;                    //Read enable
      MemRead  = 1; 
   Address <= add; 
   @(posedge clk); 
   save_obj.saveData(RD, add);
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