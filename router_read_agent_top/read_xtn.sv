class read_xtn extends uvm_sequence_item;
  
  bit [7:0] header;
  bit [7:0] payload_data[];
  bit [7:0] parity;
  
  rand bit [5:0] no_of_cycles;
  `uvm_object_utils(read_xtn)
  
 
  constraint C1{soft no_of_cycles < 30;}
  
  function new(string name="read_xtn");
    super.new(name);
  endfunction
  
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("header",   this.header,   8,   UVM_HEX);
    foreach(payload_data[i])
      printer.print_field($sformatf("payload_data[%0d]",i),  this.payload_data[i],  8,   UVM_HEX);
    printer.print_field("parity",   this.parity,   8,   UVM_HEX);
    printer.print_field("No_Of_Cycles",   this.no_of_cycles,   6,   UVM_DEC);
  endfunction
   
endclass:read_xtn
