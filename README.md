# Asynchronous-FIFO

#About the project
This project is mainly focus on build an asynchronous fifo in verilog and make further optimization.
Also, this project is used as github 101 to let me familar with github.

#What is FIFO?
FIFO means first in first out. a method for organizing and manipulating a data buffer. FIFOs are commonly used in electronic circuits for buffering and flow control between hardware and software. In its hardware form, a FIFO primarily consists of a set of read and write pointers, storage and control logic. Storage may be static random access memory (SRAM), flip-flops, latches or any other suitable form of storage. For FIFOs of non-trivial size, a dual-port SRAM is usually used, where one port is dedicated to writing and the other to reading.


#When use FIFO 
FIFOs are often used to safely pass data from one clock domain to another asynchronous clock domain. FIFO can also used between different date width.

#Metastability issues

Gray code 
Gray codes only allow one bit to change for each clock transition, eliminating the problem associated with trying to synchronize multiple changing signals on the same clock edge.
Cons: Gray code counters must have power-of-2 counts in the sequence. (因为格雷码必须循环一个2^n，否则就不能保证两个相邻码元之间相差一位的条件)

In synchronous FIFO, when read pointer catches write pointer, FIFO will flag empty status. When wite pointer catches read pointer, FIFO will flag empty status. To distinguish between the two situations, a simple and robust solution is to add one extra bit for each read and write address which is inverted each time the address wraps. The condition changes to:

When the read address register equals the write address register, the FIFO is empty.
When the read address LSBs equal the write address LSBs and the extra MSBs are different, the FIFO is full.

In asynchronous FIFO, empty flag occurs when write pointer catches up to the synchronized and sampled read pointer. Full flag occurs when read pointer catches up to the synchronized and sampled write pointer. The synchronized and sampled pointer might not reflect the current value of the actual pointer. When used gray code, the condition changes to:

When the read address register equals the write address register, the FIFO is empty.
When the read address LSBs equal the last two write address LSBs and the two extra MSBs are either different, the FIFO is full.

#FIFO that is not in 2^n deep

#Synchronizer
(2phase vs 3phase)
10m工作时钟写数20m时钟读，与10m时钟写数100m时钟读数的区别是什么?
从快时钟到慢时钟传输

#Different date width 
异步FIFO有数据位转换功能，32b的数据入16b数据出

#泊松分布? Memory depth selection
(FIFO 一个大的问题就是如何保证buffer长度适用于读写的速率差，buffer短了，写的太快，读的太慢就会丢失数据，buffer太长又是浪费，同时还要考虑，突发的爆发性写入速率，比如网页的访问和处理，应用里写入的速度很多是呈泊松分布的，这个方面有很多研究)

#Reference
https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)
Cummings, Clifford E. "Simulation and synthesis techniques for asynchronous FIFO design." SNUG 2002 (Synopsys Users Group Conference, San Jose, CA, 2002) User Papers. 2002.
https://www.zhihu.com/question/32275527
http://blog.sina.com.cn/s/blog_603b57d50100dz5h.html
