网络延时分析展示工具

（1） RTT(Round-Trip Time)：简单说它是一个数据报在网络上两点中间往返一次的时间。是影响TCP性能和表征网络运行状况的重要参数。在网络中实时、准确地测量大量TCP设备和系统的RTT参数是网络管的重要环节之一。Smokeping就是这样的自动测试系统，它向目标设备和系统发送各种类型的测试数据包，测量、记录和展示RTT。
（2） Median RTT：它是中间数并不是平均值。Smokeping有多种类型的探针，探针在默认的设置下，每300秒向目标设备发送20测探测数据包。假如这20个数据包都返回的话，它就记录下了20个RTT，那么Median RTT就是第十个包的RTT；如果有5个包丢失的话，那么Median RTT就是第八个返回的包的RTT值。
（3） Avg RTT：它是每一个测试回合中所有RTT的算术评价值。
（4） Avg pkt loss：丢包率。
（5） Probe:100ICMP Echo Pings(56 Bytes)every 300s每一个绿色的短横线都是一个测试回合300秒内用ping测试100次。绿色画出的是中间数的位置，一个回合中的其它值都在它附近被以灰度的形式被刻画；