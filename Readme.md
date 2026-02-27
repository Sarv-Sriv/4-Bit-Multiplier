This project involves building a 4-bit Digital Multiplier system using an Artix-7 FPGA (Basys 3 board). 
The system takes two 4-bit numbers as input and displays their product as a decimal value on a 7-segment display.
Core Components
    The Multiplier Logic: The project uses Verilog to describe the hardware of a 4-bit array multiplier. This logic is built from the ground up using fundamental gates like AND, OR, and XOR to create Half Adders (HA) and Full Adders (FA).
    Binary to BCD Conversion: Since the multiplier produces an 8-bit binary result (up to 255), the code includes a conversion process to split this binary number into individual digits (Hundreds, Tens, and Units) so humans can read it easily.
    Hardware Interface: The project connects physical hardware to the code:
      Switches ($SW0-SW7$): Used to input the two 4-bit numbers.
      LEDs ($LD0-LD7$): Updated to glow when a switch is flipped "UP," providing immediate visual feedback for the inputs.
      7-Segment Display: Uses a multiplexing technique to show the 3-digit decimal result.
How it Works
  Input: You flip the switches on the Basys 3 board to select two numbers between 0 and 15.
  Processing: The FPGA calculates the product instantly using the gate-level multiplier logic.
  Output: The result is converted to decimal and sent to the 7-segment display. 
Technical Highlights
Structural Modeling: The multiplier is designed by instantiating sub-modules (FA and HA), which is a common practice in digital design and Verilog programming.
Display Multiplexing: Because all four digits on the board share the same segment wires, the code switches between them very quickly (using a 100MHz clock) so they appear to be on at the same time.
FPGA Implementation: The project follows the full Vivado workflow, including writing Constraints (.XDC) to map software variables to physical hardware pins.
