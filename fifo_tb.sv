`timescale 1ns/1ps

module fifo_tb.sv();

localparam DATA_WIDTH = 8;
localparam ADDR_WIDTH = 3;
localparam T = 10; //Clock period

logic clk, reset;
logic wr, rd;
logic [DATA_WIDTH-1:0] w_data, r_data;
logic full, empty;

//10ns clock running forever
always
begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
end

//reset for the first half cycle
initial
begin
    reset = 1'b1;
    rd = 1'b0;
    wr = 1'b0;
    @(negedge clk)
    reset = 1'b0;
end

//generate test vectors

endmodule