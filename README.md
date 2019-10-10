# Inscripción a materias

[![Build Status](https://travis-ci.com/pdep-utn/kata-03-facultad-pepita-aproba.svg?token=GU25DuLzzwZvNxRhMnpP&branch=master)](https://travis-ci.com/pdep-utn/kata-03-facultad-pepita-aproba)

- [OK] TODO: Definir Integrantes
- [ ] Resolver los puntos generales
- [ ] Resolver puntos particulares de cada integrante
- [ ] Implementar los casos de prueba pedidos
- [ ] Agregar badge de Travis
- [ ] Corrección presencial en clase

## Integrantes

* Nicolás Collazo (NicoCollazo)
* Elias Reuter (EliasReuter)

## Enunciado general

Queremos implementar un sistema que permita realizar la inscripción a materias de una Universidad. Ojo, prestar bien atención a las reglas del dominio, que pueden no ser exactamente iguales a las de tu universidad.

En esta universidad de cada materia hay un único curso y el programa tiene sólo información de la inscripción actual, no nos interesan inscripciones anteriores. En cambio, sí debemos conocer el historial de materias aprobadas de un estudiante. De cada materia aprobada hay que saber qué materia aprobó y con qué nota.

> Tip: La nota con la que un estudiante aprobó una materia, no puede ser atributo del estudiante (porque un estudiante tiene muchas notas) ni de la materia (porque una materia tiene muchos estudiantes y cada uno tiene su nota). Entonces se necesita un objeto que represente "Juan Pérez aprobó Paradigmas con 7", que es distinto tanto al objeto que representa a Juan Pérez como al objeto que representa a la materia Paradigmas.

## Qué se pide

### ¿Puedo cursarla? - ambos integrantes

Determinar si un estudiante puede cursar una materia. Para esto se deben cumplir tres condiciones:

- La materia debe corresponder a la carrera que esté cursando el estudiante. Tener en cuenta que:
  1. un estudiante solo estará cursando una carrera y (RESUELTO)
  1. cada materia pertenece a una única carrera. (RESUELTO)
- El estudiante no puede haber aprobado la materia previamente, ni estar inscripto. (FALTA SEGUNDA PARTE)
- Además cada materia tiene sus propios prerrequisitos, que pueden tener diferentes formas y se detallan a continuación.

Los prerrequisitos de una materia pueden ser:

- **Un conjunto de materias correlativas**: por ejemplo para cursar "Arquitectura de Software" es necesario haber aprobado "Paradigmas" y "Diseño". (RESUELTO)
- **Una cantidad de créditos**: por ejemplo para hacer "Proyecto" se necesita acumular 250 créditos previamente. (Cada materia otorga una cantidad de créditos determinada,
    que se acumulan al aprobarla.) (RESUELTO)
- **Nada**: Hay materias que no tienen ningún requerimiento, por ejemplo "Elementos de Programación", no tiene ninguna condición especial. (RESUELTO(DUDAS))

### ¡Aprobé! - ambos integrantes (RESUELTO. FALTA EXCEPTION)

Registrar una materia aprobada por un estudiante, verificando que no se cargue dos veces la nota de una misma materia. 
Estamos registrando aquí información histórica, no son los cursos actuales.

### Me inscribo - integrante 1 (RESUELTO. FALTA EXCEPTION)

Inscribir un alumno a un curso, verificando las condiciones de inscripción de la materia. Además, cada materia tiene un "cupo", es decir, una cantidad máxima de estudiantes que se pueden inscribir. 
Para manejar el exceso en los cupos, las materias tienen una lista de espera, de estudiantes que quisieran cursar pero no tienen lugar. 
Por defecto se anotan según el orden de llegada. Si no se puede inscribir, 
nos gustaría saber cuál es el motivo (algo que no sea "error 503" ni "Ha ocurrido un error al inscribirse")

### Me bajo - integrante 2

Dar de baja un estudiante de una materia. En caso de haber estudiantes en lista de espera, el primer estudiante de la lista debe obtener su lugar en el curso.

### Resultados de la inscripción - ambos integrantes

Luego de la inscripción, el sistema debe poder contestar

- Dada una materia los estudiantes inscriptos
- Dada una materia los estudiantes en lista de espera

## Casos de prueba

Implementar los tests descritos a continuación:

- Un alumno se intenta inscribir a una materia de otra carrera de la que está cursando, se rechaza.
- Un alumno se intenta inscribir a una materia que ya cursó, se rechaza.
- Un alumno se intenta inscribir a una materia en la que ya está inscripto, se rechaza.
- Un alumno se intenta inscribir a una materia cuyos pre-requisitos son tener ciertas correlativas, le falta una correlativa, se rechaza.
- Un alumno se intenta inscribir a una materia cuyos pre-requisitos necesitan una cierta cantidad de créditos, le faltan esos créditos, se rechaza.
- Un alumno se intenta inscribir a una materia cuyos pre-requisitos son tener ciertas correlativas, tiene todas las correlativas, hay cupo, se aprueba.
- Un alumno se intenta inscribir a una materia cuyos pre-requisitos necesitan una cierta cantidad de créditos, los tiene, hay cupo, se aprueba.
- Un alumno quiere inscribirse a una materia sin pre-requisitos (`nada`) pero no hay cupo. Usar criterio por orden de llegada y el alumno queda en lista de espera.
- Registrar la aprobación de un alumno por primera vez, debe poderse.
- Registrar la aprobación de un alumno por segunda vez, debe rechazarse.
- Registrar la aprobación de un alumno a dos materias, los créditos que tiene el alumno debe ser la sumatoria de los créditos de ambas materias aprobadas.
- Dar de baja a una materia que tiene lista de espera por falta de cupo, el alumno que se dio de baja no debe estar y el primer alumno en lista de espera debe estar inscripto (y no figurar más en lista de espera).

## Preguntas que podemos hacer en la corrección presencial

- en qué lugares apareció el concepto **polimorfismo**, qué ventajas trajo y quién es el objeto que lo aprovecha.
- cómo modelaron el rechazo de una inscripción, qué alternativas se presentaron, justificar
- cómo separar operaciones con y sin efecto (colateral), qué sentido tiene, justificar
- en qué medida aprovecharon la gran cantidad de mensajes que tienen las colecciones en Wollok, relacionarlo con objetos que representan bloque de código y orden superior
- ¿qué deberíamos hacer si queremos cambiar el criterio para ordenar los alumnos que están en una lista de espera? Si en lugar de orden de llegada quisiéramos tomar en cuenta el promedio general, la antigüedad (el que recién entró antes del que está hace más tiempo cursando), o cualquier otro criterio...
- ¿qué deberíamos hacer si queremos que una materia cambie el criterio por el cual resuelve sus prerrequisitos?
