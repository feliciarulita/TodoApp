# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## Website Link (Render)

https://todoapp-yb5f.onrender.com

## Table Schema
```mermaid
erDiagram
    USER {
        int userID PK
        string name
        string password
        boolean manager
    }

    TASK {
        int taskID PK
        string name
        datetime createTime
        datetime endTime
        enum status "Pending, In Progress, Completed"
        enum priority "High, Medium, Low"
        string tag
        int userID FK
    }

    USER ||--o{ TASK : "has"
