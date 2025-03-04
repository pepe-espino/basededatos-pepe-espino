CREATE TABLE profesores
(
	dni_profesor varchar2(15),
	nombre varchar2(40),
	apellido1 varchar2(20),
	apellido2 varchar2(20),
	direccion varchar2(40),
	titulo varchar2(20),
	gana number(5),
	CONSTRAINT pk_profesores PRIMARY KEY (dni_profesor)
);

CREATE TABLE cursos
(
	cod_curso NUMBER(15),
	nombre_curso varchar2(40),
	dni_profesor varchar2(15),
	maximo_alumnos number(6),
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas number(5),
	CONSTRAINT pk_cursos PRIMARY KEY (cod_curso),
	CONSTRAINT fk_cursos FOREIGN KEY (dni_profesor) REFERENCES profesores(dni_profesor)
);

CREATE TABLE alumnos
(
	dni varchar2(15),
	nombre varchar2(40),
	apellido1 varchar2(20),
	apellido2 varchar2(20),
	direccion varchar2(40),
	sexo varchar2(5),
	fecha_nacimiento DATE,
	curso number(15),
	CONSTRAINT pk_alumnos PRIMARY KEY(dni),
	CONSTRAINT fk_alumnos FOREIGN KEY(curso) REFERENCES cursos(cod_curso),
	CONSTRAINT ck_alumnos CHECK (sexo IN('H', 'M'))
);


INSERT INTO PROFESORES
VALUES ( '32432455', 'Juan', 'Arch', 'Lopez','Puerta Negra, 4', 'Ing.Informatica', 7500);

INSERT INTO PROFESORES
VALUES ( '43215643', 'María', 'Oliva', 'Rubio', 'Juan Alfonso, 32', 'Lda. Fil. Inglesa', 5400);

SELECT * FROM profesores;

INSERT INTO CURSOS
VALUES (1, 'Ingles básico','43215643', 15, TO_DATE('01-11-00','DD-MM-YY'), TO_DATE('22-DEC-00','DD-MON-YY'), 120);

INSERT INTO CURSOS
VALUES (2, 'Administracion Linux','32432455', null, TO_DATE('11-SEP-00','DD-MON-YY'), NULL, 80);

SELECT * FROM CURSOS;

INSERT INTO ALUMNOS
VALUES ('123523','Lucas','Manilva','Lopez','Alhamar, 3','V', TO_DATE('01-11-79','DD-MM-YY'),'1');

INSERT INTO ALUMNOS
VALUES ('2567567','Antonio','Lopez','Alcantara','Maniquí, 21','M',NULL,'2');

INSERT INTO ALUMNOS
VALUES ('3123689','Manuel','Alcantara','Pedrós','Julian, 2','2',null,'1');

INSERT INTO ALUMNOS
VALUES ('4896765','Jose','Perez','Caballar',' Jarcha, 5','V',TO_DATE('03-02-77','DD-MM-YY'),'3');

INSERT INTO ALUMNOS
VALUES ('123523','Sergio','Navas','Retal',null,'P',NULL,'1');

SELECT * FROM ALUMNOS;

INSERT INTO PROFESORES
VALUES ('32432455','Juan','Arch','Lopez','Puerta Negra, 4','Ing. Informatica',null);

INSERT INTO ALUMNOS
VALUES ('789678','Maria','Jaén','Sevilla','Martos, 5','M',NULL,NULL);

SELECT * FROM ALUMNOS;

UPDATE ALUMNOS 
SET fecha_nacimiento = TO_DATE('23/12/1976','DD/MM/YYYY') 
WHERE dni = 2567567;

UPDATE ALUMNOS 
SET curso = 2 
WHERE dni = 2567567;

INSERT INTO PROFESORES (NOMBRE, APELLIDO1, dni_profesor) 
VALUES ('Laura', 'Jiménez', '85462514');

DELETE FROM PROFESORES 
WHERE dni_profesor='85462514';

DELETE FROM CURSOS 
WHERE cod_curso = 1;

UPDATE ALUMNOS 
SET fecha_nacimiento =TO_DATE('01/01/2012', 'DD/MM/YYYY') 
WHERE fecha_nacimiento =NULL; 

ALTER TABLE ALUMNOS 
DROP COLUMN SEXO;

UPDATE PROFESORES 
SET gana =(gana*0.2)+gana 
WHERE titulo LIKE 'Ing. Informatica';

UPDATE PROFESORES 
SET dni_profesor= '1234567' 
WHERE nombre = 'Juan' AND apellido1 = 'Arch';

UPDATE PROFESORES
SET dni_profesor = '7654321' 
WHERE  titulo LIKE 'Ing. Informatica';




