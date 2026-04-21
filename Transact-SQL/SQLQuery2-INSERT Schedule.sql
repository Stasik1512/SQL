----SQLQuery2-INSERT Schedule
--USE P_421_Import;
--SET DATEFIRST 1; -- ПН 1, ВТ 2, СР 3, ЧТ 4, ПТ 5

--DECLARE @group				AS INT		= (SELECT group_id FROM Groups WHERE group_name = N'P_421');
--DECLARE @discipline			AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%MS SQL Server');
--DECLARE @number_of_lessons	AS SMALLINT = (SELECT  number_of_lessons FROM Disciplines WHERE discipline_name LIKE N'%MS SQL Server');
--DECLARE @lesson_number		AS TINYINT	= 0;
--DECLARE @teacher			AS SMALLINT = (SELECT teacher_id FROM Teachers WHERE first_name LIKE N'Олег');
--DECLARE @start_date			AS DATE		= N'2026-03-26';
--DECLARE @date				AS DATE		= @start_date;
--DECLARE @start_time			AS TIME(0)  = N'14:00';
--DECLARE @time				AS TIME(0)  = @start_time;

--WHILE @lesson_number < @number_of_lessons
--BEGIN 
--	SET @time = @start_time;
--	PRINT FORMATMESSAGE(N'%s %s %s %i', CAST(@date AS NVARCHAR), CAST(@time AS NVARCHAR), DATENAME(WEEKDAY,@date), @lesson_number + 1);
--	SET @time = DATEADD(MINUTE,95,@time);
--	INSERT Schedule([group], discipline, teacher, [date], [time], spent)
--	VALUES (@group, @discipline , @teacher, @date, @time , IIF(@date<GETDATE(),1,0));
--	SET @lesson_number +=1;

--	PRINT FORMATMESSAGE(N'%s %s %s %i', CAST(@date AS NVARCHAR), CAST(@time AS NVARCHAR), DATENAME(WEEKDAY,@date), @lesson_number + 1);
--	INSERT Schedule([group], discipline, teacher, [date], [time], spent)
--	VALUES (@group, @discipline , @teacher, @date, @time , IIF(@date<GETDATE(),1,0));
--	SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date)=2,2,5),@date);
--	SET @lesson_number +=1;
--	PRINT N'---------------------------------------------------------------------------------------'
--END

--HOMEWORK
USE P_421_Import;
SET DATEFIRST 1; -- ПН 1, ВТ 2, СР 3, ЧТ 4, ПТ 5

DECLARE @group				AS INT		= (SELECT group_id FROM Groups WHERE group_name = N'P_421');
DECLARE @discipline			AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%MS SQL Server');
DECLARE @number_of_lessons	AS SMALLINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_name LIKE N'%MS SQL Server');
DECLARE @lesson_number		AS TINYINT	= 0;
DECLARE @teacher			AS SMALLINT = (SELECT teacher_id FROM Teachers WHERE first_name LIKE N'Олег');
DECLARE @start_date			AS DATE		= N'2026-03-26';
DECLARE @date				AS DATE		= @start_date;
DECLARE @start_time			AS TIME(0)	= N'14:00';
DECLARE @time				AS TIME(0)  = @start_time;

WHILE @lesson_number < @number_of_lessons
BEGIN 
	-- 1 пара
	SET @time = @start_time;
	PRINT FORMATMESSAGE(N'%s %s %s %i', CAST(@date AS NVARCHAR), CAST(@time AS NVARCHAR), DATENAME(WEEKDAY,@date), @lesson_number + 1);
	IF NOT EXISTS 
	(
        SELECT 1 FROM Schedule 
        WHERE [group] = @group 
          AND discipline = @discipline 
          AND teacher = @teacher 
          AND [date] = @date 
          AND [time] = @time
    )
    BEGIN
        INSERT Schedule([group], discipline, teacher, [date], [time], spent)
        VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
        PRINT N'-> Вставлена 1-я пара';
    END
    ELSE
    BEGIN
        PRINT N'-> Дубликат 1-й пары пропущен';
    END
	SET @lesson_number += 1;
	

	-- 2 пара
	SET @time = DATEADD(MINUTE, 95, @time);
	PRINT FORMATMESSAGE(N'%s %s %s %i', CAST(@date AS NVARCHAR), CAST(@time AS NVARCHAR), DATENAME(WEEKDAY,@date), @lesson_number + 1);
	IF NOT EXISTS 
	(
        SELECT 1 FROM Schedule 
        WHERE [group] = @group 
          AND discipline = @discipline 
          AND teacher = @teacher 
          AND [date] = @date 
          AND [time] = @time
    )
    BEGIN
        INSERT Schedule([group], discipline, teacher, [date], [time], spent)
        VALUES (@group, @discipline, @teacher, @date, @time, IIF(@date < GETDATE(), 1, 0));
        PRINT N'-> Вставлена 2-я пара';
    END
    ELSE
    BEGIN
        PRINT N'-> Дубликат 2-й пары пропущен';
    END
	SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date) = 2, 2, 5), @date);
	SET @lesson_number += 1;
	PRINT N'-----------------------------------------------------------------------------------------------------------------------------------------------------------'
END




