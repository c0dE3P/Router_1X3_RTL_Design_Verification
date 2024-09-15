class router_wr_driver extends uvm_driver #(write_xtn);
  `uvm_component_utils(router_wr_driver)
  
  virtual router_if.WDR_MP vif;
  wr_agent_config m_cfg;
  
  function new(string name="router_wr_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.have you set() it?")
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    vif = m_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    
    @(vif.wdr_cb);
    vif.wdr_cb.rst <= 0;
    @(vif.wdr_cb);
    vif.wdr_cb.rst <= 1;
    forever
      begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
  endtask
  
  task send_to_dut(write_xtn xtn);
   `uvm_info("ROUTER_WR_DRIVER",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
    @(vif.wdr_cb);
    wait(!vif.wdr_cb.busy)
    vif.wdr_cb.pkt_valid <= 1;
    vif.wdr_cb.data_in <= xtn.header;
    @(vif.wdr_cb);
    foreach(xtn.payload_data[i])
      begin
        wait(!vif.wdr_cb.busy)
        vif.wdr_cb.data_in <= xtn.payload_data[i];
        @(vif.wdr_cb);
      end
    wait(!vif.wdr_cb.busy)
    vif.wdr_cb.pkt_valid<=0;
    vif.wdr_cb.data_in <= xtn.parity;
    repeat(2)@(vif.wdr_cb);
    m_cfg.drv_data_count++;  
  endtask
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Report: router write driver sent %d transactions",m_cfg.drv_data_count),UVM_LOW)
  endfunction
  
  
endclass :router_wr_driver
