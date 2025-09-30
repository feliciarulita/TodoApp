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

## Table Schema

User : {
    userID (Primary Key),
    name : string,
    password : string,
    manager : boolean
}

Task : {
    taskID (Primary Key),
    name : string,
    createTime : datetime,
    endTime : datetime,
    status : [Pending, In Progress, Completed],
    priority : [High, Medium, Low],
    tag : string,
    userID (Foreign Key reference to User.userID)
}