# VinhNH-assignment
# Ruby on Rails Tutorial sample application
This is the Recuitment Page
by Nguyễn Hoàng Vinh

## Getting started
To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install --without production
```
Config your Mysql databse with file .env
Next, migrate the database:
```
$ rails db:migrate
```
If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```
Install MailCatcher
```
$ gem install mailcatcher
```
Start MailCatcher:
```
$ mailcatcher
```
Go to http://127.0.0.1:1080/ to see the emails sent locally.

## Requirement:
Assignment:
- Tạo trang tuyển dụng
- Job sẽ được import từ csv thông qua rake task
- Job: title, company_name, location, job_type, description
- Job type: full time, part time, freelance
- Company: company name
- Người dùng (k cần phải đky account) có thể search job theo job type (combobox) và title (freetext search).
- Chọn job và apply, sau khi apply sẽ có mail thông báo
