--SQLQuery7Holidays.sql
USE P_421_Import

--CREATE TABLE Holidays

--(
--	holiday_id TINYINT PRIMARY KEY,
--	holiday_name NVARCHAR(150) NOT NULL,
--	[month] TINYINT NULL,
--	[day] TINYINT NULL,
--	duration TINYINT NOT NULL
--)

--CREATE TABLE DaysOFF
--(
--	[date] DATE PRIMARY KEY,
--	holiday TINYINT CONSTRAINT FK_DaysOFF_Holidays FOREIGN KEY REFERENCES Holidays(holiday_id)
--);

INSERT Holidays (holiday_id, holiday_name,[month], [day], duration)
VALUES	(1, N'Новый год',			1, 1, 14),
		(2, N'23 февраля',			2, 23, 1),
		(3, N'8 марта',				3, 8 ,3),
		(4, N'Пасха',				null, null, 3),
		(5, N'Майские праздники',	5, 1, 10),
		(6, N'Летние каникулы',		null, null, 14)