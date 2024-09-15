class router_virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
  `uvm_component_utils(router_virtual_sequencer)
  
  router_wr_sequencer wr_seqrh[];
  router_rd_sequencer rd_seqrh[];
  router_env_config m_cfg;
  
  function new(string name="router_virtual_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.have you set() it?")
    wr_seqrh=new[m_cfg.no_of_write_agent];
    rd_seqrh=new[m_cfg.no_of_read_agent];
  endfunction
  
endclass:router_virtual_sequencer
