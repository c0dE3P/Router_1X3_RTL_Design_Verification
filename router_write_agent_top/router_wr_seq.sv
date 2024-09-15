//base sequence class
class router_wr_seq extends uvm_sequence #(write_xtn);
  `uvm_object_utils(router_wr_seq)
  
  function new(string name ="router_wr_seq");
    super.new(name);
  endfunction
  
endclass :router_wr_seq

//small pkt

class router_wxtns_small_pkt extends router_wr_seq;
  `uvm_object_utils(router_wxtns_small_pkt)
  
  bit[1:0]addr;
  function new(string name = "router_wxtns_small_pkt");
    super.new(name);
  endfunction
  
  task body();
    
    if (!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile,check if it set properly")
      
    req = write_xtn::type_id::create("req");
    start_item(req);
    
    assert(req.randomize() with {header[7:2] inside {[1:15]} && header[1:0]==addr;});
    
    `uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
    finish_item(req);
 
endtask
  
endclass : router_wxtns_small_pkt

//medium pkt

class router_wxtns_medium_pkt extends router_wr_seq;
  `uvm_object_utils(router_wxtns_medium_pkt)
  
  bit[1:0]addr;
  function new(string name ="router_wxtns_medium_pkt");
    super.new(name);
  endfunction
  
  task body();
    
    if (!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile,check if it set properly")
      
    req = write_xtn::type_id::create("req");
    start_item(req);
    
    assert(req.randomize() with {header[7:2] inside {[16:30]} && header[1:0]==addr;});
    
    `uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
    finish_item(req);
 
endtask
  
endclass : router_wxtns_medium_pkt

//big pkt

class router_wxtns_big_pkt extends router_wr_seq;
  `uvm_object_utils(router_wxtns_big_pkt)
  
  bit[1:0]addr;
  function new(string name="router_wxtns_big_pkt");
    super.new(name);
  endfunction
  
  task body();
    
    if (!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile,check if it set properly")
      
    req = write_xtn::type_id::create("req");
    start_item(req);
    
    assert(req.randomize() with {header[7:2] inside {[1:15]} && header[1:0]==addr;});
    
    `uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
    finish_item(req);
 
endtask
  
endclass : router_wxtns_big_pkt

//random pkt

class router_wxtns_rndm_pkt extends router_wr_seq;
  `uvm_object_utils(router_wxtns_rndm_pkt)
  
  bit[1:0]addr;
  function new(string name="router_wxtns_rndm_pkt");
    super.new(name);
  endfunction
  
  task body();
    
    if (!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration file,check if it set properly")
      
    req = write_xtn::type_id::create("req");
    start_item(req);  
    assert(req.randomize() with {header[1:0]==addr;});
    
    `uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
    finish_item(req);
 
endtask
  
endclass : router_wxtns_rndm_pkt


