
`timescale 1ns/1ps

module mod10_counter_tb;

    reg clk;
    reg reset;
    reg enable;

    wire [3:0] count;
    wire tc;

    mod10_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .tc(tc)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;

        #12;
        reset = 0;
        enable = 1;

        // Count for 5 clock edges
        #45;
        enable = 0;

        // Check that count holds while disabled
        #30;
        enable = 1;

        // Continue counting through rollover
        #100;

        $stop;
    end

    initial begin
        $monitor(
            "Time=%0t | reset=%b | enable=%b | count=%0d | tc=%b",
            $time, reset, enable, count, tc
        );
    end

endmodule
