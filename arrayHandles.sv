module array_handles;

    import oop::*;

    sink snk[];
    source src[];
    mailbox #(Packet)  src2snk[];

    initial begin
        snk = new[5];
        src = new[5];
        src2snk = new[5];

        for(int i = 0; i < 5; i++) begin
            src2snk[i] = new();
            snk[i] = new(i, src2snk[i]);
            src[i] = new(i, src2snk[i]);
            //$display("Created number %0d", i);
        end

        fork
            src[0].run();
            snk[0].run();
            src[1].run();
            snk[1].run();
            src[2].run();
            snk[2].run();
            src[3].run();
            snk[3].run();
            src[4].run();
            snk[4].run();
        join_none
        #0
        $display("Finished");
    end

    
endmodule : array_handles