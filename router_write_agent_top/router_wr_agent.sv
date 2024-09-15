class router_wr_agent extends uvm_agent;
  `uvm_component_utils(router_wr_agent)
  
  wr_agent_config m_cfg;
  
  router_wr_monitor monh;
  router_wr_sequencer m_sequencer;
  router_wr_driver drvh;
  
  function new(string name="router_wr_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db,have you set() it?")
    monh=router_wr_monitor::type_id::create("monh",this);
    
    if(m_cfg.is_active==UVM_ACTIVE)
      begin
        drvh=router_wr_driver::type_id::create("drvh",this);
        m_sequencer=router_wr_sequencer::type_id::create("m_sequencer",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if (m_cfg.is_active==UVM_ACTIVE)
      begin
        drvh.seq_item_port.connect(m_sequencer.seq_item_export);
      end
  endfunction
  
endclass
