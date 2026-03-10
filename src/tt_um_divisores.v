module tt_um_divisores (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire clk,
    input  wire rst_n,
    input  wire ena
);

wire div3_out;
wire div10_out;

div3 u1 (
    .clk(clk),
    .rst(~rst_n),
    .clk_out(div3_out)
);

div10 u2 (
    .clk(clk),
    .rst(~rst_n),
    .clk_out(div10_out)
);

assign uo_out[0] = div3_out;
assign uo_out[1] = div10_out;

assign uo_out[7:2] = 0;

assign uio_out = 0;
assign uio_oe  = 0;

endmodule
