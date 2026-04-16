--SQLQuery5-CREATE HOMEWORK
USE P_421_DDL;

CREATE TABLE Homework
(
	lesson BIGINT PRIMARY KEY CONSTRAINT FK_Homework_Schedule FOREIGN KEY REFERENCES Schedule(lesson_id),
	task NVARCHAR(1024) NOT NULL,
	[date] VARBINARY(MAX) NULL,
	dedline DATE NOT NULL,
);

CREATE TABLE HWresults 
(
	student INT CONSTRAINT FK_HWresults_Students FOREIGN KEY REFERENCES Students(student_id),
	lesson BIGINT CONSTRAINT FK_HWresults_Schedule FOREIGN KEY REFERENCES Schedule(lesson_id),
	PRIMARY KEY (student, lesson),
	[date] DATE NOT NULL,
	answer NVARCHAR(1024) NOT NULL,
	grade TINYINT CONSTRAINT CK_HWresults CHECK(grade > 0 AND grade <= 12)

);