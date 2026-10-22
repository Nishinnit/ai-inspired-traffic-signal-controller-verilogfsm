
module pedestrian_signal (
    input wire clk,
    input wire reset,
    input wire btn_press,

    output reg walk_signal,
    output reg dont_walk,
    output reg [3:0] countdown
);

reg [1:0] state;

localparam IDLE      = 2'b00;
localparam WALK      = 2'b01;
localparam DONT_WALK = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state       <= IDLE;
        countdown   <= 4'd0;
        walk_signal <= 1'b0;
        dont_walk   <= 1'b1;
    end
    else begin
        case (state)

            IDLE: begin
                walk_signal <= 1'b0;
                dont_walk   <= 1'b1;

                if (btn_press) begin
                    state       <= WALK;
                    countdown   <= 4'd10;
                    walk_signal <= 1'b1;
                    dont_walk   <= 1'b0;
                end
                else begin
                    countdown <= 4'd0;
                end
            end

            WALK: begin
                walk_signal <= 1'b1;
                dont_walk   <= 1'b0;

                if (countdown > 4'd1) begin
                    countdown <= countdown - 1'b1;
                end
                else begin
                    state       <= DONT_WALK;
                    countdown   <= 4'd5;
                    walk_signal <= 1'b0;
                    dont_walk   <= 1'b1;
                end
            end

            DONT_WALK: begin
                walk_signal <= 1'b0;
                dont_walk   <= 1'b1;

                if (countdown > 4'd1) begin
                    countdown <= countdown - 1'b1;
                end
                else begin
                    state       <= WALK;
                    countdown   <= 4'd10;
                    walk_signal <= 1'b1;
                    dont_walk   <= 1'b0;
                end
            end

            default: begin
                state       <= IDLE;
                countdown   <= 4'd0;
                walk_signal <= 1'b0;
                dont_walk   <= 1'b1;
            end

        endcase
    end
end

endmodule
