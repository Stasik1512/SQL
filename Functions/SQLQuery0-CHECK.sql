USE P_421_Import;
SET DATEFIRST 1;
--PRINT dbo.GetTeacherID(N'Антон');

PRINT dbo.GetNextLearningDay(N'Java_326',N'2026-04-30');
PRINT dbo.GetNextLearningDate(N'Java_326', N'2026-04-30');
