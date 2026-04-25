--SQLQuery1.-SELECT Schedule.sql
USE P_421_Import;
GO

--sp_ = StoredProcedure
ALTER PROCEDURE sp_SelectSchedule
AS
BEGIN
	SELECT
		[Группа] = group_name,
		[Дата] = [date],
		[Время] = [time],
		[День] = DATENAME(WEEKDAY, [date]),
		[Дисциплина] = discipline_name,
		[Преподаватель] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name)
	FROM Schedule,Groups, Disciplines, Teachers
	WHERE [group] = group_id
	AND discipline = discipline_id
	AND teacher = teacher_id
END