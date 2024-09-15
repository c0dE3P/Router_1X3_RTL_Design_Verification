interface router_if(input bit clock);
logic [7:0] data_in;
  logic [7:0] data_out;
  logic       rst;
  logic       error;
  logic       busy;
  logic       read_enb;
  logic       vld_out;
  logic       pkt_valid;
  
  //WRDR clocking block
  
  clocking wdr_cb @(posedge clock);
    default input #1 output #1;
    
    output data_in;
    output pkt_valid;
    output rst;
    input  error;
    input  busy;
  endclocking
  
  // RDDR clocking block
  
  clocking rdr_cb @(posedge clock);
    default input #1 output #1;
    
    output read_enb;
    input  vld_out;
  endclocking
  
  //write monitor clocking block
  
  clocking wmon_cb @(posedge clock);
    default input #1 output #1;
    
    input data_in;
    input pkt_valid;
    input error;
    input busy;
    input rst;
  endclocking
  
  //read monitor clocking block
  
  clocking rmon_cb @(posedge clock);
    default input #1 output #1;
    
    input data_out;
    input read_enb;
  endclocking
  
  modport WDR_MP (clocking wdr_cb);
  modport RDR_MP (clocking rdr_cb);
  modport WMON_MP(clocking wmon_cb);
  modport RMON_MP(clocking rmon_cb);
endinterface
    
