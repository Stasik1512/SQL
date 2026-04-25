--SQLQuery2-GetNextLeaningDate.sql
USE P_421_ImporT;
SET DATEFIRST 1;
GO
CREATE OR ALTER FUNCTION GetNextLearningDate(@group_name AS NVARCHAR(10), @date AS DATE) RETURNS DATE
AS
BEGIN
	DECLARE @interval AS SMALLINT =	dbo.GetNextLearningDay(@group_name,@date) - DATEPART(WEEKDAY, @date);
	IF @interval < 0 SET @interval = 7+@interval;
	RETURN DATEADD(DAY, @interval, @date);
END