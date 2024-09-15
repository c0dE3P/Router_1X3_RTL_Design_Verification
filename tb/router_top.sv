module top;
  
 	import router_pkg::*;
	import uvm_pkg::*;
/*`include "uvm_macros.svh"
`include "router_if.sv"

`include "write_xtn.sv"
`include "wr_agent_config.sv"
`include "rd_agent_config.sv"
`include "router_env_config.sv"
`include "router_wr_driver.sv"
`include "router_wr_monitor.sv" 
`include "router_wr_sequencer.sv" 
`include "router_wr_agent.sv"  
`include "router_wr_agt_top.sv" 
`include "router_wr_seq.sv" 


`include "read_xtn.sv"
`include "router_rd_driver.sv"
`include "router_rd_monitor.sv"
`include "router_rd_sequencer.sv"
`include "router_rd_agent.sv"  
`include "router_rd_agt_top.sv"  
`include "router_rd_seq.sv"


`include "router_virtual_sequencer.sv" 
`include "router_virtual_seq.sv"  
`include "router_scoreboard.sv"
`include "router_env.sv"
`include "router_test.sv"*/

  
  bit clock;
  
  initial begin
    forever #10 clock =~clock;
  end
  
  router_if in(clock);
  router_if in0(clock);
  router_if in1(clock);
  router_if in2(clock);
  
  router_top DUV(.clock(clock),
                 .resetn(in.rst),
                 .pkt_valid(in.pkt_valid),
                 .data_in(in.data_in),
                 .read_enb_0(in0.read_enb),
                 .read_enb_1(in1.read_enb),
                 .read_enb_2(in2.read_enb),
                 .data_out_0(in0.data_out),
                 .data_out_1(in1.data_out),
                 .data_out_2(in2.data_out),
                 .vld_out_0(in0.vld_out),
                 .vld_out_1(in1.vld_out),
                 .vld_out_2(in2.vld_out),
                 .busy(in.busy),
                 .error(in.error)
                );
  initial
    begin
    
      uvm_config_db#(virtual router_if)::set(null,"*","vif",in);
      uvm_config_db#(virtual router_if)::set(null,"*","vif_0",in0);
      uvm_config_db#(virtual router_if)::set(null,"*","vif_1",in1);
      uvm_config_db#(virtual router_if)::set(null,"*","vif_2",in2);
      
      run_test("router_test");
    end
  
 property pkt_vld;
   @(posedge clock)
   $rose(in.pkt_valid) |=> in.busy;
 endproperty
  
  A1:assert property(pkt_vld);
  
  property stable;
    @(posedge clock)
    in.busy |=> $stable(in.data_in);
  endproperty
  
  A2:assert property(stable);
    
 property read1;
   @(posedge clock)
   $rose(in1.vld_out) |=> ##[0:29] in1.read_enb;
 endproperty
  
 R1:assert property(read1);
  
 property read2;
    @(posedge clock)
    $rose(in2.vld_out) |=> ##[0:29] in2.read_enb;
 endproperty
 R2:assert property(read2);
   
  property read0;
    @(posedge clock)
    $rose(in0.vld_out) |=> ##[0:29] in0.read_enb;
 endproperty
   R3:assert property(read0);
     
  property valid1;
    bit[1:0]addr;
    @(posedge clock)
    ($rose(in.pkt_valid),addr=in.data_in[1:0]) ##3(addr==0) |->in0.vld_out;
  endproperty
     
  property valid2;
    bit[1:0]addr;
    @(posedge clock)
    ($rose(in.pkt_valid),addr=in.data_in[1:0]) ##3(addr==0) |->in1.vld_out;
  endproperty
     
  property valid3;
    bit[1:0]addr;
    @(posedge clock)
    ($rose(in.pkt_valid),addr=in.data_in[1:0]) ##3(addr==0) |->in2.vld_out;
  endproperty
     
  property valid;
    @(posedge clock)
    $rose(in.pkt_valid) |-> ##3 in0.vld_out | in2.vld_out |in1.vld_out;
  endproperty
     
     V:assert property(valid);
     V1:assert property(valid1);
     V2:assert property(valid2);
     V3:assert property(valid3);
       
   property read_1;
     bit[1:0]addr;
     @(posedge clock)
     (in1.vld_out) ##1 !in1.vld_out |=>$fell(in1.read_enb);
   endproperty
       
  property read_2;
    bit[1:0]addr;
    @(posedge clock)
    (in2.vld_out) ##1 !in2.vld_out |=>$fell(in2.read_enb);
  endproperty
       
  property read_3;
    bit[1:0]addr;
    @(posedge clock)
    (in0.vld_out) ##1 !in0.vld_out |=>$fell(in0.read_enb);
  endproperty
         
  RR1:assert property(read_1);  
  RR2:assert property(read_2);
  RR3:assert property(read_3);
     
  /*initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(top);
    end*/
  
endmodule
