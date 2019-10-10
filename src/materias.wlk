class Estudiante {
	const carrera
	var property materiasAprobadas = []
	var property inscripciones = []
	method creditosAcumulados() = materiasAprobadas.sum{materiaAprobada => materiaAprobada.creditosQueOtorga()}
	
	method puedeCursar(materia) =
		self.cursaSoloUnaCarrera()
		&& materia.carrera() === carrera
		&& not(materiasAprobadas.contains(materia))
		&& not(inscripciones.contains(materia))
		&& self.cumplePrerequisitos(materia)		
	
	method aprobo(materia){
		if(not(materiasAprobadas.contains(materia)) && inscripciones.contains(materia)){
			materiasAprobadas.add(materia)				
		}else{
			//Exception de que ya aprobo esa materia
			throw new Exception(message = "El alumno no esta en condiciones de aprobar esa materia")
		}
	}
	
	method cursaSoloUnaCarrera(){
		return carrera != null
	}
		
	method cumplePrerequisitos(materia){	
	//Funciona para el prerequisito "nada" tambien
			
		return materia.correlativas().all({materiaCorrelativa => materiasAprobadas.contains(materiaCorrelativa)})
		&& 	self.creditosAcumulados() >= materia.creditosRequeridos()
	}
	
}

class Carrera {
	const property materias = []
	
	method agregarMateria(materia) {
		materias.add(materia)
	}
	
	method pertenece(materia) = materias.contains(materia)

}

class Materia {
	const property correlativas = []
	var property creditosRequeridos = 0
	var property creditosQueOtorga = 0
	const cupo = 0
	var property inscriptos = []
	var property listaDeEspera = []
	const carrera
	method carrera() {return carrera}	
	
	method inscribirA(estudiante) {
		if(estudiante.puedeCursar(self)){
			if(inscriptos.size() < cupo){
				inscriptos.add(estudiante)
				
			}else{
				listaDeEspera.add(estudiante)
			}
		}else{
			//EXCEPTION de que no esta apto para cursar la materia
			throw new Exception(message = "El alumno no esta apto para cursar esa materia")
		}
	}
	
	method bajarA(estudiante){
		if(inscriptos.contains(estudiante)){
			inscriptos.remove(estudiante)
			if(listaDeEspera.size()>0){
				var afortunado = listaDeEspera.get(0)
				inscriptos.add(afortunado)
				listaDeEspera.remove(afortunado)
			}				
		}else{
			//EXCEPTION de que ese alumno nunca estuvo inscripto
			throw new Exception(message = "El alumno nunca estuvo inscripto en esa materia")
		}
	}
	
	method mostrar(listado) { listado.forEach ({estudiante => console.println(estudiante)}) }
	
	
	method resultadoDeInscripcion() {
		console.println("Inscriptos: ")
		self.mostrar(inscriptos)
		console.println("Lista de Espera: ")
		self.mostrar(listaDeEspera)
	}
}

class MateriaAprobada {
	const estudiante
	const materia
	const nota
}
