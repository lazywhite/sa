## http压测工具
httperf --hog --server=192.168.0.202 --uri=/index.html --num-conns=10000 --wsess=10,10,0.1 

--hog：让 httperf 尽可能多产生连接，httperf 会根据硬件配置，有规律的产生访问连接

--num-conns：连接数量，总发起 10000 请求

--wsess：用户打开网页时间规律模拟，第一个 10 表示产生 10 个会话连接，第二个 10 表示每个会话连接进行 10 次请求，0.1 表示每个会话连接请求之间的间隔时间/s
