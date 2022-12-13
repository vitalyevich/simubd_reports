USE university;

CREATE TABLE facultet (
	kod_faculteta INT IDENTITY(1,1),
	name_faculteta NVARCHAR(20) NOT NULL,
	fio_decana NVARCHAR(MAX) UNIQUE NOT NULL,
	nomer_komatu INT NOT NULL,
	tel_decanata NVARCHAR(30) NOT NULL,
	PRIMARY KEY (kod_faculteta),
);

CREATE TABLE kafedra (
	kod_kafedru INT IDENTITY(1,1),
	kod_faculteta INT NOT NULL,
	name_kafedru NVARCHAR(20) NOT NULL,
	fio_zavkaf NVARCHAR(MAX) NOT NULL,
	nomer_komnatu INT NOT NULL,
	num_korpusa INT NOT NULL,
	tel_kafedru NVARCHAR(20) NOT NULL,
	FOREIGN KEY (kod_faculteta) REFERENCES facultet (kod_faculteta) ON DELETE CASCADE, 
	PRIMARY KEY (kod_kafedru),
);

CREATE TABLE students (
	student_id INT IDENTITY(1,1),
	sutname NVARCHAR(20) NOT NULL,
	sutfname NVARCHAR(40) NOT NULL,
	stipend FLOAT CHECK (stipend <= 500) NOT NULL,
	kurs INT CHECK (kurs >= 1 AND kurs <= 4) NOT NULL,
	city NVARCHAR(30) NOT NULL,
	birthday DATETIME NOT NULL,
	student_group NVARCHAR(6) NOT NULL,
	kod_kafedru INT NOT NULL,
	PRIMARY KEY (student_id),
	FOREIGN KEY (kod_kafedru) REFERENCES kafedra (kod_kafedru) ON DELETE CASCADE,
);

CREATE TABLE teachers (
	kod_teacher INT IDENTITY(1,1),
	kod_kafedru INT NOT NULL,
	name_teacher NVARCHAR(20) NOT NULL,
	indef_kod BIGINT UNIQUE NOT NULL,
	dolgnost NVARCHAR(30) DEFAULT '���������' CHECK (dolgnost IN ('���������', '������', '������� �������������', '���������')) NOT NULL,
	zvanie NVARCHAR(10) DEFAULT '���' CHECK (zvanie IN ('�.�.�', '�.�.�', '�.�.�', '�.�.�.�.', '�.�.�', '�.�.�', '�.�.�', '�.�.�.�', '���')) NOT NULL,
	salary FLOAT DEFAULT '1000' CHECK (salary > 0) NULL,
	rise INT DEFAULT '0' CHECK (rise >= 0) NOT NULL,
	data_hire DATETIME DEFAULT GETDATE() NOT NULL,
	birthday DATETIME NOT NULL,
	pol VARCHAR(1) CHECK (pol IN ('�', '�', '�', '�')) NOT NULL,
	tel_teacher NVARCHAR(20) CHECK (tel_teacher LIKE '[1-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
	PRIMARY KEY (kod_teacher),
	FOREIGN KEY (kod_kafedru) REFERENCES kafedra (kod_kafedru) ON DELETE CASCADE,
);

INSERT INTO facultet 
	 VALUES ('���������1', '�������� ������ ��������', 245, '456445');
INSERT INTO facultet 
	 VALUES ('���������2', '����� ������ ��������', 125, '254245');
INSERT INTO facultet 
	 VALUES ('���������3', '����� ������ ��������', 685, '782782');
INSERT INTO facultet 
	 VALUES ('���������4', '����� ������ ��������', 247, '542452');

INSERT INTO kafedra 
	 VALUES (1, '�������1', '��������', 454,1,'565655');
INSERT INTO kafedra 
	 VALUES (1, '�������2', '��������2', 252,2,'454578');
INSERT INTO kafedra 
	 VALUES (1, '�������3', '��������3', 783,3,'244522');
INSERT INTO kafedra 
	 VALUES (1, '�������4', '��������4', 247,4,'252422');

INSERT INTO students 
	 VALUES ('�������', '������', 245, 2, '�����', '1998-05-09','255454',1);
INSERT INTO students 
	 VALUES ('�������2', '������2', 100, 3, '�����', '1998-05-09','255454',2);
INSERT INTO students 
	 VALUES ('�������3', '������3', 342, 1, '�����', '1998-05-09','255454',3);
INSERT INTO students 
	 VALUES ('�������4', '������4', 478, 4, '�����', '1998-05-09','255454',4);

INSERT INTO teachers 
	 VALUES (1, '�������1', 454, '���������', '�.�.�', 584, 0, '2022-09-26', '1970-04-15', '�', '25-45-54');
INSERT INTO teachers 
	 VALUES (2, '�������2', 257, '���������', '�.�.�.�.', 584, 0, '2022-09-26', '1998-04-15', '�', '10-25-86');
INSERT INTO teachers 
	 VALUES (3, '�������3', 856, '������', '�.�.�', 584, 0, '2022-09-26', '1978-04-15', '�', '18-82-54');
INSERT INTO teachers 
	 VALUES (4, '�������4', 952, '���������', '�.�.�', 584, 0, '2022-09-26', '1970-02-14', '�', '12-47-01');

SELECT * 
  FROM students 
 WHERE kurs = 2;

SELECT * 
  FROM teachers 
 WHERE salary > 500;
SELECT * 
  FROM teachers 
 WHERE name_teacher = '�������1';

SELECT * 
  FROM students 
WHERE kurs = 2 AND stipend < 500;
SELECT * 
  FROM students 
WHERE kurs = 2 OR kurs = 3;
SELECT * 
  FROM teachers 
 WHERE NOT dolgnost = '���������';

SELECT name_teacher 
  FROM teachers
 WHERE (salary + rise) / 2 > 5 * rise;

SELECT name_teacher AS '������� �������������', salary + rise AS '��� ��������'
  FROM teachers
 WHERE salary + rise < 3500;

SELECT name_kafedru, num_korpusa 
  FROM kafedra
 WHERE num_korpusa IN ('1', '3', '12');

SELECT name_kafedru AS '�������� �������', num_korpusa AS '������'
  FROM kafedra
 WHERE num_korpusa NOT IN ('1', '3', '12');

SELECT name_teacher 
  FROM teachers
 WHERE salary BETWEEN 500 AND 1000;

SELECT name_kafedru, num_korpusa 
  FROM kafedra
 WHERE NOT (num_korpusa BETWEEN '1' AND '3');

SELECT name_teacher 
  FROM teachers
 WHERE UPPER(name_teacher) LIKE '�%';

SELECT name_kafedru 
  FROM kafedra
 WHERE LOWER(name_kafedru) LIKE '%�%';

SELECT name_teacher, indef_kod, tel_teacher 
  FROM teachers
 WHERE indef_kod IS NULL OR tel_teacher IS NOT NULL;

 SELECT * 
   FROM teachers, students, kafedra;

SELECT DISTINCT k.name_kafedru 
		   FROM kafedra k, students s
		  WHERE k.kod_kafedru = s. kod_kafedru AND s.stipend > 400;



SELECT DISTINCT kafedra.name_kafedru 
FROM facultet, kafedra, teachers
WHERE facultet.kod_faculteta = kafedra.kod_faculteta AND kafedra.kod_kafedru = teachers.kod_kafedru 
  AND facultet.name_faculteta ='���������1' 
  AND teachers.dolgnost = '���������';

SELECT kafedra.name_kafedru AS '�������� �������', teachers.name_teacher AS '������� �������������' 
  FROM  kafedra LEFT JOIN teachers
    ON kafedra.kod_kafedru = teachers.kod_kafedru;

SELECT kafedra.name_kafedru AS '�������� �������', teachers.name_teacher AS '������� �������������' 
FROM kafedra RIGHT JOIN teachers
ON kafedra.kod_kafedru = teachers.kod_kafedru;

SELECT kafedra.name_kafedru AS '�������� �������', teachers.name_teacher AS '������� �������������' 
  FROM kafedra CROSS JOIN teachers ORDER BY kafedra.kod_kafedru;

SELECT f.name_faculteta AS '���������', k.name_kafedru AS '�������', t.name_teacher AS '�������������' 
  FROM facultet f JOIN kafedra k
    ON f.kod_faculteta =k.kod_faculteta JOIN teachers t
    ON k.kod_kafedru = t.kod_kafedru;

SELECT SUM(salary)
  FROM teachers
 WHERE LOWER(dolgnost) = '���������';

SELECT COUNT(DISTINCT t.dolgnost) 
  FROM kafedra d, teachers t
 WHERE d.kod_kafedru = t.kod_kafedru AND LOWER(d.name_kafedru) = '�������1';

SELECT MAX(salary + rise)
  FROM teachers;

SELECT UPPER(name_teacher) AS "��� ���������"
  FROM teachers;

SELECT num_korpusa AS "������", COUNT(*) AS "K-�o ������" 
  FROM kafedra GROUP BY num_korpusa ;

SELECT salary + rise, COUNT(*) 
  FROM teachers
 WHERE salary + rise <= 1500 GROUP BY salary + rise;

SELECT MIN(salary), MAX(rise), SUM(salary + rise) 
  FROM teachers
HAVING SUM(salary + rise) < 15000;

SELECT name_teacher, salary + rise 
  FROM teachers
WHERE LOWER(dolgnost ) = '��c������' ORDER BY salary + rise;

SELECT name_teacher, data_hire 
  FROM teachers
 WHERE LOWER(dolgnost) = '���������' ORDER BY data_hire ASC;

UPDATE teachers
   SET salary = salary * 1.1, rise = rise * 1.1 
 WHERE LOWER(dolgnost ) = '���������';

DELETE FROM teachers WHERE kod_kafedru = 1;
