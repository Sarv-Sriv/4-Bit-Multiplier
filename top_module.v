// this is simulation code
`timescale 1ns / 1ps
module top_module(
    input [7:0] sw,          // sw[3:0] is 'a', sw[7:4] is 'b'
    input clk,               // 100MHz board clock
    output [7:0] led,        // NEW: Output to drive the LEDs above the switches
    output [6:0] seg,        // 7 segments
    output [3:0] an,         // 4 digit anodes
    output dp                // decimal point
    );

    wire [7:0] multiplier_out;
    assign dp = 1; // Keep decimal point off (Active Low)

    // Direct connection: LED glows if corresponding switch is High
    assign led = sw; 

    // Instantiate your Multiplier
    m4bit mult (
        .a(sw[3:0]), 
        .b(sw[7:4]), 
        .c(multiplier_out)
    );

    // Binary to BCD conversion (for 0-255)
    reg [3:0] hundreds, tens, units;
    always @(*) begin
        hundreds = multiplier_out / 100;
        tens = (multiplier_out / 10) % 10;
        units = multiplier_out % 10;
    end

    // Refresh Counter for Multiplexing (approx 1ms per digit)
    reg [19:0] refresh_counter;
    always @(posedge clk) refresh_counter <= refresh_counter + 1;
    wire [1:0] active_digit = refresh_counter[19:18];

    // Digit Selector
    reg [3:0] current_digit;
    reg [3:0] anode_ctrl;
    always @(*) begin
        case(active_digit)
            2'b00: begin current_digit = units;    anode_ctrl = 4'b1110; end
            2'b01: begin current_digit = tens;     anode_ctrl = 4'b1101; end
            2'b10: begin current_digit = hundreds; anode_ctrl = 4'b1011; end
            2'b11: begin current_digit = 4'hF;     anode_ctrl = 4'b0111; end // Leave 4th digit blank
            default: begin current_digit = 4'h0;   anode_ctrl = 4'b1111; end
        endcase
    end
    assign an = anode_ctrl;

    // BCD to 7-Segment Decoder (Active Low for Basys 3)
    reg [6:0] seg_temp;
    always @(*) begin
        case(current_digit)
            4'h0: seg_temp = 7'b1000000;
            4'h1: seg_temp = 7'b1111001;
            4'h2: seg_temp = 7'b0100100;
            4'h3: seg_temp = 7'b0110000;
            4'h4: seg_temp = 7'b0011001;
            4'h5: seg_temp = 7'b0010010;
            4'h6: seg_temp = 7'b0000010;
            4'h7: seg_temp = 7'b1111000;
            4'h8: seg_temp = 7'b0000000;
            4'h9: seg_temp = 7'b0010000;
            default: seg_temp = 7'b1111111; // Off
        endcase
    end
    assign seg = seg_temp;

endmodule
