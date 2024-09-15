class router_env_config extends uvm_object;
 `uvm_object_utils(router_env_config)
  
  bit has_wagent  = 1;
  bit has_ragent = 1;
  int no_of_write_agent = 1;
  int no_of_read_agent = 3;
  bit has_virtual_sequencer = 1;
  bit has_scoreboard = 1;
  
  wr_agent_config wr_agt_cfg[];
  rd_agent_config rd_agt_cfg[];
  
  function new (string name="router_env_config");
    super.new(name);
  endfunction
endclass : router_env_config
