module receiver (
    input        clk,
    input        rst,
    input        rx,
    input        rdy_clr,
    input        clk_en,

    output reg       rdy,
    output reg [7:0] data_out
);

    // FSM states
    parameter start_state = 2'b00;
    parameter data_state  = 2'b01;
    parameter stop_state  = 2'b10;

    // Internal variables
    reg [1:0] state;

    // 16x oversampling counter
    reg [3:0] sample;

    // Data bit counter
    reg [2:0] index;

    // Temporary received data
    reg [7:0] temp_register;


    always @(posedge clk) begin

        // ---------------- RESET ----------------
        if (rst) begin
            state         <= start_state;
            sample        <= 4'd0;
            index         <= 3'd0;
            temp_register <= 8'd0;
            data_out      <= 8'd0;
            rdy           <= 1'b0;
        end

        else begin

            // Clear ready flag
            if (rdy_clr)
                rdy <= 1'b0;


            // Baud/oversampling enable
            if (clk_en) begin

                case (state)

                    // ---------------- START ----------------
                    start_state: begin

                        // Waiting for start bit
                        if (rx == 1'b0) begin

                            if (sample == 4'd15) begin

                                // Start bit confirmed
                                state         <= data_state;
                                sample        <= 4'd0;
                                index         <= 3'd0;
                                temp_register <= 8'd0;

                            end

                            else begin
                                sample <= sample + 1'b1;
                            end
                        end

                        else begin
                            // RX returned high, false start
                            sample <= 4'd0;
                        end

                    end


                    // ---------------- DATA ----------------
                    data_state: begin

                        if (sample == 4'd15) begin

                            // Sample data bit
                            temp_register[index] <= rx;

                            sample <= 4'd0;

                            if (index == 3'd7) begin
                                state <= stop_state;
                            end

                            else begin
                                index <= index + 1'b1;
                            end

                        end

                        else begin
                            sample <= sample + 1'b1;
                        end

                    end


                    // ---------------- STOP ----------------
                    stop_state: begin

                        if (sample == 4'd15) begin

                            // Stop bit should be HIGH
                            if (rx == 1'b1) begin
                                data_out <= temp_register;
                                rdy      <= 1'b1;
                            end

                            state  <= start_state;
                            sample <= 4'd0;
                            index  <= 3'd0;

                        end

                        else begin
                            sample <= sample + 1'b1;
                        end

                    end


                    // ---------------- DEFAULT ----------------
                    default: begin
                        state  <= start_state;
                        sample <= 4'd0;
                        index  <= 3'd0;
                    end

                endcase
            end
        end
    end

endmodule
