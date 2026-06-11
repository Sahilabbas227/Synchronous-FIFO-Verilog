`timescale 1ns/1ps

module sync_fifo_tb;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] data_in;

    wire [7:0] data_out;
    wire full;
    wire empty;

    sync_fifo uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        #10 rst = 0;

        // Write data
        #10 wr_en = 1; data_in = 8'h11;
        #10 data_in = 8'h22;
        #10 data_in = 8'h33;
        #10 data_in = 8'h44;

        #10 wr_en = 0;

        // Read data
        #10 rd_en = 1;

        #40 rd_en = 0;

        #20 $finish;
    end

endmodule