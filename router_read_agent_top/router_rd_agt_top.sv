class router_rd_agt_top extends uvm_env;
  `uvm_component_utils(router_rd_agt_top)
  
  router_rd_agent agnth[];
  router_env_config m_cfg;
  
  function new(string name="router_rd_agt_top",uvm_component parent);
    super.new(name,parent);
  endfunction
  
function void  build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",m_cfg))
  `uvm_fatal(get_type_name,"ENV:Write error")
      
      agnth=new[m_cfg.no_of_read_agent];
    
    foreach(agnth[i])
      begin
        agnth[i]=router_rd_agent::type_id::create($sformatf("agnth[%0d]",i),this);
        uvm_config_db #(rd_agent_config)::set(this,$sformatf("agnth[%0d]*",i),"rd_agent_config",m_cfg.rd_agt_cfg[i]);
                                                            
      end
endfunction: build_phase
endclass:router_rd_agt_top                                             
                                                  
