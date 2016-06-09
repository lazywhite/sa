## Topic
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
			    user_name: "noreply@rongzhijia.com",
			    password: "rzj@2015",
			    domain: "rongzhijia.com",
			    enable_starttls_auto: true,

			    ssl: true,
			    openssl_verify_mode: "peer",

			    ca_file: "/opt/gitlab/embedded/ssl/certs/cacert.pem",
			  }
	end


```
