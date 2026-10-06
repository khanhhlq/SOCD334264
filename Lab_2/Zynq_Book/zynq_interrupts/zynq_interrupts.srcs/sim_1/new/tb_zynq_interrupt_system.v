`timescale 1ns / 1ps

//---------------------------------------------------------
// FUNCTIONAL MODEL - INTERRUPT COUNTER TUTORIAL 2D
//
// Mô phỏng:
//   1. GPIO button interrupt
//   2. AXI Timer interrupt
//   3. xlconcat ghép 2 interrupt vào IRQ_F2P[1:0]
//
// GPIO  -> irq_f2p[0]
// TIMER -> irq_f2p[1]
//---------------------------------------------------------
module interrupt_counter_model
#(
    // Giảm chu kỳ Timer để mô phỏng nhanh.
    // Không dùng chu kỳ Timer thực vì simulation sẽ rất lâu.
    parameter TIMER_PERIOD_CYCLES = 30
)
(
    input        clk,
    input  [4:0] btns,

    output reg [7:0] leds,

    output reg       gpio_irq,
    output reg       timer_irq,

    output     [1:0] irq_f2p,
    output           irq,

    // Chỉ dùng để dễ quan sát waveform
    output     [1:0] tmr_count_dbg
);

    //-----------------------------------------------------
    // Biến nội bộ
    //-----------------------------------------------------
    reg [31:0] timer_counter;
    reg [1:0]  tmr_count;
    reg [4:0]  btn_prev;


    //-----------------------------------------------------
    // Mô phỏng xlconcat
    //
    // In0 = GPIO interrupt
    // In1 = Timer interrupt
    //-----------------------------------------------------
    assign irq_f2p[0] = gpio_irq;
    assign irq_f2p[1] = timer_irq;

    // IRQ tổng để quan sát dễ hơn
    assign irq = gpio_irq | timer_irq;

    assign tmr_count_dbg = tmr_count;


    //-----------------------------------------------------
    // Giá trị ban đầu
    //-----------------------------------------------------
    initial
    begin
        leds          = 8'b00000000;
        gpio_irq      = 1'b0;
        timer_irq     = 1'b0;

        timer_counter = 0;
        tmr_count     = 0;

        btn_prev      = 5'b00000;
    end


    //-----------------------------------------------------
    // MAIN FUNCTIONAL MODEL
    //-----------------------------------------------------
    always @(posedge clk)
    begin

        //-------------------------------------------------
        // Mặc định interrupt chỉ tồn tại 1 clock
        //-------------------------------------------------
        gpio_irq  <= 1'b0;
        timer_irq <= 1'b0;


        //-------------------------------------------------
        // AXI TIMER
        //-------------------------------------------------
        if (timer_counter == TIMER_PERIOD_CYCLES - 1)
        begin
            timer_counter <= 0;

            // Timer phát interrupt
            timer_irq <= 1'b1;

            //-------------------------------------------------
            // Theo TMR_Intr_Handler() của interrupt_counter_tut_2D.c
            //
            // Timer hết hạn:
            // lần 1 -> tmr_count = 1
            // lần 2 -> tmr_count = 2
            // lần 3 -> tmr_count = 3
            // lần 4 -> leds = leds + 1
            //          tmr_count = 0
            //-------------------------------------------------
            if (tmr_count == 2'd3)
            begin
                tmr_count <= 2'd0;
                leds      <= leds + 1'b1;
            end
            else
            begin
                tmr_count <= tmr_count + 1'b1;
            end
        end
        else
        begin
            timer_counter <= timer_counter + 1'b1;
        end


        //-------------------------------------------------
        // GPIO BUTTON INTERRUPT
        //
        // Chỉ xử lý khi chuyển từ:
        // 00000 -> có nút được nhấn
        //-------------------------------------------------
        if ((btns != 5'b00000) &&
            (btn_prev == 5'b00000))
        begin

            gpio_irq <= 1'b1;

            //-------------------------------------------------
            // Theo BTN_Intr_Handler() trong code C
            //-------------------------------------------------

            // Centre button = 00001 -> reset counter
            if (btns == 5'b00001)
            begin
                leds <= 8'b00000000;
            end

            // Các nút còn lại cộng giá trị nút vào LED
            else
            begin
                leds <= leds + btns;
            end
        end


        //-------------------------------------------------
        // Lưu trạng thái nút trước
        //-------------------------------------------------
        btn_prev <= btns;

    end

endmodule



//=========================================================
// TESTBENCH
//=========================================================
module tb_zynq_interrupt_system;

    //-----------------------------------------------------
    // Tín hiệu mô phỏng
    //-----------------------------------------------------
    reg clk;

    reg [4:0] btns;

    wire [7:0] leds;

    wire gpio_irq;
    wire timer_irq;

    wire [1:0] irq_f2p;

    wire irq;

    wire [1:0] tmr_count_dbg;


    //-----------------------------------------------------
    // DUT
    //-----------------------------------------------------
    interrupt_counter_model
    #(
        .TIMER_PERIOD_CYCLES(30)
    )
    DUT
    (
        .clk(clk),

        .btns(btns),

        .leds(leds),

        .gpio_irq(gpio_irq),

        .timer_irq(timer_irq),

        .irq_f2p(irq_f2p),

        .irq(irq),

        .tmr_count_dbg(tmr_count_dbg)
    );


    //-----------------------------------------------------
    // CLOCK
    //
    // Period = 10 ns
    //-----------------------------------------------------
    initial
    begin
        clk = 1'b0;
    end

    always #5 clk = ~clk;


    //-----------------------------------------------------
    // TASK NHẤN NÚT
    //-----------------------------------------------------
    task press_button;

        input [4:0] value;

        begin

            btns = value;

            // Giữ nút
            #30;

            // Nhả nút
            btns = 5'b00000;

            #70;

        end

    endtask


    //-----------------------------------------------------
    // STIMULUS
    //-----------------------------------------------------
    initial
    begin

        //-------------------------------------------------
        // Ban đầu không nhấn nút
        //-------------------------------------------------
        btns = 5'b00000;


        //-------------------------------------------------
        // Chờ hệ thống ổn định
        //-------------------------------------------------
        #40;


        //-------------------------------------------------
        // GPIO INTERRUPT TEST 1
        //
        // btn = 00010 = 2
        // LED: 0 -> 2
        //-------------------------------------------------
        press_button(5'b00010);


        //-------------------------------------------------
        // GPIO INTERRUPT TEST 2
        //
        // btn = 00100 = 4
        // LED: 2 -> 6
        //-------------------------------------------------
        #40;

        press_button(5'b00100);


        //-------------------------------------------------
        // Từ đây chờ Timer hoạt động.
        //
        // Timer sẽ phát nhiều interrupt.
        //
        // Sau interrupt Timer thứ 4:
        //
        // LED: 6 -> 7
        //-------------------------------------------------
        #950;


        //-------------------------------------------------
        // TEST RESET BUTTON
        //
        // btn = 00001
        // LED -> 0
        //-------------------------------------------------
        press_button(5'b00001);


        //-------------------------------------------------
        // Kiểm tra GPIO sau reset
        //
        // btn = 01000 = 8
        // LED: 0 -> 8
        //-------------------------------------------------
        #40;

        press_button(5'b01000);


        //-------------------------------------------------
        // Cho Timer chạy thêm
        //-------------------------------------------------
        #400;


        //-------------------------------------------------
        // Kết thúc simulation
        //-------------------------------------------------
        $finish;

    end

endmodule