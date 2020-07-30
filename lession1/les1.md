
##数据类型及其常量，变量  
reg  
wire  
integer  
parameter（参数型）

非阻塞赋值<=

**阻塞赋值*
```verilog
always @(posedge clk)
    begin
        b<=a;
        c<=b;
    end
```

##延时
-# times
(#为延时)
```verilog
##并行块
fork
    #50  r='h35;
    #100 r='hE2;
    #150 r='h00;
    #200 r='hF7;
    #250 -> end_wave;
join
```
**因为fork join内都是并行的，所以顺序不影响结果**
## 条件语句
## 寄存器和参数
## case语句
```verilog
case

endcase
```
case
casez（不考虑高阻值）
casex **(不考虑不定值和高阻值）**

## task和function说明语句的不同点

```
1.task可以单独定义自己的时间
2.函数不能启动任务，任务可以启动跟其他函数
3.函数至少要有个输入变脸，任务不需要输入变量
4.函数返回一个值，任务没有返回值
```



