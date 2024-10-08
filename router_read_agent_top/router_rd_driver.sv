class router_rd_driver extends uvm_driver#(read_xtn);
  `uvm_component_utils(router_rd_driver)
  
  virtual router_if.RDR_MP vif;
  rd_agent_config m_cfg;
  
  function new(string name="router_rd_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db.have you set() it?")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif = m_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever 
      begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
  endtask
  
  task send_to_dut(read_xtn xtn);
    begin
      `uvm_info("ROUTER_RD_DRIVER",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
      @(vif.rdr_cb);
      wait(vif.rdr_cb.vld_out)
      repeat(xtn.no_of_cycles) @(vif.rdr_cb);
      vif.rdr_cb.read_enb <= 1;
      wait(!vif.rdr_cb.vld_out)
      vif.rdr_cb.read_enb <= 0;
      m_cfg.drv_data_count++;
      @(vif.rdr_cb);
    end
  endtask
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Report:router read driver sent %0d transactions",m_cfg.drv_data_count),UVM_LOW)
  endfunction
  
endclass : router_rd_driver
