流量清洗:
    此节点RDS仍可正常访问
    只针对流入流量进行清洗
    PPS(package per second) > 3000
    BPS(Bits per second) > 180Mb
    新建并发连接 per second > 10000
    激活并发连接数> 10000
    非激活并发连接数 > 100000


黑洞处理
    RDS不可被外网访问
    只针对流入流量
    BPS达到2Gb
    流量清洗无效
    2.5小时自动解除
    
    
