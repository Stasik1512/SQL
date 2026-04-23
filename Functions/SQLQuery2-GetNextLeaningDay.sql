--SQLQuery2-GetNextLeaningDay.sql
USE P_421_Import;
GO
CREATE FUNCTION GetNextLearningDay(@date AS DATE, @group_name AS NVARCHAR(10))RETURNS TINYINT
AS
BEGIN
	DECLARE @learning_days AS TINYINT = (SELECT learning_days FROM Groups WHERE group_name=@group_name)
	DECLARE @days AS TINYINT = DATEPART(WEEKDAY, @date)+1;
END