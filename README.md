# Base de datos para gestión de clínica

Proyecto académico de análisis, modelado e implementación de una base de datos relacional para la gestión integral de una clínica.

El trabajo parte del relevamiento de las entidades y relaciones principales del dominio clínico, continúa con el diseño conceptual y lógico, y finaliza con la implementación de las tablas en MySQL.

## Objetivo

Diseñar una base de datos que permita organizar la información necesaria para la atención clínica, incluyendo pacientes, historias clínicas, obras sociales, turnos, consultorios y médicos.

## Alcance del modelo

La base contempla las siguientes entidades principales:

- **Paciente:** información personal, datos de contacto, dirección, estado civil, ocupación y obra social.
- **Obra social:** número de afiliado, cobertura médica, categoría, vigencia y parentesco.
- **Historia clínica:** alergias, antecedentes familiares y personales, medicación y cirugías.
- **Médico:** datos personales y profesionales, matrícula, especialidad, cargo, datos de contacto y estado.
- **Turno:** fecha y hora, estado, observación, paciente, médico y consultorio asociados.
- **Consultorio:** identificación, piso y estado.
- **Paciente teléfonos:** entidad independiente para modelar correctamente la relación de un paciente con uno o varios números telefónicos.

También se modelan relaciones de supervisión y suplencia entre médicos.

## Etapas del proyecto

1. Identificación de entidades, atributos y relaciones del sistema.
2. Construcción del diagrama entidad-relación.
3. Definición de atributos, claves y restricciones.
4. Transformación al modelo lógico relacional.
5. Implementación del esquema en MySQL mediante SQL.

## Tecnologías utilizadas

- MySQL
- MySQL Workbench
- SQL
- Modelado entidad-relación
- Diseño lógico de bases de datos

## Estructura del repositorio

```text
├── Diagramas/
│   ├── DER_relaciones.jpg
│   ├── deratributos (3).png
│   ├── derrelaciones (2).png
│   └── Modelado Logico.jpeg
└── SQL/
    └── TFI_clinica.sql
