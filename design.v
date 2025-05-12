module round_robin_arbiter_fts (
    input clk,
    input reset,
    input [3:0] REQ,
    output reg [3:0] GNT
);

  reg [2:0] present_state;
  reg [2:0] next_state;

  parameter S_ideal = 3'b000;
  parameter S_0     = 3'b001;
  parameter S_1     = 3'b010;
  parameter S_2     = 3'b011;
  parameter S_3     = 3'b100;


  always @(posedge clk or negedge reset) begin
    if (!reset)
      present_state <= S_ideal;
    else
      present_state <= next_state;
  end


  always @(*) begin
    case (present_state)
      S_ideal: begin
        if (REQ[0]) next_state = S_0;
        else if (REQ[1]) next_state = S_1;
        else if (REQ[2]) next_state = S_2;
        else if (REQ[3]) next_state = S_3;
        else next_state = S_ideal;
      end
      S_0: begin
        if (REQ[1]) next_state = S_1;
        else if (REQ[2]) next_state = S_2;
        else if (REQ[3]) next_state = S_3;
        else if (REQ[0]) next_state = S_0;
        else next_state = S_ideal;
      end
      S_1: begin
        if (REQ[2]) next_state = S_2;
        else if (REQ[3]) next_state = S_3;
        else if (REQ[0]) next_state = S_0;
        else if (REQ[1]) next_state = S_1;
        else next_state = S_ideal;
      end
      S_2: begin
        if (REQ[3]) next_state = S_3;
        else if (REQ[0]) next_state = S_0;
        else if (REQ[1]) next_state = S_1;
        else if (REQ[2]) next_state = S_2;
        else next_state = S_ideal;
      end
      S_3: begin
        if (REQ[0]) next_state = S_0;
        else if (REQ[1]) next_state = S_1;
        else if (REQ[2]) next_state = S_2;
        else if (REQ[3]) next_state = S_3;
        else next_state = S_ideal;
      end
      default: next_state = S_ideal;
    endcase
  end

	
  always @(*) begin
    case (present_state)
      S_0: GNT = 4'b0001;
      S_1: GNT = 4'b0010;
      S_2: GNT = 4'b0100;
      S_3: GNT = 4'b1000;
      default: GNT = 4'b0000;
    endcase
  end

endmodule
