/* WHILE LOOP */

--DECLARE @Counter int

--SET @Counter=0

-- WHILE @Counter<10
--	BEGIN
--		PRINT @Counter 
--		SET @Counter=@Counter+1

--	END

/* USING WHILE LOOP WITHOUT CURSOR*/

--BEGIN
--	DECLARE @name varchar(80);
--	DECLARE @sal numeric(8,2);
--	DECLARE @grade varchar(80);
--	DECLARE @id int = 1001;

--	WHILE @id <=1009
--	BEGIN
--		SELECT @name =Firstname , @sal = Salary
--		FROM empDemographics as ed
--		JOIN empSalary as es
--		ON ed.EmployeeId=es.EmployeeId
--		WHERE ed.EmployeeId=@id
--		IF @sal>60000
--		BEGIN
--			SET @grade='A'
--		END
--		ELSE IF @sal>45000
--		BEGIN
--			SET @grade='B'
--		END
--		ELSE 
--		BEGIN
--			SET @grade='C'
--		END
--		PRINT @name + ' is in grade '+@grade

--		SET @id=@id+1
--	END
--END






/* USING WHILE LOOP WITH CURSOR*/

BEGIN
	DECLARE @name varchar(80);
	DECLARE @sal numeric(8,2);
	DECLARE @grade varchar(80);
	DECLARE @id int = 1001;

	DECLARE empCursor CURSOR FOR 
	SELECT ed. FirstName,ed.EmployeeID, es.Salary
	FROM empDemographics ed
	JOIN empSalary es
	ON ed.EmployeeId=es.EmployeeId

	OPEN empCursor

	FETCH NEXT FROM  empCursor INTO @name,@id,@sal
	WHILE @@FETCH_STATUS=0
	BEGIN
		SELECT @name =Firstname , @sal = Salary
		FROM empDemographics as ed
		JOIN empSalary as es
		ON ed.EmployeeId=es.EmployeeId
		WHERE ed.EmployeeId=@id
		IF @sal>60000
		BEGIN
			SET @grade='A'
		END
		ELSE IF @sal>45000
		BEGIN
			SET @grade='B'
		END
		ELSE 
		BEGIN
			SET @grade='C'
		END
		PRINT @name + ' is in grade '+@grade

		FETCH NEXT FROM  empCursor INTO @name,@id,@sal
	END
END

CLOSE empCursor
DEALLOCATE empCursor
