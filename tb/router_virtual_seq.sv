class router_vbase_seq extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(router_vbase_seq)
  
  router_wr_sequencer wr_seqrh[];
  router_rd_sequencer rd_seqrh[];
  
  router_virtual_sequencer vsqrh;
  router_env_config  m_cfg;
  
  function new(string name="router_vbase_seq");
    super.new(name);
  endfunction
  
 task body();
    if(!uvm_config_db#(router_env_config)::get(null,get_full_name(),"router_env_config",m_cfg)) 
      
       `uvm_fatal(get_type_name(),"cannot get() m_cfg from uvm_config_db. Have you set() it?")
       
       wr_seqrh=new[m_cfg.no_of_write_agent];
       rd_seqrh=new[m_cfg.no_of_read_agent];
  
       
    assert($cast(vsqrh,m_sequencer))
      else
        begin
      	`uvm_error("Body","Error in $cast of virtual sequencer")
        end
     foreach(wr_seqrh[i])
        wr_seqrh[i]=vsqrh.wr_seqrh[i];
     foreach(rd_seqrh[i])
        rd_seqrh[i]=vsqrh.rd_seqrh[i];
  endtask
endclass:router_vbase_seq
  
 // small pkt vseq
class router_small_pkt_vseq extends router_vbase_seq;
  `uvm_object_utils(router_small_pkt_vseq)
  bit[1:0]addr;
  
  router_wxtns_small_pkt wrtns;
  router_rxtns1  rdtns;
  
  function new(string name="router_small_pkt_vseq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"getting the configuration fails,check if it set properly")
 
    if(m_cfg.has_wagent)
      begin
        `uvm_info("V_SEQ",$sformatf("has_wagent=%d",m_cfg.has_wagent),UVM_LOW)
        wrtns=router_wxtns_small_pkt::type_id::create("wrtns");
      end
    
  if(m_cfg.has_ragent)
    begin
	`uvm_info("V_SEQ",$sformatf("has_ragent=%d",m_cfg.has_ragent),UVM_LOW)
      rdtns=router_rxtns1::type_id::create("rdtns");
    end
  
  fork 
    begin
      wrtns.start(wr_seqrh[0]);
    end
    
    begin
      if(addr==2'b00)
        rdtns.start(rd_seqrh[0]);
      if(addr==2'b01)
        rdtns.start(rd_seqrh[1]);
      if(addr==2'b10)
        rdtns.start(rd_seqrh[2]);
    end
  join
  endtask
endclass:router_small_pkt_vseq
       
       
 
 // medium pkt vseq
class router_medium_pkt_vseq extends router_vbase_seq;
  `uvm_object_utils(router_medium_pkt_vseq)
  bit[1:0]addr;
  
  router_wxtns_medium_pkt wrtns;
  router_rxtns1  rdtns;
  
  function new(string name="router_medium_pkt_vseq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"getting the configuration fails,check if it set properly")
    
    if(m_cfg.has_wagent)
      begin
	`uvm_info("V_SEQ",$sformatf("has_wagent=%d",m_cfg.has_wagent),UVM_LOW)
        wrtns=router_wxtns_medium_pkt::type_id::create("wrtns");
      end
    
  if(m_cfg.has_ragent)
    begin
	`uvm_info("V_SEQ",$sformatf("has_ragent=%d",m_cfg.has_ragent),UVM_LOW)
    rdtns=router_rxtns1::type_id::create("rdtns");
  end
  
  fork 
    begin
      wrtns.start(wr_seqrh[0]);
    end
    
    begin
      if(addr==2'b00)
        rdtns.start(rd_seqrh[0]);
      if(addr==2'b01)
        rdtns.start(rd_seqrh[1]);
      if(addr==2'b10)
        rdtns.start(rd_seqrh[2]);
    end
  join
  endtask
endclass:router_medium_pkt_vseq
       
//big packet
       
class router_big_pkt_vseq extends router_vbase_seq;
  `uvm_object_utils(router_big_pkt_vseq)
  bit[1:0]addr;
  
  router_wxtns_big_pkt wrtns;
  router_rxtns1  rdtns;
  
  function new(string name="router_big_pkt_vseq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
  if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"getting the configuration fails,check if it set properly")
    
    if(m_cfg.has_wagent)
      begin
	`uvm_info("V_SEQ",$sformatf("has_wagent=%d",m_cfg.has_wagent),UVM_LOW)
        wrtns=router_wxtns_big_pkt::type_id::create("wrtns");
      end
    
  if(m_cfg.has_ragent)
    begin
	`uvm_info("V_SEQ",$sformatf("has_ragent=%d",m_cfg.has_ragent),UVM_LOW)
    rdtns=router_rxtns1::type_id::create("rdtns");
  end
  
  fork 
    begin
      wrtns.start(wr_seqrh[0]);
    end
    
    begin
      if(addr==2'b00)
        rdtns.start(rd_seqrh[0]);
      if(addr==2'b01)
        rdtns.start(rd_seqrh[1]);
      if(addr==2'b10)
        rdtns.start(rd_seqrh[2]);
    end
  join
  endtask
endclass:router_big_pkt_vseq
       
//Random test
       
class router_rndm_pkt_vseq extends router_vbase_seq;
  `uvm_object_utils(router_rndm_pkt_vseq)
  bit[1:0]addr;
  
  router_wxtns_rndm_pkt wrtns;
  router_rxtns1  rdtns;
  
  function new(string name="router_rndm_pkt_vseq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"getting the configuration fails,check if it set properly")
    
    if(m_cfg.has_wagent)
      begin
	`uvm_info("V_SEQ",$sformatf("has_wagent=%d",m_cfg.has_wagent),UVM_LOW)
        wrtns=router_wxtns_rndm_pkt::type_id::create("wrtns");
      end
    
  if(m_cfg.has_ragent)
    begin
	`uvm_info("V_SEQ",$sformatf("has_ragent=%d",m_cfg.has_ragent),UVM_LOW)
    rdtns=router_rxtns1::type_id::create("rdtns");
  end
  
  fork 
    begin
      wrtns.start(wr_seqrh[0]);
    end
    
    begin
      if(addr==2'b00)
        rdtns.start(rd_seqrh[0]);
      if(addr==2'b01)
        rdtns.start(rd_seqrh[1]);
      if(addr==2'b10)
        rdtns.start(rd_seqrh[2]);
    end
  join
  endtask
endclass:router_rndm_pkt_vseq

