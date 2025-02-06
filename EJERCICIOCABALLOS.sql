CREATE TABLE CLIENTES 
(
    DNI VARCHAR2(10),
    Nombre VARCHAR2(20),
    Nacionalidad VARCHAR2(20),
    CONSTRAINT pk_clientes PRIMARY KEY (DNI),
    CONSTRAINT ck1_cliente CHECK (Nacionalidad = UPPER(Nacionalidad)),
    CONSTRAINT ck2_cliente CHECK (REGEXP_LIKE(DNI, '^[0-9]{8}[A-Z]$'))
);

CREATE TABLE CABALLOS 
(
    CodCaballo VARCHAR2(4),
    Nombre VARCHAR2(20) NOT NULL,
    Peso NUMBER(3),
    FechaNacimiento DATE,
    Propietario VARCHAR2(25),
    Nacionalidad VARCHAR2(20),
    CONSTRAINT pk_caballos PRIMARY KEY (CodCaballo),
    CONSTRAINT ck1_caballos CHECK (Peso BETWEEN 240 AND 300),
    CONSTRAINT ck2_caballos CHECK (EXTRACT(YEAR FROM FechaNacimiento) >2000)
);

CREATE TABLE CARRERAS 
(
    CodCarrera VARCHAR2(4),
    FechaHora DATE,
    ImportePremio NUMBER(6),
    ApuestaLimite NUMBER(5,2),
    CONSTRAINT pk_carreras PRIMARY KEY (CodCarrera),
    CONSTRAINT ck1_carreras CHECK (ApuestaLimite < 20000),
    CONSTRAINT ck2_carreras CHECK ((TO_CHAR(FechaHora, 'HH') BETWEEN '09' AND '13') OR (TO_CHAR(FechaHora, 'HH') = '14' AND TO_CHAR(FechaHora, 'MI') BETWEEN '00' AND '30'))
);

CREATE TABLE PARTICIPACIONES 
(
    CodCaballo VARCHAR2(4),
    CodCarrera VARCHAR2(4),
    Dorsal NUMBER(2) NOT NULL,
    Jockey VARCHAR2(10) NOT NULL,
    PosicionFinal NUMBER(2),
    CONSTRAINT pk_participaciones PRIMARY KEY (CodCaballo, CodCarrera),
    CONSTRAINT fk1_participaciones FOREIGN KEY (CodCaballo) REFERENCES CABALLOS (CodCaballo) ON DELETE RESTRICT,
    CONSTRAINT fk2_participaciones FOREIGN KEY (CodCarrera) REFERENCES CARRERAS (CodCarrera) ON DELETE RESTRICT,
    CONSTRAINT ck1_participaciones CHECK (PosicionFinal > 0)
);

CREATE TABLE APUESTAS 
(
    DNICliente VARCHAR2(10),
    CodCaballo VARCHAR2(4),
    CodCarrera VARCHAR2(4),
    Importe NUMBER(6) DEFAULT 300 NOT NULL,
    Tantoporuno NUMBER(4,2),
    CONSTRAINT pk_apuestas PRIMARY KEY (DNICliente, CodCaballo, CodCarrera),
    CONSTRAINT fk1_apuestas FOREIGN KEY (DNICliente) REFERENCES CLIENTES (DNI) ON DELETE CASCADE,
    CONSTRAINT fk2_apuestas FOREIGN KEY (CodCaballo) REFERENCES CABALLOS (CodCaballo) ON DELETE CASCADE,
    CONSTRAINT fk3_apuestas FOREIGN KEY (CodCarrera) REFERENCES CARRERAS (CodCarrera) ON DELETE CASCADE,
    CONSTRAINT ck1_apuestas CHECK (Tantoporuno > 1)
);

    
-- 2. Inserta el registro o registros necesarios para guardar la siguiente información:       
-- El cliente escocés realiza una apuesta al caballo más pesado de la primera carrera que se corra en el verano de 2009 por un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1. --
-- Si es necesario algún dato invéntatelo, pero sólo los datos que sean estrictamente necesaria. --



-- 3 Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos. --

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera)
VALUES ('1234', 'C6');

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera)
VALUES ('5678', 'C6');

-- 4 Inserta dos carreras con los datos que creas necesario. --

INSERT INTO CARRERAS
VALUES ('C67', TO_DATE('2025-01-30 05:30', 'YYYY-MM-DD HH:MI PM'), 1500, 10000);

INSERT INTO CARRERAS
VALUES ('C68', TO_DATE('2025-01-30 06:00', 'YYYY-MM-DD HH:MI PM'), 1500, 12000);

-- 5 Quita el campo propietario de la tabla caballos --

ALTER TABLE CABALLOS 
DROP COLUMN Propietario;

-- 6. Añadir las siguientes restricciones a las tablas:
    --• En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
    --• La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
    --• La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.
      --Si los datos que has introducidos no cumplen las restricciones haz los cambios necesarios para ellos.

ALTER TABLE PARTICIPACIONES 
ADD CONSTRAINT chk_jockey CHECK (Jockey = INITCAP(Jockey));

ALTER TABLE CARRERAS 
ADD CONSTRAINT ck2_carrera CHECK (EXTRACT(MONTH FROM FechaHora) BETWEEN 3 AND 11);

ALTER TABLE CABALLOS 
ADD CONSTRAINT ck3_caballo CHECK (Nacionalidad IN ('ESPAÑOLA', 'BRITÁNICA', 'ÁRABE'));

-- 6. Borra las carreras en las que no hay caballos inscritos.

DELETE FROM CARRERAS 
WHERE ;

-- 7. Añade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos

ALTER TABLE CLIENTES 
ADD CODIGO VARCHAR2(4) UNIQUE NOT NULL;

--  8. Nos hemos equivocado y el código C6 de la carrera en realidad es C66.

UPDATE CARRERAS 
SET CodCarrera = 'C66' 
WHERE CodCarrera = 'C6';

--  9. Añade un campo llamado premio a la tabla apuestas.

ALTER TABLE APUESTAS 
ADD Premio NUMBER(6);

--  10. Borra todas las tablas y datos con el número menor de instrucciones posibles.








