USE P_421_Import;

--SELECT COUNT(*) FROM Directions;
--SELECT 
--	[Направление обучения] = direction_name,
--	[Кол-во групп] = COUNT(group_id)
--FROM Groups, Directions
--WHERE direction = direction_id

--GROUP BY direction_name;

--SELECT 
--	[Группа] = group_name,
--	[Кол-во студентов] = COUNT(stud_id)
--FROM  Groups,Students
--WHERE [group] = group_id
--GROUP BY group_name



--SELECT 
--	[Направление] = direction_name,
--	[Кол-во студентов] = COUNT(stud_id)
--FROM  Students,Groups,Directions
--WHERE	direction = direction_id
--	AND	[group] = group_id
--GROUP BY direction_name;

--SELECT 
--    [Направление] = discipline_name, 
--    [Кол-во преподавателей] = COUNT(teacher) 
--FROM  TeachersDisciplinesRelation, Disciplines
--WHERE  discipline = discipline_id
--GROUP BY discipline_name
--ORDER BY COUNT(teacher) ASC;

--25-35
-- 2001 - 1991

------------------------------------------------ЗАДАНИЯ 1-3
--=1
--SELECT 
--  [Студент] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
--	[Возраст] = DATEDIFF(HOUR,birth_date,GETDATE())/8766
--FROM  Students
--WHERE birth_date > N'1991-01-01' AND birth_date < N'2001-01-01';
--SELECT 
--	[Студент] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
--	[Возраст] = DATEDIFF(HOUR,birth_date,GETDATE())/8766
--FROM  Students
--WHERE DATEDIFF(HOUR, birth_date, GETDATE())/8766 BETWEEN 20 AND 30
--ORDER BY [Возраст] 
--=2
--SELECT 
--    [Группа] = group_name,
--    [Кол-во студентов] = COUNT(stud_id) 
--FROM Students, Groups
--WHERE [group] = group_id 
--GROUP BY group_name;
SELECT 
    [Группа] = group_name,
    [Кол-во студентов] =  (SELECT COUNT(stud_id)FROM Students WHERE [group]=group_id) 
FROM Groups
WHERE (SELECT COUNT(stud_id)FROM Students WHERE [group]=group_id) = 0;


--=3
--SELECT 
--	[Группа] = group_name
--FROM Groups,Students
--WHERE stud_id = 0
