#BB RANKING
每日更新中国宝宝类货币基金收益排行榜
##安装
在项目目录下
```shell
cp config/database.yml.default config/database.yml
```
在`database.yml`里修改自己的数据库信息
```ruby
production:
  adapter: mysql2
  database: # your database
  pool: 5
  timeout: 5000
  host: # your host
  username: root
  password: # your password
```
运行抓取数据定时任务
```shell
whenever -i
```
##TODO
1. 用户系统
2. 记账功能
3. SEO优化
4. 使用访问统计
