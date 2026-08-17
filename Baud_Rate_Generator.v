`timescale 1ns / 1ps

module baud_rate_generator(
    input  clk,
    input rst,
    output tx_enb,
    output rx_enb
);

    // 50 MHz FPGA clock
    // TX baud rate = 9600
    // 50,000,000 / 9600 = 5208.33

    reg [12:0] tx_counter;

    // RX oversampling = 16x
    // 9600 * 16 = 153600
    // 50,000,000 / 153600 = 325.52

    reg [8:0] rx_counter;


    // ---------------- TX COUNTER ----------------
    always @(posedge clk) begin

        if (rst) begin
            tx_counter <= 13'd0;
        end

        else begin
            if (tx_counter == 13'd5207)
                tx_counter <= 13'd0;
            else
                tx_counter <= tx_counter + 1'b1;
        end

    end


    // ---------------- RX COUNTER ----------------
    always @(posedge clk) begin

        if (rst) begin
            rx_counter <= 9'd0;
        end

        else begin
            if (rx_counter == 9'd324)
                rx_counter <= 9'd0;
            else
                rx_counter <= rx_counter + 1'b1;
        end

    end


    // Enable pulses
    assign tx_enb = (tx_counter == 13'd0);

    assign rx_enb = (rx_counter == 9'd0);

endmodule
