class router_rd_seq extends uvm_sequence#(read_xtn);
  `uvm_object_utils(router_rd_seq)
  
  function new(string name="router_rd_seq");
    super.new(name);
  endfunction
  
  
endclass:router_rd_seq

class router_rxtns1 extends router_rd_seq;
  `uvm_object_utils(router_rxtns1)
  
  function new(string name="router_rxtns1");
    super.new(name);
  endfunction
  
  task body();
    req = read_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {no_of_cycles inside {[1:29]};});
    `uvm_info("router_rd_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_LOW)
    
    finish_item(req);
    `uvm_info(get_type_name(),"AFTER FINISH ITEM INSIDE SEQUENCE",UVM_HIGH)
  endtask
endclass:router_rxtns1

class router_rxtns2 extends router_rd_seq;
  `uvm_object_utils(router_rxtns2)
  
  function new(string name="router_rxtns2");
    super.new(name);
  endfunction
  
  task body();
    req = read_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {no_of_cycles inside {[30:40]};});
    `uvm_info("router_rd_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_LOW)
    
    finish_item(req);
  endtask
  
endclass:router_rxtns2
