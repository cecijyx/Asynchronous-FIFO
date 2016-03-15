# Asynchronous-FIFO
This project is mainly focus on build an asynchronous fifo in verilog and make further optimization.
More importantily, this project is used as github 101 to let me familar with github.

#亚稳态
(异步fifo的满空判断属于超前判断，也就是保守判断，空和满都不是即时状态，当pointer相等判定为空的时候，wr_pointer其实已经多跑了两T。这并不是什么错误，因为你的比较是同步逻辑。异步逻辑转到同步逻辑不可避免需要额外的时钟开销，这会导致满空趋于保守，但是保守并不等于错误。这么写会稍微有性能损失，但是不会出错。https://www.zhihu.com/question/32275527)

#考虑深度不为2的幂次时

#Principle of gray code

#Synchronizer
(2phase vs 3phase)
10m工作时钟写数20m时钟读，与10m时钟写数100m时钟读数的区别是什么?
从快时钟到慢时钟传输

异步FIFO有数据位转换功能，32b的数据入16b数据出

#泊松分布?
(FIFO 一个大的问题就是如何保证buffer长度适用于读写的速率差，buffer短了，写的太快，读的太慢就会丢失数据，buffer太长又是浪费，同时还要考虑，突发的爆发性写入速率，比如网页的访问和处理，应用里写入的速度很多是呈泊松分布的，这个方面有很多研究)

