package oop;

  class Packet;
    int field1; 

    function new(int i);
      field1 = i;
    endfunction   
  endclass : Packet

  class sink;
    mailbox #(Packet) in_chan; // null handle
    Packet stim_pkt;
    int id;

    function new(int i, mailbox #(Packet) mBox);
      id = i;
      this.in_chan = mBox;
    endfunction 

    task run();
      while(1) begin
        in_chan.get(stim_pkt);
        $display("sink[%0d]: Received packet with field1 = (%0d)", id, stim_pkt.field1);  
      end  
    endtask
  endclass : sink

  class source;
    mailbox #(Packet) out_chan[]; // null handle array
    Packet pkt_to_send;
    
    function new(int i, mailbox #(Packet) mBox);
      out_chan = new[i + 1];
      foreach(this.out_chan[i])
        this.out_chan[i] = mBox;
    endfunction 
    
    task run();
      //for(int i = 0; i <= 2; i++) begin
        for(int j = 0; j < out_chan.size(); j++) begin
          pkt_to_send = new(j);  
          out_chan[j].put(pkt_to_send);
          $display("source: Sent packet via channel %0d with field1 = (%0d)", j, pkt_to_send.field1);  
        end  
      //end
    endtask  
  endclass : source

endpackage : oop