module tb_round_robin_arbiter;

  reg clk;
  reg reset;
  reg [3:0] REQ;
  wire [3:0] GNT;

 
  round_robin_arbiter_fts uut (
    .clk(clk),
    .reset(reset),
    .REQ(REQ),
    .GNT(GNT)
  );

  
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 0;
    REQ = 4'b0000; 

    #5 reset = 1;
    @(negedge clk) REQ = 4'b1111;
    @(negedge clk) REQ = 4'b0001;
    @(negedge clk) REQ = 4'b0010;
    @(negedge clk) REQ = 4'b0100;
    @(negedge clk) REQ = 4'b1000;
    @(negedge clk) REQ = 4'b1010;
    @(negedge clk) REQ = 4'b0111;
    @(negedge clk) REQ = 4'b0000;

    #5 reset = 0;
    #100 $finish; 
  end

  initial begin
    $dumpfile("arbiter.vcd");
    $dumpvars(0, tb_round_robin_arbiter);
  end

endmodule
