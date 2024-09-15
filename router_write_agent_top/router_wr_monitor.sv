class router_wr_monitor extends uvm_monitor;
  `uvm_component_utils(router_wr_monitor)
  
  virtual router_if.WMON_MP vif;
  wr_agent_config m_cfg;
  
  uvm_analysis_port #(write_xtn) monitor_port;
  
  function new(string name="router_wr_monitor",uvm_component parent);
    super.new(name,parent);
    monitor_port = new("monitor_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.have you set() it?")
  endfunction
    
  function void connect_phase(uvm_phase phase);
    vif = m_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever 
        collect_data();
  endtask
   
  task collect_data();
    
    write_xtn mon_data;
    begin
      mon_data = write_xtn::type_id::create("mon_data");
      @(vif.wmon_cb);
      wait(!vif.wmon_cb.busy && vif.wmon_cb.pkt_valid)
      
      mon_data.header = vif.wmon_cb.data_in;
      mon_data.payload_data = new[mon_data.header[7:2]];
      @(vif.wmon_cb);
      foreach(mon_data.payload_data[i])
        begin
          wait(!vif.wmon_cb.busy)
          mon_data.payload_data[i]=vif.wmon_cb.data_in;
          @(vif.wmon_cb);
        end
      
      wait(!vif.wmon_cb.pkt_valid && !vif.wmon_cb.busy)
      
      mon_data.parity = vif.wmon_cb.data_in;
      repeat(2) @(vif.wmon_cb);
      mon_data.busy = vif.wmon_cb.busy;
      mon_data.err=vif.wmon_cb.error;
      m_cfg.mon_data_count++;
      
      `uvm_info("ROUTER_WR_MONITOR",$sformatf("printing from monitor \n %s",mon_data.sprint()),UVM_LOW)
      monitor_port.write(mon_data);
    end
  endtask
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Report : router write monitor collected transaction %0d",m_cfg.mon_data_count),UVM_LOW)
  endfunction
  
endclass: router_wr_monitor
