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
SELECT 
    [Студент] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
	[Возраст] = DATEDIFF(HOUR,birth_date,GETDATE())/8766
FROM  Students
WHERE birth_date > N'1991-01-01' AND birth_date < N'2001-01-01';

