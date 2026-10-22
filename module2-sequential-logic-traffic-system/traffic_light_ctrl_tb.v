
`timescale 1ns/1ps

module traffic_light_ctrl_tb;

    reg clk;
    reg reset;
    reg tc;

    wire red;
    wire yellow;
    wire green;

    traffic_light_ctrl uut (
        .clk(clk),
        .reset(reset),
        .tc(tc),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    always #5 clk = ~clk;

    // Generate one tc pulse across one rising clock edge
    task send_tick;
        begin
            @(negedge clk);
            tc = 1'b1;

            @(negedge clk);
            tc = 1'b0;
        end
    endtask

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        tc = 1'b0;

        $monitor(
            "Time=%0t | tc=%b | RED=%b | YELLOW=%b | GREEN=%b",
            $time, tc, red, yellow, green
        );

        // Reset the controller
        #12;
        reset = 1'b0;

        // Initial RED lasts 2 timing ticks
        send_tick();
        send_tick();

        // GREEN lasts 3 timing ticks
        send_tick();
        send_tick();
        send_tick();

        // YELLOW lasts 1 timing tick
        send_tick();

        // RED lasts 2 timing ticks
        send_tick();
        send_tick();

        // Continue long enough to inspect the waveforms
        #10;
        $stop;
    end

endmodule
