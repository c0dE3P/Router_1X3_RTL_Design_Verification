class write_xtn extends uvm_sequence_item;
  
  rand bit [7:0] header;
  rand bit [7:0] payload_data[];
  bit      [7:0] parity;
  bit            busy;
  bit            err;
  
  
  `uvm_object_utils(write_xtn)
  	

  function void post_randomize();
    
    // parity = 0^header;
    
    foreach (payload_data[i])
      parity = payload_data[i]^parity;
 
  endfunction:post_randomize
  
  constraint INVALID_ADDR {header[1:0] != 3;}
  constraint DATA_IN_SIZE {payload_data.size == header[7:2];}
  constraint INVALID_DATA_LEN {header[7:2] != 0;}
  
  function new(string name="write_xtn");
    super.new(name);
  endfunction
    
endclass :write_xtn


class bad_xtn extends write_xtn;
  `uvm_object_utils(bad_xtn)
  
  function new(string name="bad_xtn");
    super.new(name);
  endfunction
  
  function void post_randomize();
    parity=$random;
  endfunction
endclass:bad_xtn
  
