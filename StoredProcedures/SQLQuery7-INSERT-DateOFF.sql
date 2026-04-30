--SQLQuery7-INSERT-DateOFF.sql
USE P_421_Import
SET DATEFIRST 1;
GO
CREATE OR ALTER PROCEDURE sp_InsertDayOFF
	@holiday AS TINYINT,
	@date AS DATE	OUTPUT,
	@day AS TINYINT	OUTPUT
AS
BEGIN
	INSERT DaysOFF([date], holiday)VALUES (@date, @holiday);
		SET @day+=1;
		SET @date = DATEADD(DAY,1,@date);
END