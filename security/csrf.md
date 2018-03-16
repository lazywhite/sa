## Introduction
cross site request forgery   
恶意网站利用用户的cookie进行恶意访问, 就像用户自行访问一样, 预防的关键在于在
请求中放入cookie内部没有的安全信息, 并且在服务端利用拦截器验证这个安全信息

html elements that can cross site
    img 
    iframe 
    script

## 防范
1. check request referer header
2. 每个表单添加随机生成的csrftoken
3. request header添加csrf token
4. 验证码


