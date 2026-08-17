module uart_top (
    input        rst,
    input  [7:0] data_in,
    input        wr_en,
    input        clk,
    input        rdy_clr,

    output       rdy,
    output       busy,
    output [7:0] data_out
);

    // Baud-rate enable signals
    wire rx_clk_enb;
    wire tx_clk_enb;

    // Transmitter output
    wire tx_temp;


    // ------------------------------------------------
    // Baud Rate Generator
    // ------------------------------------------------

    baud_rate_generator bg (
        .clk     (clk),
        .rst     (rst),
        .tx_enb  (tx_clk_enb),
        .rx_enb  (rx_clk_enb)
    );


    // ------------------------------------------------
    // UART Transmitter
    // ------------------------------------------------

    transmitter trx (
        .clk     (clk),
        .wr_enb   (wr_en),
        .rst      (rst),
        .data_in  (data_in),
        .enb      (tx_clk_enb),
        .tx       (tx_temp),
        .busy     (busy)
    );


    // ------------------------------------------------
    // UART Receiver
    // ------------------------------------------------

    receiver rx (
        .clk       (clk),
        .rst       (rst),
        .rx        (tx_temp),
        .rdy_clr   (rdy_clr),
        .clk_en    (rx_clk_enb),
        .rdy       (rdy),
        .data_out  (data_out)
    );

endmodule
