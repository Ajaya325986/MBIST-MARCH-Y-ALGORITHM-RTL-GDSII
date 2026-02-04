module tb_bist_memory;
    // Parameters
    parameter CAWIDTH = 4;
    parameter RAWIDTH = 2;
    integer maxsize = 2**RAWIDTH;

    // Testbench signals
    reg clk;
    reg rst;
    wire status;
    wire [7:0] dataout;

    // Instantiate the DUT (Device Under Test)
    controller1 #(
        .CAWIDTH(CAWIDTH),
        .RAWIDTH(RAWIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .status(status),
        .dataout(dataout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns clock period
    end

    // Test procedure
    initial begin
        // Open a VCD file for waveform analysis
        $dumpfile("tb_bist_memory.vcd");
        // Capture all signals in the testbench and DUT at depth level 2
        $dumpvars(2, tb_bist_memory);

        // Apply reset
        rst = 1;
        #5;  // Hold reset for 10 ns
        rst = 0;

        // Wait for the DUT to complete the test sequence
        wait (!dut.Test);  // Wait until DUT's internal Test goes low

        // Check the final status
        if (status == 1) begin
            $display("Test FAILED with status: %b", status);
        end else begin
            $display("Test PASSED with status: %b", status);
        end

        // End simulation
        $finish;
    end

    // Monitoring DUT internal signals for debug (if accessible)
    initial begin
        // Display state transitions and important signal changes for debug
        $monitor("Time=%0d: state=%b, count=%d, CA=%d, datain=%b, dataout=%b, status=%b",
            $time, dut.state, dut.count, dut.CA, dut.datain, dataout, status);
    end

endmodule
