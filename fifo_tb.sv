`timescale 1ns/1ps

module fifo_tb.sv();

localparam DATA_WIDTH = 8;
localparam ADDR_WIDTH = 3; //The circular Queue FIFO Buffer has 2^3 = 8 Spaces With a DATA bit with of 8 bits each
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

initial
begin
    //-------------EMPTY---------------
    //Write
    @(negedge clk)
    w_data = 8'd5;
    wr = 1'b1;
    @(negedge clk);
    wr = 1'b0;


    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd8;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;


    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd12;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd2;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



     repeat(1) @(negedge clk)
    w_data = 8'd9;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;


    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd14;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd13;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



     //Write
    repeat(1) @(negedge clk)
    w_data = 8'd6;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



    //Write
    repeat(1) @(negedge clk)
    w_data = 8'd7;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;


    //------------------FULL-----------------

    //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

      //Read
    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(negedge clk)
    rd = 1'b0;

    //------------EMPTY------------------

    //Read and write at the same time

    repeat(1)@(negedge clk)
    w_data = 8'd17;
    wr = 1'b1;
    rd = 1'b1;
    @(nededge clk)
    wr = 1'b0;
    rd = 1'b0;


    //Read while empty

    repeat(1)@(negedge clk)
    rd = 1'b1;
    @(nededge clk)
    rd = 1'b0;


    //----------MAKE IT NOT EMPTY--------------

    repeat(1)@(negedge clk)
    w_data = 8'd12;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;


    repeat(1)@(negedge clk)
    w_data = 8'd4;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;



    repeat(1)@(negedge clk)
    w_data = 8'd23;
    wr = 1'b1;
    @(negedge clk)
    wr = 1'b0;


    //Read and Write at the same time
    repeat(1)@(negedge clk)
    w_data = 8'd11;
    wr = 1'b1;
    rd = 1'b1;
    @(negedge clk)
    wr = 1'b0;
    rd = 1'b0;

    repeat(3)@(negedge clk);
    $stop;
    
end

endmodule