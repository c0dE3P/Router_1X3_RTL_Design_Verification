class rd_agent_config extends uvm_object;
 `uvm_object_utils(rd_agent_config)
  
  virtual router_if vif;
  static int drv_data_count = 0;
  static int mon_data_count = 0;
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  function new (string name="rd_agent_config");
    super.new(name);
  endfunction
  
endclass:rd_agent_config
