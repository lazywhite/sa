## Introduction
1. turn a pool or hosts into a single virtual host and can schedule distribute  
programm at same time
2. like a distribute kernel of operation system  

  
## Components
1. Mesos Master\(coordinator or scheduler\), standby master, zookeeper    
2. Mesos Agent   
3. Mesos framework(can be hadoop or spark)  
    scheduler: to be offered resources  
    executor: launched on agent nodes to run tasks  

## Topic
### 1. Aurora
aurora runs application and services across a pool of machines and is responsible  
for keep them running forever, when machine expirence failure, aurora can reschedule  these jobs onto healthy machines 

