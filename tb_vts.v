`timescale 1ns / 1ps

module Arbiter_test;


  reg clk;
  reg rst_n;
  reg [3:0] REQ;
  wire [3:0] GNT;


  round_robin_arbiter_variable_time_slice DUT (
    .clk(clk),
    .rst_n(rst_n),
    .REQ(REQ),
    .GNT(GNT)
  );


  always #5 clk = ~clk;


  initial begin

    clk   = 0;
    rst_n = 0;
    REQ   = 4'b0000;

  
    #10 rst_n = 1;


    repeat (2) @(posedge clk);
    REQ = 4'b1000;

    repeat (2) @(posedge clk);
    REQ = 4'b1010;

    repeat (2) @(posedge clk);
    REQ = 4'b0010;

    repeat (2) @(posedge clk);
    REQ = 4'b0110;

    repeat (2) @(posedge clk);
    REQ = 4'b1110;

    repeat (2) @(posedge clk);
    REQ = 4'b1111;

    repeat (2) @(posedge clk);
    REQ = 4'b0100;

    repeat (2) @(posedge clk);
    REQ = 4'b0001;

    repeat (2) @(posedge clk);
    REQ = 4'b0010;

    repeat (2) @(posedge clk);
    REQ = 4'b0000;

    // Trigger another reset
    repeat (2) @(posedge clk);
    rst_n = 0;

    repeat (2) @(posedge clk);
    rst_n = 1;

    repeat (10) @(posedge clk);

    $finish;
  end

 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Arbiter_test);
  end

endmodule
