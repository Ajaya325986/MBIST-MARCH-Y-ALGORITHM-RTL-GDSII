module controller1 (
    input clk,
    input rst,
    output reg status,
    output [7:0] dataout
);
    parameter CAWIDTH = 4;
    parameter RAWIDTH = 2;
    localparam MAXSIZE = (1 << RAWIDTH);  // Replace ** with shift for synthesis
    reg [7:0] orig;

    reg [3:0] state, nextstate;
    reg [CAWIDTH-1:0] CA;
    reg we, re;
    reg [7:0] datain;
    reg [4:0] count;
    reg element_done;
    reg [2:0] element_operation;
    reg fresh_state;
    reg comp_en;
    reg Test;

    // Memory instantiation (assumed to be synthesizable)
    memory u (
        .clk(clk),
        .rst(rst),
        .CA(CA),
        .we(we),
        .datain(datain),
        .re(re),
        .dataout(dataout)
    );

    // State encoding
    localparam W0_UPDOWN = 4'b0000;
    localparam R0_W1_R1_UP = 4'b0001;
    localparam R1_W0_R0_DOWN = 4'b0010;
    localparam R0_UPDOWN_FINAL = 4'b0011;

    // Main state machine logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= W0_UPDOWN;
            count <= 0;
            element_operation <= 3'b000;
            fresh_state <= 1;
            Test <= 1;
        end else if (Test) begin
            case (state)
                W0_UPDOWN: begin
                    status <= 0;
                    if (fresh_state) begin
                        CA <= 0;
                        comp_en <= 0;
                        orig <= 8'b0;
                        fresh_state <= 0;
                    end else begin
                        count <= count + 1;
                        CA <= CA + 1;
                    end
                    datain <= 8'b0;
                    we <= 1;
                    re <= 0;
                    if (count == MAXSIZE * MAXSIZE) nextstate <= R0_W1_R1_UP;
                end

                R0_W1_R1_UP: begin
                    status <= 0;
                    if (fresh_state) begin
                        CA <= 0;
                        orig <= 8'b0;
                        comp_en <= 0;
                        fresh_state <= 0;
                    end else if (element_done) begin
                        element_done <= 0;
                        count <= count + 1;
                        CA <= CA + 1;
                    end
                    case (element_operation)
                        3'b000: begin
                            we <= 0;
                            comp_en <= 0;
                            orig <= 8'b0;
                            re <= 1;
                            element_operation <= 3'b001;
                        end
			3'b001: begin
                            orig <= 8'b0;
                            element_operation <= 3'b010;
                        end
                        3'b010: begin
                            comp_en <= 1;
                            orig <= 0;
                            we <= 1;
                            re <= 0;
                            datain <= 8'b11111111;
                            element_operation <= 3'b011;
                        end
			3'b011: begin
                            orig <= 8'b0;
                            element_operation <= 3'b100;
                        end
			3'b100: begin
                             we <= 0;
                            re <= 1;
                            comp_en <= 0;
                            orig <= 8'b0;
                            element_operation <= 3'b101;
                        end
                        3'b101: begin
                            orig <= 8'b11111111;
                            element_operation <= 3'b110;
                        end
			3'b110: begin
                             comp_en <= 1;
                            orig <= 8'b11111111;
                            element_done <= 1;
                            element_operation <= 3'b111;
                        end
                        3'b111: begin
                            orig <= 8'b11111111;
                            element_operation <= 3'b000;
			end
			
                        
                    endcase
                    if (count == MAXSIZE * MAXSIZE) nextstate <= R1_W0_R0_DOWN;
                end

                R1_W0_R0_DOWN: begin
                    status <= 0;
                    if (fresh_state) begin
                        CA <= 15;
                        fresh_state <= 0;
                        comp_en <= 0;
                        orig <= 8'b0;
                    end else if (element_done) begin
                        element_done <= 0;
                        count <= count + 1;
                        CA <= CA - 1;
                    end
                    case (element_operation)
                        3'b000: begin
                            we <= 0;
                            re <= 1;
                            comp_en <= 0;
                            orig <= 8'b0;
                            element_operation <= 3'b001;
                        end
			3'b001: begin
                            
                            element_operation <= 3'b010;
                        end
                        3'b010: begin
                            comp_en <= 1;
                            orig <= 8'b11111111;
                            we <= 1;
                            re <= 0;
                            datain <= 0;
                            element_operation <= 3'b011;
                        end
			3'b011: begin
                            orig <= 8'b11111111;
                            element_operation <= 3'b100;
                        end
                        3'b100: begin
                            we <= 0;
                            re <= 1;
                            comp_en <= 0;
                            orig <= 8'b0;
                            element_operation <= 3'b101;
                        end
			3'b101: begin
                            orig <= 8'b0;
                            element_operation <= 3'b110;
                        end
                        3'b110: begin
                            comp_en <= 1;
                            orig <= 8'b0;
                            element_done <= 1;
                            element_operation <= 3'b111;
                        end
			3'b111: begin
                            orig <= 8'b0;
                            element_operation <= 3'b000;
                        end
                    endcase
                    if (count == MAXSIZE * MAXSIZE) nextstate <= R0_UPDOWN_FINAL;
                end

                R0_UPDOWN_FINAL: begin
                    status <= 0;
                    if (fresh_state) begin
                        comp_en <= 0;
                        orig <= 8'b0;
                        CA <= 0;
                        fresh_state <= 0;
                    end else begin
                        count <= count + 1;
                            CA <= CA + 1;
                    end
                    we <= 0;
                    re <= 1;
                    comp_en <= 1;
                    orig <= 0;
                    if (count == MAXSIZE * MAXSIZE) Test <= 0;
                end
            endcase
        end
    end

    // State transition logic
    always @(nextstate) begin
        if (rst) begin
            state <= W0_UPDOWN;
        end else begin
            state <= nextstate;
        end
    end
    always @(state) begin
    fresh_state <= 1;
    count <= 0;
    comp_en <= 0;
    orig <= 1'b0;
    element_operation<= 0;
    end
    always @(orig,comp_en) begin
    if (orig==8'b0 || orig==8'b11111111) begin
        if (dataout == orig) status <= 0;
        end
    else status<=1;
    end
endmodule
