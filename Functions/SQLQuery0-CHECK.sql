USE P_421_Import;
SET DATEFIRST 1;
--PRINT dbo.GetTeacherID(N'Антон');

PRINT dbo.GetNextLearningDay(N'P_421',N'2026-04-25');
PRINT dbo.GetNextLearningDate(N'P_421', N'2026-04-25');