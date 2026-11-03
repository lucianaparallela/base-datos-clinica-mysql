
CREATE DATABASE Clinica;
USE Clinica;


#1. Tabla: Obra_social
CREATE TABLE Obra_social (
    id_obrasocial      INT PRIMARY KEY AUTO_INCREMENT,
    nro_afiliado       VARCHAR(30) UNIQUE NOT NULL,  
    Categoria          VARCHAR(30),        
    Cobertura_medica   ENUM('OSDE','Swiss Medical','Medicus','Medifé','ACA Salud','IOMA','PAMI','Andar'), 
    Vigencia           DATE,
    Parentesco         ENUM ('Conyugue','Hijo/a','Titular')
);

#tabla paciente
CREATE TABLE Paciente (
    id_paciente       INT PRIMARY KEY AUTO_INCREMENT,
    dni               VARCHAR(20) UNIQUE NOT NULL,
    Nombre            VARCHAR(50),
    Apellido          VARCHAR(50),
    Estado_civil      ENUM ('Soltero','Casado','Divorciado','Viudo'),
    Ocupacion         ENUM ('Trabaja','Estudiante','Desocupado'),
    Estado            ENUM ('Activo', 'Inactivo') DEFAULT 'Activo',
    Correo            VARCHAR(100) UNIQUE,
    Fech_nac         DATE,
    Calle             VARCHAR(50),
    Calle_nro         VARCHAR(10),
    Cp                VARCHAR(10),
    id_obrasocial     INT,
    
    
    FOREIGN KEY (id_obrasocial) REFERENCES Obra_social(id_obrasocial),
	fecha_creacion    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ult_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

#Tabla: Historia_clinica
CREATE TABLE Historia_clinica (
    id_historia          INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente   		 INT UNIQUE,   
    Cirugias             TEXT,
    Medicacion           TEXT,
    Antecedentes_personales TEXT,
    Antecedentes_familiares TEXT,
    Alergias             TEXT,

	FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE
); 


CREATE TABLE Paciente_telefonos (
    id_paciente INT,
    Telefono    VARCHAR (25) NOT NULL,
    PRIMARY KEY (id_paciente, Telefono), 
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Medico (
    id_medico        INT PRIMARY KEY AUTO_INCREMENT,
    DNI              VARCHAR(20) UNIQUE NOT NULL,
    Nombre           VARCHAR(50),
    Apellido         VARCHAR(50),
    Telefono         INT UNSIGNED UNIQUE NOT NULL ,
    Correo           VARCHAR (50) UNIQUE NOT NULL,
    Fech_nac         DATE,
    Matricula_prof   VARCHAR(50),
    Estado           ENUM ('Activo','Inactivo','Licencia') DEFAULT 'Activo',
    Cargo            ENUM ('Jefe','De Planta','Residente'),
    Calle            VARCHAR(50),
    Calle_nro        VARCHAR(10),
    Cp               VARCHAR(10),
    Especialidad     ENUM ('Cardiología', 'Gastroenterología', 'Traumatología', 'Pediatría', 'Endocrinología', 'Neumología', 'Dermatología') NOT NULL,
    
      -- Caso recursivo 
    
	id_supervisa     INT,  -- FK recursiva (supervisión entre médicos)
    id_suplente      INT,  -- FK recursiva (suplencias)
    
    
    FOREIGN KEY (id_supervisa) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_suplente) REFERENCES Medico(id_medico),

    -- para auditoria 
	fecha_creacion    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ult_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


#consultorio :
CREATE TABLE Consultorio (
    id_consultorio INT PRIMARY KEY AUTO_INCREMENT,
    Piso           INT UNSIGNED NOT NULL , 
    Estado         ENUM ('Ocupado','Desocupado','Mantenimiento')
);


#turno: Entidad asociativa
CREATE TABLE Turno (
    id_turno        INT PRIMARY KEY AUTO_INCREMENT,
    Fech_hora       DATETIME NOT NULL UNIQUE,
    Estado          ENUM ('Pendiente de Confirmacion','Confirmado','Cancelado'),
    Tipo_observacion     ENUM ('Consulta','Tratamiento'),
    id_paciente     INT NOT NULL UNIQUE,
    id_medico       INT NOT NULL UNIQUE,
    id_consultorio  INT NOT NULL UNIQUE,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE, 
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON DELETE CASCADE,        
    FOREIGN KEY (id_consultorio) REFERENCES Consultorio(id_consultorio) ON DELETE CASCADE,

    UNIQUE (id_medico, id_paciente, id_consultorio,Fech_hora)
);


CREATE OR REPLACE VIEW Paciente_edad AS 
SELECT c.*, TIMESTAMPDIFF(YEAR, c.fech_nac, CURDATE()) AS edad_anios
FROM Clinica.Paciente AS c;

