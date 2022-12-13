USE master
GO

CREATE DATABASE labs;
GO

USE labs;

CREATE TABLE departments (
	id INT IDENTITY(1,1) NOT NULL,
	department_name NVARCHAR(30) NOT NULL,
	faculty NVARCHAR(30) NOT NULL,
	head_name NVARCHAR(MAX) NOT NULL,
	room_num INT NOT NULL,
	frame_num INT NOT NULL,
	phone NVARCHAR(20) NOT NULL,
	teachers_num INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE disciplines (
	id INT IDENTITY(1,1) NOT NULL,
	name NVARCHAR(MAX) NOT NULL,
	dep_id INT NOT NULL,
	time INT NOT NULL,
	result NVARCHAR(MAX) NOT NULL,
	FOREIGN KEY (dep_id) REFERENCES departments (id) ON DELETE CASCADE,
	PRIMARY KEY (id)
);

CREATE TABLE students (
	id INT IDENTITY(1,1) NOT NULL,
	surname NVARCHAR(MAX) NOT NULL,
	first_name NVARCHAR(MAX) NOT NULL,
	patronymic NVARCHAR(MAX) NOT NULL,
	dep_id INT NOT NULL,
	year_of_birth DATE NOT NULL,
	gender VARCHAR(1) NOT NULL,
	address NVARCHAR(MAX) NOT NULL,
	city NVARCHAR(MAX) NOT NULL,
	phone NVARCHAR(MAX) NOT NULL,
	FOREIGN KEY (dep_id) REFERENCES departments (id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);

CREATE TABLE teachers (
	id INT IDENTITY(1,1) NOT NULL,
	surname NVARCHAR(MAX) NOT NULL,
	first_name NVARCHAR(MAX) NOT NULL,
	patronymic NVARCHAR(MAX) NOT NULL,
	dep_id INT NOT NULL,
	year_of_birth DATE NOT NULL,
	year_of_admission DATE NOT NULL,
	work_experience INT NOT NULL,
	post NVARCHAR(40) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	address NVARCHAR(MAX) NOT NULL,
	city NVARCHAR(MAX) NOT NULL,
	phone NVARCHAR(MAX) NOT NULL,
	FOREIGN KEY (dep_id) REFERENCES departments (id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);

CREATE TABLE progress (
	id INT IDENTITY(1,1) NOT NULL,
	teach_id INT NOT NULL,
	dis_id INT NOT NULL,
	student_id INT NOT NULL,
	mark INT NOT NULL,
	FOREIGN KEY (teach_id) REFERENCES teachers (id) ON DELETE NO ACTION,
	FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE NO ACTION,
	FOREIGN KEY (dis_id) REFERENCES disciplines (id) ON DELETE NO ACTION,
	PRIMARY KEY (id)
);

INSERT INTO departments VALUES ('����', '��', '�������',410,1,'86-01',21);
INSERT INTO departments VALUES ('����1', '��1', '�������1',411,1,'86-02',21);
INSERT INTO departments VALUES ('����2', '��2', '�������2',412,2,'86-03',11);
INSERT INTO departments VALUES ('����3', '��3', '�������3',413,3,'86-04',57);
INSERT INTO departments VALUES ('����4', '��4', '�������4',414,4,'86-05',5);

INSERT INTO teachers VALUES ('��������', '������', '����������',1,'1972-11-24','2001-04-15',12,'�������������', '�', '����������� 4, ��. 17','�����', '+375 (29) 254-57-54');
INSERT INTO teachers VALUES ('��������1', '������1', '����������1',2,'1972-11-24','2001-04-15',14,'�������������1', '�', '����������� 4, ��. 17','������', '+375 (29) 358-57-54');
INSERT INTO teachers VALUES ('��������2', '������2', '����������2',3,'1972-11-24','2001-04-15',8,'�������������2', '�', '����������� 4, ��. 17','����������', '+375 (29) 264-54-54');
INSERT INTO teachers VALUES ('��������3', '������3', '����������3',4,'1972-11-24','2001-04-15',2,'�������������3', '�', '����������� 4, ��. 17','��������', '+375 (29) 234-58-54');

INSERT INTO students VALUES ('���������', '������', '����������',4,'2001-11-24', '�', '����������� 4, ��. 17','�����', '+375 (29) 254-57-54');
INSERT INTO students VALUES ('���������1', '������1', '����������1',2,'2001-11-14', '�', '����������� 4, ��. 17','�������', '+375 (29) 254-57-54');
INSERT INTO students VALUES ('���������2', '������2', '����������2',3,'2003-11-04', '�', '����������� 4, ��. 17','�����', '+375 (29) 254-57-54');
INSERT INTO students VALUES ('���������3', '������3', '����������3',1,'2009-11-18', '�', '����������� 4, ��. 17','�����', '+375 (29) 254-57-54');

INSERT INTO disciplines VALUES ('����������', 1, 124,'�������');
INSERT INTO disciplines VALUES ('������', 1, 141,'�������');
INSERT INTO disciplines VALUES ('���', 3, 89,'�����');
INSERT INTO disciplines VALUES ('��', 2, 57,'�������');

INSERT INTO progress VALUES (1, 1, 1,10);
INSERT INTO progress VALUES (2, 3, 2,5);
INSERT INTO progress VALUES (3, 4, 3,8);
INSERT INTO progress VALUES (4, 2, 4,4);


DECLARE @mytable TABLE (id INT, myname CHAR(20) DEFAULT '��������� ������')
INSERT INTO @mytable(id) VALUES (1)
INSERT INTO @mytable(id, myname) VALUES (2,'�������� �����') 
SELECT * FROM @mytable

DECLARE @a INT 
DECLARE @str CHAR(30)
SET @a = (SELECT COUNT(*) FROM departments) 
IF @a >10 BEGIN
SET @str = '���������� ������ ������ 10' SELECT @str
END ELSE BEGIN
SET @str = '���������� ������ = ' + str(@a) SELECT @str
END

DECLARE @a INT 
DECLARE @str CHAR(30)
SET @a = (SELECT COUNT(*) FROM students WHERE gender = '�') 
IF @a > 5 BEGIN
SET @str = '���������� ������ ������ 5' SELECT @str
END ELSE BEGIN
SET @str = '���������� ������ = ' + str(@a) SELECT @str
END


DECLARE @a INT SET @a = 1 WHILE @a <100
BEGIN
PRINT @a -- ����� �� ����� �������� ���������� 
IF (@a>40) AND (@a<50)
BREAK --����� � ���������� 1-� ������� �� ������
ELSE
SET @a = @a+rand()*10 
CONTINUE
END
 PRINT @a

DECLARE @a INT SET @a = 1 WHILE @a <50
BEGIN
PRINT @a -- ����� �� ����� �������� ���������� 
IF (@a>40) AND (@a<50)
BREAK --����� � ���������� 1-� ������� �� ������
ELSE
SET @a = @a+rand()*10 
CONTINUE
END
 PRINT @a


 IF OBJECT_ID (N'dbo.ISOweek', N'FN') IS NOT NULL 
DROP FUNCTION dbo.ISOweek;

GO
CREATE FUNCTION dbo.ISOweek (@DATE date) RETURNS CHAR(15)
WITH EXECUTE AS CALLER AS
BEGIN
DECLARE @man int; 
DECLARE @ISOweek char(15); 
SET @man= MONTH(@DATE)

IF (@man=1) SET @ISOweek='������'; 
IF (@man=2) SET @ISOweek='�������';
IF (@man=3) SET @ISOweek='����';
IF (@man=4) SET @ISOweek='������'; 
IF (@man=5) SET @ISOweek='���';
IF (@man=6) SET @ISOweek='����'; 
IF (@man=7) SET @ISOweek='����';
IF (@man=8) SET @ISOweek='������';
IF (@man=9) SET @ISOweek='��������'; 
IF (@man=10) SET @ISOweek='�������'; 
IF (@man=11) SET @ISOweek='������';
IF (@man=12) SET @ISOweek='�������';

RETURN(@ISOweek); 
END;

GO
SET DATEFIRST 1;
SELECT dbo.ISOweek('12.04.2004') AS '�����';



IF OBJECT_ID (N'SalesByStore', N'IF') IS NOT NULL
DROP FUNCTION SalesByStore; 
GO
CREATE FUNCTION SalesByStore(@storeid NVARCHAR) RETURNS TABLE
AS RETURN (
SELECT d.department_name AS "�������", t.first_name AS "���",
t.gender AS "���" FROM departments d, teachers t
WHERE d.id =t.dep_id and t.gender = @storeid
);

GO
SELECT * from SalesByStore('�');

CREATE PROCEDURE Count_Assistent 
AS
Select COUNT(gender) from teachers
where gender = '�' 
Go

EXECUTE Count_Assistent

CREATE PROCEDURE Count_Student 
AS
Select COUNT(dep_id) from teachers
where dep_id = 1 
Go

EXECUTE Count_Student


CREATE PROCEDURE Count_Teachers @dep_id as Int
AS
Select count(gender) from teachers
WHERE gender='�' and dep_id = @dep_id 
Go

EXEC Count_Teachers 1


CREATE PROCEDURE Count_Students @first_name as NVARCHAR
AS
Select count(*) from students
WHERE gender='�' and first_name = @first_name 
Go

EXEC Count_Students '������'


CREATE PROCEDURE checkname @param int AS
IF (SELECT patronymic FROM students WHERE id = @param)
= '����������'
RETURN 1 ELSE RETURN 2

DECLARE @return_status int
EXECUTE @return_status = checkname 15 SELECT 'Return Status' = @return_status 


CREATE PROCEDURE checknam @param int AS
IF (SELECT patronymic FROM teachers WHERE id = @param)
= '����������'
RETURN 1 ELSE RETURN 2

DECLARE @return_status int
EXECUTE @return_status = checknam 15 SELECT 'Return Status' = @return_status 


CREATE PROC update_proc AS
UPDATE students SET city = '�����'

EXEC update_proc



CREATE PROC update_pro AS
UPDATE teachers SET city = '�����'

EXEC update_pro


CREATE PROC select_zavkaf @k CHAR(10) AS
SELECT * FROM departments WHERE head_name=@k

EXEC select_zavkaf '�������'


CREATE PROC selects @k CHAR(10) AS
SELECT * FROM teachers WHERE patronymic=@k

EXEC selects '����������'

-- 2 �����

CREATE FUNCTION Calculator (@Opd1 bigint, @Opd2 bigint, @Oprt CHAR(1) = '*') RETURNS bigint
AS BEGIN
DECLARE @Result bigint SET @Result = CASE @Oprt
WHEN '+' THEN @Opd1 + @Opd2 WHEN '-' THEN @Opd1 - @Opd2
WHEN '*' THEN @Opd1 * @Opd2 WHEN '/' THEN @Opd1 / @Opd2 ELSE 0
END
Return @Result END

SELECT dbo.Calculator(4,5, '+'),dbo.Calculator(3,7, '*') - dbo.Calculator(64, 4,'/')*2



CREATE FUNCTION DYNTAB (@state int)
RETURNS Table 
AS RETURN SELECT id, first_name, surname FROM teachers WHERE dep_id = @state

SELECT * FROM DYNTAB (1)
ORDER BY surname, first_name



CREATE FUNCTION Parse (@String nvarchar (500))
RETURNS @tabl TABLE
(Number int IDENTITY (1,1) NOT NULL,
Substr nvarchar (30)) AS
BEGIN
DECLARE @Str1 nvarchar (500), @Pos int SET @Str1 = @String
WHILE 1>0 BEGIN
SET @Pos = CHARINDEX(' ', @Str1) IF @POS>0
BEGIN
INSERT INTO @tabl
VALUES (SUBSTRING (@Str1, 1, @Pos)) END
ELSE BEGIN
INSERT INTO @tabl VALUES (@Str1) BREAK
END END RETURN END

DECLARE @TestString nvarchar (500)
Set @TestString = 'SQL Server 2019' SELECT * FROM Parse(@TestString)