module round_robin_arbiter_variable_time_slice (
    input wire clk,
    input wire rst_n,
    input wire [3:0] REQ,
    output reg [3:0] GNT
);

    reg [1:0] grant_idx; 
    reg [1:0] count;      

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant_idx <= 2'd0;
            count     <= 2'd0;
            GNT       <= 4'b0000;
        end else begin
            if (REQ[grant_idx]) begin
                GNT <= (grant_idx == 2'd0) ? 4'b0001 :
                       (grant_idx == 2'd1) ? 4'b0010 :
                       (grant_idx == 2'd2) ? 4'b0100 :
                                             4'b1000;

                if (count == 2'd2) begin
                    count <= 2'd0;

                   
                    if (REQ[(grant_idx + 1) & 2'd3])
                        grant_idx <= (grant_idx + 1) & 2'd3;
                    else if (REQ[(grant_idx + 2) & 2'd3])
                        grant_idx <= (grant_idx + 2) & 2'd3;
                    else if (REQ[(grant_idx + 3) & 2'd3])
                        grant_idx <= (grant_idx + 3) & 2'd3;
                end else begin
                    count <= count + 1;
                end
            end else begin
                GNT <= 4'b0000;
                count <= 2'd0;

            
                if (REQ[(grant_idx + 1) & 2'd3])
                    grant_idx <= (grant_idx + 1) & 2'd3;
                else if (REQ[(grant_idx + 2) & 2'd3])
                    grant_idx <= (grant_idx + 2) & 2'd3;
                else if (REQ[(grant_idx + 3) & 2'd3])
                    grant_idx <= (grant_idx + 3) & 2'd3;
            end
        end
    end

endmodule
