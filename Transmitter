module transmitter (
    input        clk,
    input        wr_enb,
    input        rst,
    input  [7:0]  data_in,
    input        enb,          // baud tick / enable
    output reg   tx,
    output       busy
);

    // FSM states
    parameter idle_state  = 2'b00;
    parameter start_state = 2'b01;
    parameter data_state  = 2'b10;
    parameter stop_state  = 2'b11;

    reg [7:0] data;
    reg [2:0] index;
    reg [1:0] state;

    // State register + TX logic
    always @(posedge clk) begin

        if (rst) begin
            state <= idle_state;
            tx    <= 1'b1;
            data  <= 8'b0;
            index <= 3'b0;
        end

        else begin

            case (state)

                // ---------------- IDLE ----------------
                idle_state: begin
                    tx <= 1'b1;

                    if (wr_enb) begin
                        data  <= data_in;
                        index <= 3'b0;
                        state <= start_state;
                    end

                    else begin
                        state <= idle_state;
                    end
                end


                // ---------------- START ----------------
                start_state: begin

                    if (enb) begin
                        tx    <= 1'b0;       // Start bit
                        state <= data_state;
                    end

                    else begin
                        state <= start_state;
                    end
                end


                // ---------------- DATA ----------------
                data_state: begin

                    if (enb) begin

                        tx <= data[index];

                        if (index == 3'h7) begin
                            state <= stop_state;
                        end

                        else begin
                            index <= index + 3'h1;
                        end
                    end
                end


                // ---------------- STOP ----------------
                stop_state: begin

                    if (enb) begin
                        tx    <= 1'b1;       // Stop bit
                        state <= idle_state;
                    end

                    else begin
                        state <= stop_state;
                    end
                end


                // ---------------- DEFAULT ----------------
                default: begin
                    state <= idle_state;
                    tx    <= 1'b1;
                    data  <= 8'b0;
                    index <= 3'b0;
                end

            endcase
        end
    end

    // Busy = transmitter is not idle
    assign busy = (state != idle_state);

endmodule
