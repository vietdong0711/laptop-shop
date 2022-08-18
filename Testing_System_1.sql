create database Testing_System_Assignment_1;
use Testing_System_Assignment_1;

/* Bảng 1 */
create table Department (
	DepartmentID int not null auto_increment,
    DepartmentName varchar(100),
    PRIMARY KEY(DepartmentID)
);

/* Bảng 2 */
create table `Position` (
	PositionID int not null auto_increment,
    PositionName enum('Dev','Test','Scrum Master','PM'),
    PRIMARY KEY(PositionID)
);

/* Bảng 3 */
create table `Account` (
	AccountID int not null auto_increment,
    Email varchar(100),
    UserName varchar(100),
    FullName varchar(100),
    DepartmentID int not null,
    PositionID int not null,
    CreateDate timestamp null default current_timestamp,
    PRIMARY KEY(AccountID)
);

/* Bảng 4 */
create table `Group` (
	GroupID int not null auto_increment,
    GroupName varchar(100) null,
    CreatorID int not null,
    CreateDate timestamp null default current_timestamp,
    PRIMARY KEY(GroupID)
);

/* Bảng 5 */
create table GroupAccount (
	GroupID int not null,
    AccountID int not null,
    JoinDate datetime null default current_timestamp
);

/* Bảng 6 */
create table TypeQuestion (
	TypeID int not null auto_increment,
    TypeName enum('Essay','Multiple-Choice') not null,
    primary key(TypeID)
);

/* Bảng 7 */
create table CategoryQuestion (
	CategoryID int not null auto_increment,
    CategoryName varchar(100),
    primary key(CategoryID)
);

/* Bảng 8 */
create table Question (
	QuestionID int not null auto_increment,
    Content text,
    CategoryID int not null,
    TypeID int not null,
    CreatorID int not null,
    CreateDate datetime null default current_timestamp,
    PRIMARY KEY(QuestionID)
);

/* Bảng 9 */
create table Answer (
	AnswerID int not null auto_increment,
    Content text,
    QuestionID int not null,
    isCorrect boolean,
    primary key(AnswerID)
);

/* Bảng 10 */
create table Exam (
	ExamID int not null auto_increment,
    `Code` varchar(20),
    Title varchar(100),
    CategoryID int not null,
    Duration int,
    CreatorID int not null,
    CreateDate timestamp null default current_timestamp,
    primary key(ExamID)
);

/* Bảng 11 */
create table ExamQuestion (
	ExamID int not null,
    QuestionID int not null
);

