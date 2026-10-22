`timescale 1ns/1ps

module traffic_system_top_tb;

reg clk;
    reg reset;

wire red;
    wire yellow;
    wire green;

traffic_system_top uut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

// 10 ns clock period
    always #5 clk = ~clk;

initial begin
        clk = 1'b0;
        reset = 1'b1;

$monitor(
            "Time=%0t | RED=%b | YELLOW=%b | GREEN=%b",
            $time, red, yellow, green
        );

// Keep reset active, then release it
        #22;
        reset = 1'b0;

// Run long enough to observe multiple light transitions
        #1000;
        $stop;
    end

endmodule
