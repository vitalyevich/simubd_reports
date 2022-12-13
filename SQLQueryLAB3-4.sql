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
	dolgnost NVARCHAR(30) DEFAULT 'ассистент' CHECK (dolgnost IN ('профессор', 'доцент', 'старший преподаватель', 'ассистент')) NOT NULL,
	zvanie NVARCHAR(10) DEFAULT 'нет' CHECK (zvanie IN ('к.т.н', 'к.г.у', 'к.с.н', 'к.ф.м.н.', 'д.т.н', 'д.г.у', 'д.с.н', 'д.ф.м.н', 'нет')) NOT NULL,
	salary FLOAT DEFAULT '1000' CHECK (salary > 0) NULL,
	rise INT DEFAULT '0' CHECK (rise >= 0) NOT NULL,
	data_hire DATETIME DEFAULT GETDATE() NOT NULL,
	birthday DATETIME NOT NULL,
	pol VARCHAR(1) CHECK (pol IN ('ж', 'Ж', 'м', 'М')) NOT NULL,
	tel_teacher NVARCHAR(20) CHECK (tel_teacher LIKE '[1-9][0-9]-[0-9][0-9]-[0-9][0-9]') NOT NULL,
	PRIMARY KEY (kod_teacher),
	FOREIGN KEY (kod_kafedru) REFERENCES kafedra (kod_kafedru) ON DELETE CASCADE,
);

INSERT INTO facultet 
	 VALUES ('Факультет1', 'Приколов Прикол Приколоч', 245, '456445');
INSERT INTO facultet 
	 VALUES ('Факультет2', 'Шутка Прикол Приколоч', 125, '254245');
INSERT INTO facultet 
	 VALUES ('Факультет3', 'Зубка Прикол Приколоч', 685, '782782');
INSERT INTO facultet 
	 VALUES ('Факультет4', 'Херак Прикол Приколоч', 247, '542452');

INSERT INTO kafedra 
	 VALUES (1, 'Кафедра1', 'Приколыч', 454,1,'565655');
INSERT INTO kafedra 
	 VALUES (1, 'Кафедра2', 'Приколыч2', 252,2,'454578');
INSERT INTO kafedra 
	 VALUES (1, 'Кафедра3', 'Приколыч3', 783,3,'244522');
INSERT INTO kafedra 
	 VALUES (1, 'Кафедра4', 'Приколыч4', 247,4,'252422');

INSERT INTO students 
	 VALUES ('Малыхин', 'Андрей', 245, 2, 'Минск', '1998-05-09','255454',1);
INSERT INTO students 
	 VALUES ('Малыхин2', 'Андрей2', 100, 3, 'Минск', '1998-05-09','255454',2);
INSERT INTO students 
	 VALUES ('Малыхин3', 'Андрей3', 342, 1, 'Минск', '1998-05-09','255454',3);
INSERT INTO students 
	 VALUES ('Малыхин4', 'Андрей4', 478, 4, 'Минск', '1998-05-09','255454',4);

INSERT INTO teachers 
	 VALUES (1, 'Учитель1', 454, 'профессор', 'к.г.у', 584, 0, '2022-09-26', '1970-04-15', 'м', '25-45-54');
INSERT INTO teachers 
	 VALUES (2, 'Учитель2', 257, 'ассистент', 'к.ф.м.н.', 584, 0, '2022-09-26', '1998-04-15', 'Ж', '10-25-86');
INSERT INTO teachers 
	 VALUES (3, 'Учитель3', 856, 'доцент', 'к.с.н', 584, 0, '2022-09-26', '1978-04-15', 'ж', '18-82-54');
INSERT INTO teachers 
	 VALUES (4, 'Учитель4', 952, 'профессор', 'к.г.у', 584, 0, '2022-09-26', '1970-02-14', 'М', '12-47-01');

SELECT * 
  FROM students 
 WHERE kurs = 2;

SELECT * 
  FROM teachers 
 WHERE salary > 500;
SELECT * 
  FROM teachers 
 WHERE name_teacher = 'Учитель1';

SELECT * 
  FROM students 
WHERE kurs = 2 AND stipend < 500;
SELECT * 
  FROM students 
WHERE kurs = 2 OR kurs = 3;
SELECT * 
  FROM teachers 
 WHERE NOT dolgnost = 'профессор';

SELECT name_teacher 
  FROM teachers
 WHERE (salary + rise) / 2 > 5 * rise;

SELECT name_teacher AS 'Фамилия преподавателя', salary + rise AS 'Его зарплата'
  FROM teachers
 WHERE salary + rise < 3500;

SELECT name_kafedru, num_korpusa 
  FROM kafedra
 WHERE num_korpusa IN ('1', '3', '12');

SELECT name_kafedru AS 'Название кафедры', num_korpusa AS 'Корпус'
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
 WHERE UPPER(name_teacher) LIKE 'У%';

SELECT name_kafedru 
  FROM kafedra
 WHERE LOWER(name_kafedru) LIKE '%к%';

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
  AND facultet.name_faculteta ='Факультет1' 
  AND teachers.dolgnost = 'профессор';

SELECT kafedra.name_kafedru AS 'название кафедры', teachers.name_teacher AS 'фамилия преподавателя' 
  FROM  kafedra LEFT JOIN teachers
    ON kafedra.kod_kafedru = teachers.kod_kafedru;

SELECT kafedra.name_kafedru AS 'название кафедры', teachers.name_teacher AS 'фамилия преподавателя' 
FROM kafedra RIGHT JOIN teachers
ON kafedra.kod_kafedru = teachers.kod_kafedru;

SELECT kafedra.name_kafedru AS 'название кафедры', teachers.name_teacher AS 'фамилия преподавателя' 
  FROM kafedra CROSS JOIN teachers ORDER BY kafedra.kod_kafedru;

SELECT f.name_faculteta AS 'Факультет', k.name_kafedru AS 'Кафедра', t.name_teacher AS 'Преподаватель' 
  FROM facultet f JOIN kafedra k
    ON f.kod_faculteta =k.kod_faculteta JOIN teachers t
    ON k.kod_kafedru = t.kod_kafedru;

SELECT SUM(salary)
  FROM teachers
 WHERE LOWER(dolgnost) = 'ассистент';

SELECT COUNT(DISTINCT t.dolgnost) 
  FROM kafedra d, teachers t
 WHERE d.kod_kafedru = t.kod_kafedru AND LOWER(d.name_kafedru) = 'Кафедра1';

SELECT MAX(salary + rise)
  FROM teachers;

SELECT UPPER(name_teacher) AS "Все прописные"
  FROM teachers;

SELECT num_korpusa AS "Корпус", COUNT(*) AS "K-вo кафедр" 
  FROM kafedra GROUP BY num_korpusa ;

SELECT salary + rise, COUNT(*) 
  FROM teachers
 WHERE salary + rise <= 1500 GROUP BY salary + rise;

SELECT MIN(salary), MAX(rise), SUM(salary + rise) 
  FROM teachers
HAVING SUM(salary + rise) < 15000;

SELECT name_teacher, salary + rise 
  FROM teachers
WHERE LOWER(dolgnost ) = 'асcистент' ORDER BY salary + rise;

SELECT name_teacher, data_hire 
  FROM teachers
 WHERE LOWER(dolgnost) = 'ассистент' ORDER BY data_hire ASC;

UPDATE teachers
   SET salary = salary * 1.1, rise = rise * 1.1 
 WHERE LOWER(dolgnost ) = 'ассистент';

DELETE FROM teachers WHERE kod_kafedru = 1;
