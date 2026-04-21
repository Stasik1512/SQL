--SQLQuery1-SELECT Schedule
--USE P_421_Import;
--SELECT * FROM Schedule;

--HOMEWORK

USE P_421_Import;
SET LANGUAGE Russian;
--DELETE FROM Schedule;

SELECT 
    ROW_NUMBER() OVER (ORDER BY s.[date], s.[time])											AS [№],
    (SELECT group_name FROM Groups WHERE group_id = s.[group])								AS [Группа],
    (SELECT discipline_name FROM Disciplines WHERE discipline_id = s.discipline)			AS [Дисциплина],
    (SELECT CONCAT(last_name, ' ', first_name) FROM Teachers WHERE teacher_id = s.teacher)  AS [Преподаватель],
    FORMAT(s.[date], 'dd.MM.yyyy')															AS [Дата],
    DATENAME(WEEKDAY, s.[date])																AS [День недели],
    CAST(s.[time] AS VARCHAR(5))															AS [Время],
    CASE 
        WHEN s.spent = 1 THEN N'Проведено'
        ELSE N'Не проведено'
    END AS [Статус]
FROM Schedule s
ORDER BY s.[date], s.[time];
