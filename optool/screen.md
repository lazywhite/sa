ctrl + a  S 水平分割窗口
ctrl + a  | 垂直分割窗口
ctrl + a  Tab 切换区域
ctrl + a  k 关闭当前窗口

# 开启一个有名称的session, 默认为PID
screen -S <session name> 

# 清理状态为dead的session
screen -wipe 

# 删除状态为attached的session并连接
screen -D -r <pid>  
