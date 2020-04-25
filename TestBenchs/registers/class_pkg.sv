package class_instr_pkg;

typedef struct
{
    int mem_data[0:(1<<5)-1];   //Create data type for 
}                               //memory data
memory_array_T;

class write_instr;
// Atributes
    memory_array_T mem;

// Methods
    function memory_array_T reset(); 
        foreach ( mem.mem_data[i] ) 
            begin
                mem.mem_data[i] = 'hffff_ffff;
            end
        return mem;
    endfunction : reset

    function void writeData(int data, bit [4:0] add);
        mem.mem_data[add] = data;
        return;
    endfunction : writeData

    function memory_array_T writeMem();
        return mem;
    endfunction : writeMem  
   

endclass : write_instr

class save_instr;

// Atributes
    memory_array_T mem;

// Methods
    function void saveData(int data, bit [4:0] add); 
        mem.mem_data[add] = data;
        return;     
    endfunction : saveData

    function memory_array_T savedMem();
        return mem;
    endfunction : savedMem  

endclass : save_instr



endpackage : class_instr_pkg

