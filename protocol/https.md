##doc
[https简介](http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html)
[https detail](https://technet.microsoft.com/en-us/library/cc785811(v=ws.10).aspx)

公钥加密算法:客户端索要服务器公钥, 用公钥加密信息, 服务度用私钥解密

为保证公钥不被篡改, 公钥会放在数字证书中
每次session, 生成对称加密的session key, 包含公钥的证书只是用来加密对话密匙

SSL/TLS协议大致的工作流程为
（1） 客户端向服务器端索要并验证公钥。
（2） 双方协商生成"对话密钥"。
（3） 双方采用"对话密钥"进行加密通信。 

前两个阶段为"握手阶段"

RSA: 密匙交换算法

```
##工作流程
1. client hello
    supported protocol: TLS 1.0
    random number
    supported encrypt method: RSA
    compression method: gzip

2. server hello
    protocol: TLS 1.0
    random number
    encrypt method: RSA
    cert file (pub key + ca pub key)
    client cert request: optional 

3. client process
    send client cert (optionnal, send if server requested)
    validate server cert using CA; check hostname; then get server pub key
    random number (pre-master key)
    client finish
     
4. server process
    generate session key 
    server finish
```        

    
    
     
```
## Client hello    
ClientVersion 3,1
ClientRandom[32]
SessionID: None (new session)
Suggested Cipher Suites:
   TLS_RSA_WITH_3DES_EDE_CBC_SHA
   TLS_RSA_WITH_DES_CBC_SHA
Suggested Compression Algorithm: NONE    
```

```
## server hello
Version 3,1
ServerRandom[32]
SessionID: bd608869f0c629767ea7e3ebf7a63bdcffb0ef58b1b941e6b0c044acb6820a77
Use Cipher Suite:
TLS_RSA_WITH_3DES_EDE_CBC_SHA
Compression Algorithm: NONE
```


