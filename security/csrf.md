## Introduction
cross site request forgery   
恶意网站利用用户的cookie进行恶意访问   

html elements that can cross site
    img 
    iframe 
    script

## 防范
1. check request referer header
2. put encrypted hidden token in form and check token in every post
3. one-time-token
4. 表单验证码
