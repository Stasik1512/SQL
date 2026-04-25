--SQLQuery2-GetNextLeaningDay.sql
USE P_421_Import;
SET DATEFIRST 1;
GO
ALTER FUNCTION GetNextLearningDay(@group_name AS NVARCHAR(10), @date AS DATE)RETURNS TINYINT
AS
BEGIN
	DECLARE @learning_days	AS TINYINT = (SELECT learning_days FROM Groups WHERE group_name=@group_name)
	DECLARE @days			AS TINYINT = DATEPART(WEEKDAY, @date);
	WHILE @days < 14
	BEGIN
		IF (POWER(2,@days%7)) & @learning_days <> 0 RETURN @days%7+1;
		SET @days+=1;
	END
	RETURN @days%7+1;

END