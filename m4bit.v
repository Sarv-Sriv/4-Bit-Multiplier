//  Design code

`timescale 1ns / 1ps
module FA (output sum, output cout, input a,input b, input cin);
    wire [2:0] we;
    xor X (we[0] , a, b);
    xor X2 (sum, we[0], cin);
    and A (we[1], we[0], cin);
    and A2(we[2], a, b);
    or O (cout, we[1], we[2]);
endmodule

module HA (output sum, output cout ,input a,input b);
    xor X3(sum, a, b);
    and A2(cout, a, b);
endmodule

// --- 4-bit Array Multiplier ---
module m4bit(
    input [3:0] a,
    input [3:0] b,
    output [7:0] c
);
    wire [10:0] con;
    wire [15:0] pp;
    wire [5:0] su;
    and A1 (pp[0], a[0],b[0]); 
    
    assign c[0] = pp[0];
    
    and A2 (pp[1], a[1],b[0]); 
    and A3 (pp[2], a[2],b[0]); 
    and A4 (pp[3], a[3],b[0]); 
    and A5 (pp[4], a[0],b[1]);
    and A6 (pp[5], a[1],b[1]);
    and A7 (pp[6], a[2],b[1]);
    and A8 (pp[7], a[3],b[1]);
    and A9 (pp[8], a[0],b[2]);
    and A10 (pp[9], a[1],b[2]);
    and A11 (pp[10], a[2],b[2]);
    and A12 (pp[11], a[3],b[2]);
    and A13 (pp[12], a[0],b[3]);
    and A14 (pp[13], a[1],b[3]);
    and A15 (pp[14], a[2],b[3]);
    and A16 (pp[15], a[3],b[3]);
    
    HA h1 (c[1], con[0], pp[1], pp[4]);
    FA f1 (su[0], con[1], con[0], pp[2], pp[5]);
    FA f2 (su[1], con[2], con[1], pp[6], pp[3]);
    HA h2 (su[2], con[3], con[2], pp[7]);
    
    HA h3 (c[2], con[4], su[0], pp[8]);
    FA f3 (su[3], con[5], pp[9], su[1], con[4]);
    FA f4 (su[4], con[6], pp[10], con[5], su[2]);
    FA f5 (su[5], con[7], pp[11], con[3], con[6]);
    
    HA h4 (c[3], con[8], pp[12], su[3]);
    FA f6 (c[4], con[9], pp[13], con[8], su[4]);
    FA f7 (c[5], con[10], pp[14], con[9], su[5]);
    FA f8 (c[6], c[7], pp[15], con[10], con[7]);    
endmodule
