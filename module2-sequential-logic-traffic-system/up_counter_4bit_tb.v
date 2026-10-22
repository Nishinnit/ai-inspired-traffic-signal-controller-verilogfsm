
`timescale 1ns/1ps

module traffic_counter_tb;

    reg clk;
    reg reset;
    reg enable;
    wire [3:0] count;

    // Instantiate the counter design
    traffic_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    // Generate a clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        enable = 0;

        // Keep reset active across rising clock edges
        #12;
        reset = 0;

        // Test counting with enable HIGH
        enable = 1;
        #100;

        // Test holding the count with enable LOW
        enable = 0;
        #30;

        // Enable counting again to test rollover
        enable = 1;
        #100;

        // Finish the simulation
        $stop;
    end

    // Display count whenever a relevant signal changes
    initial begin
        $monitor("Time=%0t | reset=%b | enable=%b | count=%0d (%b)",
                  $time, reset, enable, count, count);
    end

endmodule
