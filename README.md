Square
=========

Square 是一个基于 Ruby on Rails 的图片管理系统。

#### 环境
1. Rails 4.0
2. SQLite 3.0
3. Node.js 1.0

#### 系统
Ubuntu 12.04

**_警告_: **
Ruby on Rails 请务必在 Unix/Linux 系统下开发。在 Windows 下开发所遇问题一般不予解答。

#### 应用服务器
puma 2.6

#### 前端框架
Semantic-ui

------

#### 初次运行
1. bundle install
2. rake db:create && rake db:migrate
3. cd square && mkdir origin
4. rails s puma

#### 注意事项
Square 默认超级管理员在定义在`config/application.yml`的 `roots` 中。（PS: 请了解一下标记型语言 `YAML`）。


Square 超级管理员为 `hellcat`，但不会自动创建，请开启服务器之后立即手动申请。


某些选项只允许超级管理员查看和操作，有时候甚至不予以显示相应链接。


应用登录使用的是 AJAX 通信，登录后不会刷新页面。所以如果登录超级管理员，请在登录后刷新一下页面。
