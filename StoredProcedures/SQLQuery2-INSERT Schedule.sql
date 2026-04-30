  --SQLQuery2-INSERT Schedule.
USE P_421_Import;
GO

-- Удаляем старую процедуру, если есть
--DROP PROCEDURE IF EXISTS sp_InsertSchedule;
GO

CREATE PROCEDURE sp_InsertSchedule
    @group_name NVARCHAR(10),
    @discipline_name NVARCHAR(150),
    @teacher_name NVARCHAR(50),
    @start_date DATE,
    @start_time TIME(0),
    @days_of_week NVARCHAR(20) = '2,4,6' 
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFIRST 1;

    DECLARE @group_id INT = (SELECT group_id FROM Groups WHERE group_name = @group_name);
    DECLARE @discipline_id INT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE @discipline_name);
    DECLARE @number_of_lessons TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline_id);
    DECLARE @lesson_number TINYINT = (SELECT COUNT(lesson_id) FROM Schedule WHERE [group] = @group_id AND discipline = @discipline_id);
    DECLARE @teacher_id INT = (SELECT teacher_id FROM Teachers WHERE last_name LIKE @teacher_name OR first_name LIKE @teacher_name);
    
  
    DECLARE @date DATE = @start_date;
    DECLARE @time TIME(0) = @start_time;
    DECLARE @day_of_week INT;
    DECLARE @inserted_count INT = 0;


    IF @group_id IS NULL
    BEGIN
        PRINT N'Ошибка: Группа "' + @group_name + N'" не найдена';
        RETURN;
    END
    
    IF @discipline_id IS NULL
    BEGIN
        PRINT N'Ошибка: Дисциплина "' + @discipline_name + N'" не найдена';
        RETURN;
    END
    
    IF @teacher_id IS NULL
    BEGIN
        PRINT N'Ошибка: Преподаватель "' + @teacher_name + N'" не найден';
        RETURN;
    END

    -- Проверка: ведёт ли преподаватель эту дисциплину
    IF NOT EXISTS 
    (
        SELECT 1 FROM TeachersDisciplinesRelation 
        WHERE teacher = @teacher_id AND discipline = @discipline_id
    )
    BEGIN
        PRINT N'Ошибка: Преподаватель не ведёт данную дисциплину';
        RETURN;
    END

    -- Разбираем дни недели в таблицу
    DECLARE @days_table TABLE (day_num TINYINT);
    DECLARE @pos INT = 1;
    DECLARE @token NVARCHAR(10);
    
    WHILE @pos <= LEN(@days_of_week)
    BEGIN
        SET @token = SUBSTRING(@days_of_week, @pos, CHARINDEX(',', @days_of_week + ',', @pos) - @pos);
        INSERT INTO @days_table VALUES (CAST(@token AS TINYINT));
        SET @pos = @pos + LEN(@token) + 1;
    END

    PRINT N'========================================================================';
    PRINT N'Группа: ' + @group_name + N', Дисциплина: ' + @discipline_name;
    PRINT N'Преподаватель: ' + @teacher_name + N', Дни занятий: ' + @days_of_week;
    PRINT N'Уже проведено пар: ' + CAST(@lesson_number AS NVARCHAR(3)) + N', Всего нужно: ' + CAST(@number_of_lessons AS NVARCHAR(3));
    PRINT N'========================================================================';

    WHILE @lesson_number < @number_of_lessons
    BEGIN
        SET @day_of_week = DATEPART(WEEKDAY, @date);
        
        -- Проверка: разрешён ли день недели для группы
        IF NOT EXISTS (SELECT 1 FROM @days_table WHERE day_num = @day_of_week)
        BEGIN
            PRINT CAST(@date AS NVARCHAR(10)) + N' (' + DATENAME(WEEKDAY, @date) + N') - НЕ УЧЕБНЫЙ ДЕНЬ (пропуск)';
            SET @date = dbo.GetNextLearningDate(@group_name, @date);
            CONTINUE;
        END

        -- Проверка: выходной день (из таблицы DaysOFF)
        IF EXISTS (SELECT 1 FROM DaysOFF WHERE [date] = @date)
        BEGIN
            PRINT CAST(@date AS NVARCHAR(10)) + N' (' + DATENAME(WEEKDAY, @date) + N') - ВЫХОДНОЙ (пропуск)';
            SET @date = dbo.GetNextLearningDate(@group_name, @date);
            CONTINUE;
        END

        -- Вставляем 1-ю пару
        SET @time = @start_time;
        
        -- Проверка занятости преподавателя
        IF EXISTS
		(
            SELECT 1 FROM Schedule 
            WHERE teacher = @teacher_id AND [date] = @date AND [time] = @time
        )
        BEGIN
            PRINT N'КОНФЛИКТ! Преподаватель занят ' + CAST(@date AS NVARCHAR(10)) + N' в ' + CAST(@time AS NVARCHAR(8));
            SET @date = dbo.GetNextLearningDate(@group_name, @date);
            CONTINUE;
        END
        
        EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
        SET @inserted_count = @inserted_count + 1;

        -- Вставляем 2-ю пару (если ещё не все уроки)
        IF @lesson_number < @number_of_lessons
        BEGIN
            SET @time = DATEADD(MINUTE, 95, @time);
            
            -- Проверка занятости преподавателя для 2-й пары
            IF EXISTS 
			(
                SELECT 1 FROM Schedule 
                WHERE teacher = @teacher_id AND [date] = @date AND [time] = @time
            )
            BEGIN
                PRINT N'КОНФЛИКТ! Преподаватель занят ' + CAST(@date AS NVARCHAR(10)) + N' в ' + CAST(@time AS NVARCHAR(8));
                SET @date = dbo.GetNextLearningDate(@group_name, @date);
                CONTINUE;
            END
            
            EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
            SET @inserted_count = @inserted_count + 1;
        END

        -- Переход к следующей учебной дате
        SET @date = dbo.GetNextLearningDate(@group_name, @date);
    END

    PRINT N'========================================================================';
    PRINT N'ГОТОВО: Вставлено ' + CAST(@inserted_count AS NVARCHAR(3)) + N' пар из ' + CAST(@number_of_lessons AS NVARCHAR(3));
    PRINT N'========================================================================';
END
GO