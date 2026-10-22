
module traffic_system_top (
    input wire clk,
    input wire reset,
    output wire red,
    output wire yellow,
    output wire green
);

    wire [3:0] count;
    wire tc;

    // Modulo-10 timer counter
    mod10_counter timer (
    .clk(clk),
    .reset(reset),
    .enable(1'b1),
    .count(count),
    .tc(tc)
);

    // Traffic-light controller
    traffic_light_ctrl controller (
        .clk(clk),
        .reset(reset),
        .tc(tc),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

endmodule
