### 汉化
  
```
# 1. 查看版本
cat /opt/gitlab/embedded/service/gitlab-rails/VERSION

git clone https://gitlab.com/larryli/gitlab.git

cd gitlab
git diff origin/<version>-stable..origin/<version>-zh > /root/8.8.patch

gitlab-ctl stop
cp /opt/gitlab/embedded/service/gitlab-rails  /opt/gitlab/embedded/service/gitlab-rails-bak
cd /opt/gitlab/embedded/service/gitlab-rails
patch -p1 < /root/8.8.patch

gitlab-ctl start
```

### 重设root密码
  
```
# gitlab-rails console production
> u = User.where(id: 1).first
> u.password = 'secret_pass'
> u.password_confirmation = 'secret_pass'
> u.save!
```
  


### smtp setting
```
/opt/gitlab/embedded/service/gitlab-rails/config/environments/production.rb
    config.action_mailer.delivery_method = :smtp
    
    
/opt/gitlab/embedded/service/gitlab-rails/config/initializers/smtp_settings.rb
    if Rails.env.production?
      Gitlab::Application.config.action_mailer.delivery_method = :smtp

			    ActionMailer::Base.smtp_settings = {
			    authentication: :login,
			    address: "smtp.exmail.qq.com",
			    port: 465,
			    user_name: "noreply@demo.com",
			    password: "",
			    domain: "demo.com",
			    enable_starttls_auto: true,

			    ssl: true,
			    openssl_verify_mode: "peer",

			    ca_file: "/opt/gitlab/embedded/ssl/certs/cacert.pem",
			  }
	end


```
### smtp配置
```
admin_aread->settings->restricted domains for sign-up

external_url 'http://192.168.1.252:8080'
gitlab_rails['gitlab_email_from'] = 'code@shrlwl.cn'
gitlab_rails['gitlab_email_reply_to'] = 'code@shrlwl.cn'
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.exmail.qq.com"
gitlab_rails['smtp_port'] =  465
gitlab_rails['smtp_user_name'] = "code@shrlwl.cn"
gitlab_rails['smtp_password'] = ""
gitlab_rails['smtp_domain'] = "shrlwl.cn"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
nginx['listen_port'] = 7000

gitlab_rails['gitlab_ssh_host'] = ''
gitlab_rails['gitlab_shell_ssh_port'] = 322
nginx['client_max_body_size'] = '2500m'

time_zone: 'Asia/Shanghai'
email_enabled: true
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/settings/smtp.md
```


### 设置日志级别
```
debug_level: /opt/gitlab/embedded/service/gitlab-rails/config/environments/production.rb  
    config.log_level = :debug
```

### 允许同域名webhook
```
admin-area --> setting --> Outbound requests --> Allow requests to the local network from hooks and services.
```

### 配置webhook
```
project page --> settings --> integration --> uncheck SSL
```

### 配置deploy key
```
clone project无需用户名密码
project page --> settings --> repository --> deploy keys

# on jenkins master
ssh-keygen
git clone <repo url> # git协议,  手动clone一次, 防止unknown host问题
job--> vcs --> git --> url 
```

