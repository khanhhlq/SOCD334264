`timescale 1ns / 1ps

module tb_led_sim;

    reg [3:0] led;

    initial begin
        led = 4'b0001;

        #100;
        led = 4'b0010;

        #100;
        led = 4'b0100;

        #100;
        led = 4'b1000;

        #100;
        led = 4'b0001;

        #100;
        led = 4'b0010;

        #100;
        led = 4'b0100;

        #100;
        led = 4'b1000;

        #100;
        $finish;
    end

endmodule