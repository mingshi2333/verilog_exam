module compare(
    equal,a,b
);
    output equal;
    input [1:0] a,b;
    assign equal=(a==b) ? 1:0; 
endmodule