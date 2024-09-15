class router_wr_sequencer extends uvm_sequencer#(write_xtn);
  `uvm_component_utils(router_wr_sequencer)
  
  function new(string name="router_wr_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
