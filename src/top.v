module tt_um_divisores (
    input  wire clk,
    input  wire rst,
    output wire div3_out,
    output wire div10_out
);

div3 u1 (
    .clk(clk),
    .rst(rst),
    .clk_out(div3_out)
);

div10 u2 (
    .clk(clk),
    .rst(rst),
    .clk_out(div10_out)
);

endmodule
