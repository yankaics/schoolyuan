source 'http://rubygems.org'

gem 'rails', '4.2.0'
gem 'bcrypt', '3.1.7' # 加密
gem 'faker', '1.4.2' # 批量输入用户

gem 'net-ssh' # 安全性验证，处理图片必要
gem 'carrierwave', '0.10.0' # 处理图片上传，并把图片和微博模型关联起来
gem 'mini_magick', '3.8.0' # 调整图片尺寸
gem 'fog', '1.23.0' # 用于在生产环境中上传图片

#验证码,安装rmagick之前需要先安装:sudo apt-get install libmagickwand-dev imagemagick
#帮助见http://blog.csdn.net/shiralwz/article/details/45892139
gem 'easy_captcha'
gem 'rmagick'


gem 'will_paginate', '3.0.7' # 分页
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass', '3.2.0.0' # 版式
gem 'sass-rails', '5.0.0.beta1'
gem 'uglifier', '2.5.3'
gem 'coffee-rails', '4.1.0'
gem 'jquery-rails', '4.0.0.beta2'
gem 'turbolinks', '2.3.0'
gem 'jbuilder', '2.2.3'
gem 'rb-readline'
gem 'sdoc', '0.4.0',group: :doc

group :development, :test do
  gem 'sqlite3', '1.3.9'
  gem 'byebug',  '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring', '1.1.3'
end

group :test do
  gem 'minitest-reporters','1.0.5'
  gem 'mini_backtrace', '0.1.3'
  gem 'guard-minitest', '2.3.1'
end

group :production do
  gem 'pg', '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',   '4.8.3'
end
