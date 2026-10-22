module mod10_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [3:0] count,
    output wire tc
);
assign tc = (count == 4'd9);
always @(posedge clk) begin
    if (reset) begin
        count<=4'b0000;
    end
    else if (enable) begin
    if (count == 4'd9) begin
        count <= 4'd0;
    end
    else begin
        count <= count + 1'b1;
    end
end
end
endmodule
