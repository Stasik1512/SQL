USE P_421_Import;
SET DATEFIRST 1;
--PRINT dbo.GetTeacherID(N'Антон');

--PRINT dbo.GetNextLearningDay(N'Java_326',N'2026-04-30');
--PRINT dbo.GetNextLearningDate(N'Java_326', N'2026-04-30');


--PRINT dbo.GetNextYearHolidaysStartDay(2027);
--PRINT dbo.GetSummerHolidaysStartDate(2023);
--PRINT dbo.GetEasterDate(2025);
PRINT dbo.GetHolidaysStartDate(2026,N'Летние%');