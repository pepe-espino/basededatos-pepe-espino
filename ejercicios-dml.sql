CREATE TABLE profesores
(
	dni_profesor varchar2(15),
	nombre varchar2(20),
	apellido1 varchar2(20),
	apellido2 varchar2(20),
	direccion varchar2(40),
	titulo varchar2(20),
	gana number(5),
	CONSTRAINT pk_profesores PRIMARY KEY (dni_profesor)
);

CREATE TABLE cursos
(
	cod_curso varchar2(15),
	nombre_curso varchar2(15),
	dni_profesor varchar2(15),
	maximo_alumnos varchar2(6),
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas number(5),
	CONSTRAINT pk_cursos PRIMARY KEY (cod_curso),
	CONSTRAINT fk_cursos FOREIGN KEY (dni_profesor) REFERENCES profesores(dni_profesor)
);

CREATE TABLE alumnos
(
	dni varchar2(15),
	nombre varchar2(20),
	apellido1 varchar2(20),
	apellido2 varchar2(20),
	direccion varchar2(40),
	sexo varchar2(5),
	fecha_nacimiento DATE,
	curso varchar2(15),
	CONSTRAINT pk_alumnos PRIMARY KEY(dni),
	CONSTRAINT fk_alumnos FOREIGN KEY(curso) REFERENCES cursos(cod_curso),
	CONSTRAINT ck_alumnos CHECK (sexo IN('H', 'M'))
);


INSERT INTO PROFESORES
VALUES ('Juan', 'Arch', 'Lopez', '32432455', 'Puerta Negra, 4', 'Ing. Informatica', '7500');

INSERT INTO PROFESORES
VALUES ('María', 'Oliva', 'Rubio', '43215643', 'Juan Alfonso, 32', 'Lda. Fil. Inglesa', '5400');

INSERT INTO CURSOS
VALUES ('Ingles básico', '1', '43215643', '15', '', '', '120')

INSERT INTO CURSOS
VALUES ('Administracion Linux', '2', '32432455', '', '', '', '120')

INSERT INTO ALUMNOS
VALUES ('')









