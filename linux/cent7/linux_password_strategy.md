# <center>linux系统用户密码策略</center>

## 1. 禁止root通过ssh远程登录
```
/etc/ssh/sshd_config
    PermitRootLogin no
    
service sshd restart
```

## 2. 每半年强制更新密码
```
/etc/login.defs
    PASS_MAX_DAYS   180
    PASS_MIN_DAYS   0
    PASS_MIN_LEN    5
    PASS_WARN_AGE   7
```   

## 3. 密码至少12位，必须包含大小写字母，数字，符号各一位，5次内不能重复   
```
/etc/pam.d/system-auth
    password    requisite     pam_cracklib.so retry=3 difok=3 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
    password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
```