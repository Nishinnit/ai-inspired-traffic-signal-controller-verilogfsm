
`timescale 1ns/1ps

module pedestrian_signal_tb;

    reg clk;
    reg reset;
    reg btn_press;

    wire walk_signal;
    wire dont_walk;
    wire [3:0] countdown;

    pedestrian_signal uut (
        .clk(clk),
        .reset(reset),
        .btn_press(btn_press),
        .walk_signal(walk_signal),
        .dont_walk(dont_walk),
        .countdown(countdown)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        btn_press = 0;

        $monitor(
            "Time=%0t | Reset=%b | Button=%b | WALK=%b | DONT_WALK=%b | Countdown=%0d",
            $time, reset, btn_press,
            walk_signal, dont_walk, countdown
        );

       
        #12;
        reset = 0;

        
        #8;
        btn_press = 1;

       
        #10;
        btn_press = 0;

        
        #250;

        $finish;
    end

endmodule
