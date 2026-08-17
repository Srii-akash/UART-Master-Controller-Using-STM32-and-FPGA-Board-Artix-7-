`timescale 1ns / 1ps

module uart_top_tb;

    reg        clk;
    reg        rst;
    reg [7:0]  data_in;
    reg        wr_en;
    reg        rdy_clr;

    wire       rdy;
    wire       busy;
    wire [7:0] data_out;


    // =================================================
    // DUT
    // =================================================

    uart_top dut (
        .rst      (rst),
        .data_in  (data_in),
        .wr_en    (wr_en),
        .clk      (clk),
        .rdy_clr   (rdy_clr),
        .rdy      (rdy),
        .busy     (busy),
        .data_out (data_out)
    );


    // =================================================
    // 50 MHz clock
    // 20 ns period
    // =================================================

    always #10 clk = ~clk;


    // =================================================
    // Send one byte
    // =================================================

    task send_byte(input [7:0] din);
    begin
        @(negedge clk);

        data_in = din;
        wr_en   = 1'b1;

        @(negedge clk);

        wr_en = 1'b0;
    end
    endtask


    // =================================================
    // Clear receiver ready
    // =================================================

    task clear_ready;
    begin
        @(negedge clk);
        rdy_clr = 1'b1;

        @(negedge clk);
        rdy_clr = 1'b0;
    end
    endtask


    // =================================================
    // TEST
    // =================================================

    initial begin

        // Initial values
        clk     = 1'b0;
        rst     = 1'b1;
        data_in = 8'h00;
        wr_en   = 1'b0;
        rdy_clr = 1'b0;


        // Reset
        #100;
        rst = 1'b0;


        // =================================================
        // BYTE 1
        // =================================================

        $display("Sending 41...");

        send_byte(8'h41);

        wait(rdy == 1'b1);

        #1;

        if (data_out == 8'h41)
            $display("PASS: Received 41");
        else
            $display("FAIL: Expected 41, Received %h", data_out);

        clear_ready;


        // =================================================
        // BYTE 2
        // =================================================

        send_byte(8'h55);

        wait(rdy == 1'b1);

        #1;

        if (data_out == 8'h55)
            $display("PASS: Received 55");
        else
            $display("FAIL: Expected 55, Received %h", data_out);

        clear_ready;


        // Keep waveform visible
        #1000;

        $display("UART TEST COMPLETE");

        $finish;

    end

endmodule
