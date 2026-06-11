module sync_fifo (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] data_in,

    output reg [7:0] data_out,
    output full,
    output empty
);

    // FIFO Memory
    reg [7:0] fifo_mem [0:15];

    // Read and Write Pointers
    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;

    // Counter
    reg [4:0] count;

    // Full and Empty Flags
    assign full  = (count == 16);
    assign empty = (count == 0);

    // Main FIFO Logic
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            wr_ptr   <= 4'd0;
            rd_ptr   <= 4'd0;
            count    <= 5'd0;
            data_out <= 8'd0;
        end

        else
        begin

            // Write Operation
            if (wr_en && !full)
            begin
                fifo_mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end

            // Read Operation
            if (rd_en && !empty)
            begin
                data_out <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end

        end
    end

endmodule