# Репозиторий домашних заданий по сиситемотехнике электронно вычислительных средств

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

--------------------------------------------------------------------------------------------------------


## Задание #2 Комплексный умножитель
**Рабочая дериктория /complex_mult**

Задача 
Реализовать комплексный умножитель.Доступен всего один физический модуль умножения целых чисел. Входные данные поступают каждые 3 такта, размерность 8 бит, знаковые целые числа.

Входы: 

- такотвый сигнал - clk
- 2 числа вида a + bi

Выход:
- 1 число вида a + bi - произведение вхоных чисел

Основная идея:
Реализовать свой собственный умножитель без использования операции *

Получившийся модуль умножителя двух знаковых чисел за 2 такта расположен в файле **complex_mult/mult_two_cycle.v**

Результаты моделирования:

sub_res_re_1 = a1 * a2 &emsp; sub_res_re_2 = b1 * b2

sub_res_im_1 = a1 * b2 &emsp; sub_res_im_2 = a2 * b1

res_re = sub_res_re_1 - sub_res_re_2 &emsp; res_im = sub_res_im_1 + sub_res_im_2


1) При a1 = -2 &emsp; b1 = 4 &emsp; a2 = 3 &emsp; b2 = -7


![alt text](https://github.com/4i4urin/verilog/blob/main/complex_mult/img/test_1.png)


2) При a1 = -3 &emsp; b1 = 9 &emsp; a2 = 10 &emsp; b2 = 9


![alt text](https://github.com/4i4urin/verilog/blob/main/complex_mult/img/test_2.png)
