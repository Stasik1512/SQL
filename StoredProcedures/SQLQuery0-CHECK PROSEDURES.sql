--SQLQuery0-CHECK PROSEDURES

USE P_421_Import;
SET DATEFIRST 1;
--DELETE FROM Schedule;

--EXECUTE sp_InsertSchedule N'P_421', N'%MS SQL Server',N'Олег', N'2026-03-26', N'14:00'
--EXECUTE sp_InsertSchedule N'P_421', N'%ADO.NET',N'Олег', N'2026-04-25',N'14:00'
--EXECUTE sp_SelectSchedule;

--EXEC sp_SetAllHolidaysFor 2026;

--SELECT [date],holiday_name
--FROM DaysOFF
--JOIN Holidays ON (holiday = holiday_id)
EXECUTE sp_InsertSchedule
    @group_name = 'P_421',
    @discipline_name = '%ADO.NET',
    @teacher_name = 'Олег',
    @start_date = '2026-03-26',
    @start_time = '14:00',
    @days_of_week = '2, 4, 6';   -- вторник, четверг, суббота
