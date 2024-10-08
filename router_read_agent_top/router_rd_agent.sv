class router_rd_agent extends uvm_agent;
  `uvm_component_utils(router_rd_agent)
 rd_agent_config m_cfg;
  
  router_rd_monitor monh;
  router_rd_sequencer m_sequencer;
  router_rd_driver drvh;
  
  function new(string name="router_rd_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.Have you set() it?")
      
      monh=router_rd_monitor::type_id::create("monh",this);
    
    if(m_cfg.is_active==UVM_ACTIVE)
      begin
        drvh=router_rd_driver::type_id::create("drvh",this);
        m_sequencer=router_rd_sequencer::type_id::create("m_sequencer",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(m_cfg.is_active==UVM_ACTIVE)
      begin
        drvh.seq_item_port.connect(m_sequencer.seq_item_export);
      end
  endfunction
  
endclass:router_rd_agent
