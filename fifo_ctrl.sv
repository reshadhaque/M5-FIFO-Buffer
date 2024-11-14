//The FIFO Controller does not deal with the data, it only controlls the address because it used pointers
//It does not matter what data you put in it

module fifo_ctrl#(parameter ADDR_WIDTH = 3)(
    input logic clk, reset,
    input logic wr, rd,
    output logic full, empty,
    output logic [ADDR_WIDTH-1:0] w_addr,
    output logic [ADDR_WIDTH-1:0] r_addr
);

logic [ADDR_WIDTH-1:0] wr_ptr, wr_ptr_next;
logic [ADDR_WIDTH-1:0] rd_ptr, rd_ptr_next;

logic full_next;
logic empty_next;

    //FIFO Buffer Controller

    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
            begin
                wr_ptr<=0;
                rd_ptr<=0;
                full<=1'b0;
                empty<=1'b1;
            end
        else
            begin
                wr_ptr<=wr_ptr_next;
                rd_ptr<=rd_ptr_next;
                full <= full_next;
                empty<=empty_next;
            end
    end

    //State logic
    always_comb
    begin
    //defaults
    wr_ptr_next = wr_ptr;
    rd_ptr_next = rd_ptr;
    full_next = full;
    empty_next = empty;

        case({wr, rd})
            2'b01: //read case
            begin
                if(~empty)
                begin
                    rd_ptr_next = rd_ptr + 1;
                    full_next = 1'b0;

                    if(rd_ptr_next == wr_ptr)
                        empty_next = 1'b1;
                end
            end
            2'b10: //write case
            begin
                if(~full)
                begin
                    wr_ptr_next = wr_ptr+1;
                    empty_next = 1'b0;

                    if(wr_ptr_next == rd_ptr)
                        full_next = 1'b1;
                end
            end 
            2'b11: //read and write at the same time
            begin
                if(empty)
                    begin
                        wr_ptr_next = wr_ptr;
                        rd_ptr_next = rd_ptr;
                    end
                else
                    begin
                        wr_ptr_next = wr_ptr+1;
                        rd_ptr_next = rd_ptr+1;
                    end

            end
            default: ; //2;b00
        endcase
        //outputs
        assign w_addr = wr_ptr;
        assign r_addr = rd_ptr;

    end

endmodule