puts "==> Start seeding data ...... "
# Create Users
User.create!(name: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password", admin: true)
User.create!(name: "UserA", email: "user@example.com", password: "password", password_confirmation: "password", admin: false)
# Crete data Company
company1 = Company.create(name: "Tech Innovators 1")
company2 = Company.create(name: "Global Enterprises 2")
company3 = Company.create(name: "Creative Solutions 3")
# Create data Location
location1 = Location.create(province: "Hà Nội", district: "Hoàn Kiếm", street: "Phố Lý Thường Kiệt")
location2 = Location.create(province: "Hồ Chí Minh", district: "Quận 1", street: "Đường Nguyễn Huệ")
location3 = Location.create(province: "Đà Nẵng", district: "Sơn Trà", street: "Đường Võ Nguyên Giáp")
# Create data Job
job1 = Job.create(title: "Software Engineer", company: company1, job_type: 3, description: "Developing web applications.")
job2 = Job.create(title: "Marketing Specialist", company: company2, job_type: 1, description: "Managing marketing campaigns.")
job3 = Job.create(title: "Freelance Designer", company: company3, job_type: 2, description: "Designing websites and mobile apps.")
# Association Job and Location
job1.locations << location1
job1.locations << location2
job2.locations << location2
job2.locations << location3
job3.locations << location3
# Create JobApplication
job_application1 = JobApplication.create(email: "john.doe@example.com", job: job1, name: "John Doe", dob: "1990-05-15", gender: 1, description: "Experienced software engineer.")
job_application2 = JobApplication.create(email: "jane.smith@example.com", job: job2, name: "Jane Smith", dob: "1988-08-22", gender: 2, description: "Passionate about marketing strategies.")
job_application3 = JobApplication.create(email: "alex.lee@example.com", job: job3, name: "Alex Lee", dob: "1995-12-30", gender: 3, description: "Creative designer with a flair for modern styles.")
puts "==> ...... Seeding data successful!!!"
