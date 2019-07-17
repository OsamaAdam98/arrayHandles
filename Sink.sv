package Sink;

  import Packet::*;

  class Sink;
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
        $display("Sink[%0d]: Received packet with field1 = (%0d)", id, stim_pkt.field1);  
      end  
    endtask
  endclass : Sink

endpackage