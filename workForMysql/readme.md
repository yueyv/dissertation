### 用户表（users）

| 字段       | 类型         | 描述             |
| ---------- | ------------ | ---------------- |
| user_id    | INT          | 主键，自增ID     |
| username   | VARCHAR(50)  | 用户名           |
| password   | VARCHAR(100) | 密码（加密存储） |
| email      | VARCHAR(100) | 电子邮箱         |
| phone      | VARCHAR(20)  | 手机号码         |
| created_at | DATETIME     | 创建时间         |
| updated_at | DATETIME     | 更新时间         |

### 职位表（jobs）

| 字段         | 类型         | 描述         |
| ------------ | ------------ | ------------ |
| job_id       | INT          | 主键，自增ID |
| title        | VARCHAR(100) | 职位名称     |
| company_name | VARCHAR(100) | 公司名称     |
| salary_range | VARCHAR(50)  | 薪资范围     |
| location     | VARCHAR(100) | 工作地点     |
| description  | TEXT         | 职位描述     |
| company_info | TEXT         | 公司介绍     |
| created_at   | DATETIME     | 创建时间     |
| updated_at   | DATETIME     | 更新时间     |

### 求职申请表（job_applications）

| 字段         | 类型         | 描述                             |
| ------------ | ------------ | -------------------------------- |
| app_id       | INT          | 主键，自增ID                     |
| job_id       | INT          | 外键，关联职位表的ID             |
| user_id      | INT          | 外键，关联用户表的ID             |
| resume_url   | VARCHAR(255) | 简历文件的URL                    |
| cover_letter | TEXT         | 求职信                           |
| status       | VARCHAR(50)  | 求职申请状态（待处理、已处理等） |
| created_at   | DATETIME     | 创建时间                         |
| updated_at   | DATETIME     | 更新时间                         |

### 消息表（messages）

| 字段       | 类型        | 描述                             |
| ---------- | ----------- | -------------------------------- |
| message_id | INT         | 主键，自增ID                     |
| user_id    | INT         | 外键，关联用户表的ID             |
| content    | TEXT        | 消息内容                         |
| type       | VARCHAR(50) | 消息类型（系统通知、面试邀请等） |
| created_at | DATETIME    | 创建时间                         |

### 管理员表（admins）

| 字段     | 类型         | 描述             |
| -------- | ------------ | ---------------- |
| admin_id | INT          | 主键，自增ID     |
| username | VARCHAR(50)  | 用户名           |
| password | VARCHAR(100) | 密码（加密存储） |

