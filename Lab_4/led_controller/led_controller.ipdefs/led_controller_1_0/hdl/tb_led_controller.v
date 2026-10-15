`timescale 1ns/1ps
// Verilog-2001. Unit test of the uploaded LED IP, not a Zynq PS/C simulation.
// Test clock: 100 MHz, chosen for simulation (not a measured board clock).
module tb_led_controller;
    reg clk = 0;
    always #5 clk = ~clk;
    reg resetn = 0;
    reg [3:0] awaddr = 0;
    reg awvalid = 0;
    wire awready;
    reg [31:0] wdata = 0;
    reg [3:0] wstrb = 0;
    reg wvalid = 0;
    wire wready;
    wire [1:0] bresp;
    wire bvalid;
    reg bready = 0;
    reg [3:0] araddr = 0;
    reg arvalid = 0;
    wire arready;
    wire [31:0] rdata;
    wire [1:0] rresp;
    wire rvalid;
    reg rready = 0;
    wire [7:0] LEDs_out;
    integer errors = 0;

    led_controller_v1_0 dut (
        .LEDs_out(LEDs_out),
        .s00_axi_aclk(clk), .s00_axi_aresetn(resetn),
        .s00_axi_awaddr(awaddr), .s00_axi_awprot(3'b000),
        .s00_axi_awvalid(awvalid), .s00_axi_awready(awready),
        .s00_axi_wdata(wdata), .s00_axi_wstrb(wstrb),
        .s00_axi_wvalid(wvalid), .s00_axi_wready(wready),
        .s00_axi_bresp(bresp), .s00_axi_bvalid(bvalid), .s00_axi_bready(bready),
        .s00_axi_araddr(araddr), .s00_axi_arprot(3'b000),
        .s00_axi_arvalid(arvalid), .s00_axi_arready(arready),
        .s00_axi_rdata(rdata), .s00_axi_rresp(rresp),
        .s00_axi_rvalid(rvalid), .s00_axi_rready(rready)
    );

    // Drive on falling edges; sample transfers on rising edges.
    // AW and W are asserted together, matching this wizard-generated slave.
    task write_reg;
        input [31:0] value;
        reg aw_done;
        reg w_done;
        begin
            aw_done = 0; w_done = 0;
            @(negedge clk);
            awaddr = 4'h0; awvalid = 1;
            wdata = value; wstrb = 4'hF; wvalid = 1;
            bready = 0;
            while (!(aw_done && w_done)) begin
                @(posedge clk);
                if (awvalid && awready) aw_done = 1;
                if (wvalid && wready) w_done = 1;
                @(negedge clk);
                if (aw_done) awvalid = 0;
                if (w_done) wvalid = 0;
            end
            bready = 1;
            @(posedge clk);
            while (!bvalid) @(posedge clk);
            if (bresp !== 2'b00) begin
                errors = errors + 1;
                $display("FAIL: write response BRESP=%b", bresp);
            end
            @(negedge clk);
            bready = 0;
        end
    endtask

    integer led_value;
    initial begin
        repeat (5) @(negedge clk);
        resetn = 1;
        repeat (2) @(negedge clk);
        for (led_value = 1; led_value <= 8; led_value = led_value + 1) begin
            write_reg(led_value);
            if (LEDs_out !== led_value[7:0]) begin
                errors = errors + 1;
                $display("FAIL: expected %0d, LEDs=%b", led_value, LEDs_out);
            end else
                $display("PASS: value=%0d LEDs=%b", led_value, LEDs_out);
            repeat (20) @(negedge clk);
        end
        if (errors == 0) $display("TEST PASS: LED values 1 through 8");
        else $display("TEST FAIL: %0d errors", errors);
        $finish;
    end

    initial begin
        #10000;
        $display("TEST FAIL: timeout waiting for AXI handshake");
        $finish;
    end
endmodule
