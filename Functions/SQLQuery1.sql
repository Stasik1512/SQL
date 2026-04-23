USE P_421_Import
GO
CREATE FUNCTION GetTeacherID
(
	@name AS NVARCHAR(50)
)
RETURNS SMALLINT
AS
BEGIN
	RETURN (SELECT teacher_id FROM Teachers WHERE last_name=@name OR first_name=@name);
END