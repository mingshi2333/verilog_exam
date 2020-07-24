[toc]
##数组
###给定一个8bit输入向量，将其方向输出
```verilog
module top_module(
    input [7:0] in,
    output [7:0] out
);
endmodule

代码
module top_module(
    input [7:0] in,
    output [7:0] out
);
integer i;
always @(*) begin
    for(i=0;i<8;i++)
        out[i]=in[8-i-1];
end
endmodule
```
>引入了概念生成快，后续问题解绝

###重复项链自动链接
例如{num{a,b,c}}——>{a,,b,c,a,b,c}
题目：将一个8位扩展为32位
```verilog
module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out={{24{in[7]}},in};//复制24个符号位，因为在verilog中只有正数，所以默认为零

```
##模块
###列化模块
```verilog
module top_module (input a
,input b
,output out);

```
