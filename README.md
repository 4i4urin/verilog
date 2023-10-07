Репозитория домашних зааданий по сиситемотехнике электронно вычислительных средств

Задание #0
/div_three
Вход: 
такотвый сигнал - clk
1 бит сигнализирующий о начале пердачи - in_data_start
1 бит сигнализирующий о конце передачи - in_data_finish 
1 линия данных - in_data

Выход:
1 бит сигнализирующий о возможности делить число, полученное по data на 3 - out_is_div_three


Результаты моелирования
1. На вход число 129. 129 % 3 = 0

![alt_tag](https://github.com/4i4urin/verilog/div_three/img/waves_129.png)
state - состояние машины состояний

2. На вход число 128. 128 % 3 = 2

![alt_tag](https://github.com/4i4urin/verilog/div_three/img/waves_128.png)
state - состояние машины состояний

3. На вход число 136. 136 % 3 = 1

![alt_tag](https://github.com/4i4urin/verilog/div_three/img/waves_136.png)
state - состояние машины состояний
