module traffic_light_ctrl(
   input wire clk,
   input wire reset,
   input wire tc,
   output reg red,
   output reg yellow,
   output reg green
);
reg [1:0] state;
localparam GREEN_STATE  = 2'b00;
localparam YELLOW_STATE = 2'b01;
localparam RED_STATE    = 2'b10;
reg [1:0] elapsed_ticks;
always @(posedge clk) begin
     if (reset) begin
            state        <= RED_STATE;
            elapsed_ticks <= 2'd0;
        end
        else if (tc) begin
            case (state)

                GREEN_STATE: begin
                    if (elapsed_ticks == 2'd2) begin
                        state         <= YELLOW_STATE;
                        elapsed_ticks <= 2'd0;
                    end
                    else begin
                        elapsed_ticks <= elapsed_ticks + 1'b1;
                    end
                end

                YELLOW_STATE: begin
                    state         <= RED_STATE;
                    elapsed_ticks <= 2'd0;
                end

                RED_STATE: begin
                    if (elapsed_ticks == 2'd1) begin
                        state         <= GREEN_STATE;
                        elapsed_ticks <= 2'd0;
                    end
                    else begin
                        elapsed_ticks <= elapsed_ticks + 1'b1;
                    end
                end

                default: begin
                    state         <= RED_STATE;
                    elapsed_ticks <= 2'd0;
                end

            endcase
        end
    end

    // Decode the current state into light outputs
    always @(*) begin
        red   = 1'b0;
        yellow = 1'b0;
        green = 1'b0;

        case (state)
            GREEN_STATE:  green  = 1'b1;
            YELLOW_STATE: yellow = 1'b1;
            RED_STATE:    red    = 1'b1;

            default: red = 1'b1;
        endcase
end
endmodule
