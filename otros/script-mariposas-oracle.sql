CREATE TABLE familia
(
	nombre varchar2(20),
	caracteristicas varchar2(40),
	CONSTRAINT pk_familia PRIMARY KEY (nombre)
);

CREATE TABLE genero
(
	nombre varchar2(20),
	familia_nombre varchar2(20),
	caracteristicas varchar2(40),
	CONSTRAINT pk_genero PRIMARY KEY (nombre),
	CONSTRAINT fk_genero FOREIGN KEY (familia_nombre) REFERENCES familia(nombre)
);

CREATE TABLE especie
(
	nombre varchar2(20),
	genero_nombre varchar2(20),
	caracteristicas varchar2(40),
	CONSTRAINT pk_especie PRIMARY KEY (nombre),
	CONSTRAINT fk_especie FOREIGN KEY (genero_nombre) REFERENCES genero(nombre)
);

CREATE TABLE zona
(
	nombre varchar2(20),
	protegida varchar2(2),
	extension NUMBER(20),
	localidad varchar2(20),
	CONSTRAINT pk_zona PRIMARY KEY (nombre),
	CONSTRAINT ck_zona CHECK (protegida IN ('SI','NO'))
);

CREATE TABLE persona
(
	dni varchar2(9),
	nombre varchar2(20),
	usuario varchar2(20) UNIQUE,
	telefono varchar2(9),
	direccion varchar2(40),
	CONSTRAINT pk_persona PRIMARY KEY (dni)
);

CREATE TABLE coleccion
(
	id_coleccion varchar2(20),
	dni_persona varchar2(9),
	num_ejemplares NUMBER,
	fecha_inicio DATE,
	precio NUMBER,
	CONSTRAINT pk_coleccion PRIMARY KEY (id_coleccion, dni_persona),
	CONSTRAINT fk_coleccion FOREIGN KEY (dni_persona) REFERENCES persona(dni),
	CONSTRAINT ck_num_ejemplares CHECK (num_ejemplares BETWEEN 1 AND 150)
);

CREATE TABLE ejemplar_mariposa
(
	zona_nombre varchar2(20),
	especie_nombre varchar2(20),
	fecha_captura DATE,
	hora_captura DATE,
	dni_persona varchar2(9),
	precio_ejemplar NUMBER,
	nombre_comun varchar2(20),
	id_coleccion varchar2(20),
	CONSTRAINT pk_ejemplar_mariposa PRIMARY KEY (zona_nombre, especie_nombre, fecha_captura, hora_captura, dni_persona),
	CONSTRAINT fk1_ejemplar_mariposa FOREIGN KEY (zona_nombre) REFERENCES zona(nombre),
	CONSTRAINT fk2_ejemplar_mariposa FOREIGN KEY (especie_nombre) REFERENCES especie(nombre),
	CONSTRAINT fk3_ejemplar_mariposa FOREIGN KEY (dni_persona, id_coleccion) REFERENCES coleccion(dni_persona, id_coleccion),
	CONSTRAINT ck_ejemplar_mariposa CHECK (precio_ejemplar > 0)
);


ALTER TABLE PERSONA 
ADD apellidos varchar2(20);

ALTER TABLE ZONA
DROP CONSTRAINT ck_zona;

ALTER TABLE ZONA 
ADD CONSTRAINT ck_zona CHECK (extension BETWEEN 100 AND 1500);

ALTER TABLE EJEMPLAR_MARIPOSA 
DROP CONSTRAINT ck_ejemplar_mariposa;

ALTER TABLE EJEMPLAR_MARIPOSA 
MODIFY fecha_captura DATE DEFAULT SYSDATE;

INSERT INTO FAMILIA (NOMBRE)
VALUES ('hesperiidae');

INSERT INTO GENERO (NOMBRE)
VALUES ('hesperia');

INSERT INTO ESPECIE (NOMBRE)
VALUES ('hesperia comma');

INSERT INTO PERSONA (dni, NOMBRE)
VALUES ('12345678z', 'pepe');

CREATE SEQUENCE sec_num_ejemplares
START WITH 1
INCREMENT BY 1;
/*
SELECT sec_num_ejemplares.nextval FROM DUAL;

INSERT INTO COLECCION (num_ejemplares)
VALUES (sec_num_ejemplares.nextval);
*/

CREATE INDEX ind_persona_nombre
ON persona (nombre);



