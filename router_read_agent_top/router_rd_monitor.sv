class router_rd_monitor extends uvm_monitor;
  `uvm_component_utils(router_rd_monitor)
  
  virtual router_if.RMON_MP vif;
  rd_agent_config m_cfg;
  
  uvm_analysis_port#(read_xtn) monitor_port;
  
  function new(string name="router_rd_monitor",uvm_component parent);
    super.new(name,parent);
    monitor_port=new("monitor_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",m_cfg))
    `uvm_info("CONFIG","cannot get() m_cfg from uvm_config_db,have you set() it?",UVM_LOW)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif=m_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        collect_data();
      end
  endtask
  
  task collect_data();
    
    read_xtn mon_data;
    mon_data=read_xtn::type_id::create("mon_data");
    @(vif.rmon_cb)
    wait(vif.rmon_cb.read_enb)
    @(vif.rmon_cb);
    mon_data.header = vif.rmon_cb.data_out;
    mon_data.payload_data=new[mon_data.header[7:2]];
    @(vif.rmon_cb);
    foreach(mon_data.payload_data[i])
      begin
        mon_data.payload_data[i]=vif.rmon_cb.data_out;
        @(vif.rmon_cb);
      end
    mon_data.parity=vif.rmon_cb.data_out;
    @(vif.rmon_cb);
    `uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from monitor \n %s",mon_data.sprint()),UVM_LOW)
    
    m_cfg.mon_data_count++;
    monitor_port.write(mon_data);
    
  endtask

endclass : router_rd_monitor
