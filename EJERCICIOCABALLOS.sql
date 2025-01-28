CREATE TABLE CABALLOS
(
	CODCABALLO VARCHAR2(4),
	NOMBRE VARCHAR2(20) NOT NULL,
	PESO NUMBER(3) BETWEEN 240 AND 300,
	FECHA_NACIMIENTO DATE,
	PROPIETARIO VARCHAR2(25),
	NACIONALIDAD VARCHAR2(20) CHECK (NACIONALIDAD = UPPER(NACIONALIDAD)),
	CONSTRAINT PK_CABALLOS PRIMARY KEY(CODCABALLO),
	CONSTRAINT CK1_CABALLOS CHECK (EXTRACT(YEAR FROM FECHA_NACIMIENTO) > 2000),
	CONSTRAINT CK2_CABALLOS CHECK REGEXP([^A-Z])
);

CREATE TABLE CARRERAS
(
	CODCARRERA VARCHAR2(4),
	FECHA_Y_HORA DATE,
	IMPORTE_PREMIO NUMBER(6),
	APUESTA_LIMITE NUMBER(5.2),
	CONSTRAINT PK_CARRERAS PRIMARY KEY(CODCARRERA)
);

CREATE TABLE PARTICIPACIONES 
(
	CODCABALLO VARCHAR2(4),
	CODCARRERA VARCHAR2(4),
	DORSAL NUMBER(2),
	JOCKEY VARCHAR2(10),
	POSICION_FINAL NUMBER(2),
	CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY(CODCABALLO, CODCARRERA),
	CONSTRAINT FK1_PARTICIPACIONES FOREIGN KEY(CODCABALLO) REFERENCES CABALLOS(CODCABALLO),
	CONSTRAINT FK2_PARTICIPACIONES FOREIGN KEY(CODCARRERA) REFERENCES CARRERAS(CODCARRERA)
);

CREATE TABLE CLIENTES 
(
	DNI VARCHAR2(10),
	NOMBRE VARCHAR2(20),
	NACIONALIDAD VARCHAR2(20),
	CONSTRAINT PK_CLIENTES PRIMARY KEY(DNI)
);

CREATE TABLE APUESTAS 
(
	DNICLIENTE VARCHAR2(10),
	CODCABALLO VARCHAR2(4),
	CODCARRERA VARCHAR2(4),
	IMPORTE NUMBER(6),
	TANTOPORUNO NUMBER(4.2),
	CONSTRAINT PK_APUESTAS PRIMARY KEY(DNICLIENTE, CODCABALLO, CODCARRERA),
	CONSTRAINT FK1_APUESTAS FOREIGN KEY(DNICLIENTE) REFERENCES CLIENTES(DNI),
	CONSTRAINT FK2_APUESTAS FOREIGN KEY(CODCABALLO) REFERENCES CABALLOS(CODCABALLO),
	CONSTRAINT FK3_APUESTAS FOREIGN KEY(CODCARRERA) REFERENCES CARRERAS(CODCARRERA)
);









