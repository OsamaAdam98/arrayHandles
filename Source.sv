package Source;

  import Packet::*;

  class Source;
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
          $display("Source: Sent packet via channel %0d with field1 = (%0d)", j, pkt_to_send.field1);  
        end  
      //end
    endtask  
  endclass : Source

endpackage