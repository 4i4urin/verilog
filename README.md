# Репозитория домашних зааданий по сиситемотехнике электронно вычислительных средств

## Задание #0 Деление на 3
**Рабочая дериктория /div_three**

Входы: 

- такотвый сигнал - clk
- 1 бит сигнализирующий о начале пердачи - in_data_start
- 1 бит сигнализирующий о конце передачи - in_data_finish 
- 1 линия данных - in_data

Выход:
- 1 бит сигнализирующий о возможности делить число, полученное по data на 3 - out_is_div_three


Результаты моелирования

state - состояние машины состояний

1. На вход число 129. 129 % 3 = 0

![alt text](https://github.com/4i4urin/verilog/blob/main/div_three/img/waves_129.png)

2. На вход число 128. 128 % 3 = 2

![alt text](https://github.com/4i4urin/verilog/blob/main/div_three/img/waves_128.png)

3. На вход число 136. 136 % 3 = 1

![alt text](https://github.com/4i4urin/verilog/blob/main/div_three/img/waves_136.png)
