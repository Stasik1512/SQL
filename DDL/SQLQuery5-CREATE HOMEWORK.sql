--SQLQuery5-CREATE HOMEWORK
USE P_421_DDL;

CREATE TABLE Homework
(
	lesson BIGINT CONSTRAINT FK_Homework_Schedule FOREIGN KEY REFERENCES Schedule(lesson_id),
	task NVARCHAR(1024) NOT NULL,
	[date] VARBINARY(MAX) NULL,
	dedline DATE NOT NULL,
);

CREATE TABLE HWresults 
(
	student INT PRIMARY KEY,
	lesson BIGINT CONSTRAINT FK_HWresults_Schedule FOREIGN KEY REFERENCES Schedule(lesson_id),
	[date] DATE NOT NULL,
	answer NVARCHAR(1024) NOT NULL,
	grade TINYINT CONSTRAINT CK_Grade CHECK(grade > 0 AND grade <= 12)
);