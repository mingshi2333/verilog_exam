## 数组
### 给定一个8bit输入向量，将其方向输出
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

### 重复项链自动链接
例如{num{a,b,c}}——>{a,,b,c,a,b,c}  
题目：将一个8位扩展为32位
```verilog
module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out={{24{in[7]}},in};//复制24个符号位，因为在verilog中只有正数，所以默认为零

```
## 模块  
### 列化模块
```verilog
module top_module (input a
,input b
,output out);

```
### Module addsub 加法减法器  
减法器就相当于加法器加上他（取反码再+1）补码  
![图片](https://hdlbits.01xz.net/mw/images/a/ae/Module_addsub.png)  
>module add16(input[15:0] a,input[15:0] b,input cin,output[15:0] sum,output cout);
```verilog
module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_n;
    wire carry;
    assign b_n=b^{32{sub}};//{32{sub}}=32个sub (当sub=1时，此时疑惑的作用相当于取反0⊕0=0，1⊕0=1，0⊕1=1，1⊕1=0)
    add16 a0(a[15:0],b_n[15:0],sub,sum[15:0],carry);
    add16 a1(a[31:16],b_n[31:16],carry,sum[31:16],);//没输出的话直接不写
endmodule
```
## 综合逻辑
### always
组合逻辑：always@（*)   //*表示无论什么敏感变化都触发  
时序逻辑：always@（posedge clk）  
>三种赋值方法  
1.连续赋值Continuous assignments   //assign x=y 
2.过程阻塞赋值Procedural blocking assignment  //x=y  
3.过程非阻塞性复制Procedural non-blocking assignment //只能在过程块中  

#### 异或门 XOR  ^

![](https://hdlbits.01xz.net/mw/images/4/40/Alwaysff.png)  

```verilog
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    assign out_assign =a^b;
    always@(*) out_always_comb=a^b;
    always@(posedge clk) out_always_ff <= a^b;//when have a clock ,use procedural non_blocking assignment

endmodule
```

### 选择逻辑

![12](https://hdlbits.01xz.net/mw/images/9/9d/Always_if_mux.png)  
```verilog
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    assign out_assign =sel_b1?sel_b2? b:a :a;//special using way
    always@(*)
        if(sel_b1&sel_b2)
            out_always=b;
    	else
            out_always=a;
endmodule
```

### always if2

>设计原则，避免产生锁存器  
### case选择  
按下arroy key，扫描到，对应值加一  
>注明：如果一开始加入默认值的话，则在结尾不需要加default

| scancode      | arrow key   |
|---------------|-------------|
| 16'he06b	     | left arrow  |
| 16'he072	     | down arrow  |
| 16'he074      | right arrow |
| 16'he075      | up arrow    |
| Anything else | none        |
```verilog
// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    always@(*) begin
        up=1'b0;
        down=1'b0;
        left=1'b0;
        right=1'b0;
        case(scancode)
         16'he06b:left=1'b1;
         16'he072:down=1'b1;
         16'he074:right=1'b1;
         16'he075:up=1'b1;
        
        endcase
    end

endmodule
```

###  三元运算符

***condition ? if_ture : if_false***
```Verilog
(0 ? 3 : 5)     // This is 5 because the condition is false.
(sel ? b : a)   // A 2-to-1 multiplexer between a and b selected by sel.

always @(posedge clk)         // A T-flip-flop.t 触发器
  q <= toggle ? ~q : q;

always @(*)                   // State transition logic for a one-input FSM
  case (state)
    A: next = w ? B : A;
    B: next = w ? A : B;
  endcase

assign out = ena ? q : 1'bz;  // A tri-state buffer 三态缓冲器

((sel[1:0] == 2'h0) ? a :     // A 3-to-1 mux 三选一mux
 (sel[1:0] == 2'h1) ? b :
                      c )
```


>Given four unsigned numbers, find the minimum. Unsigned numbers can be compared with standard comparison operators (a < b). Use the conditional operator to make two-way min circuits, then compose a few of them to create a 4-way min circuit. You'll probably want some wire vectors for the intermediate results.  

经典找最小
```verilog
module top_module (  
    input [7:0] a, b, c, d,
    output [7:0] min);
```

```Verilog
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] result1;
    wire [7:0] result2;
    always@(*) begin
    result1=(a<b)? a:b;
    result2=(result1<c)? result1:c;
    min=(result2<d)? result2:d;
    end
    // assign intermediate_result1 = compare? true: false;

endmodule

```

### 归纳运算符  

```Verilog

& a[3:0]     // AND: a[3]&a[2]&a[1]&a[0]. Equivalent to (a[3:0] == 4'hf)
| b[3:0]     // OR:  b[3]|b[2]|b[1]|b[0]. Equivalent to (b[3:0] != 4'h0)
^ c[2:0]     // XOR: c[2]^c[1]^c[0]

```

### 翻转

```Verilog

module top_module( 
    input [99:0] in,
    output [99:0] out
);
    always@(*) 
    begin
        for(int i=0;i<100;i++)
        begin
            out[i]=in[99-i];
        end//这样定义为systemverilog中的用法,正确的用法应该在外部定义integer 1;
    end

endmodule

```