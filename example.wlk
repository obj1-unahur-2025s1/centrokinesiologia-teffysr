class Paciente {
  var edad
  var property nivelDeFortaleza
  var property nivelDeDolor
  const rutina = []
  method edad() = edad

  method puedeUsarAparato(aparato) = aparato.puedeSerUsadoPor(self)

  method usaAparato(aparato) {
    aparato.usa(self)
  }

  method agregarAparatoARutina(aparato){
    rutina.add(aparato)
  }

  method quitarAparatoDeRutina(aparato){
    if (rutina.contains(aparato)){
      rutina.remove(aparato)
    }
  }

  method puedeHacerLaRutina() = rutina.all({ a => self.puedeUsarAparato(a) })
  
  method hacerRutina(){
    rutina.forEach({ a => self.usaAparato(a) })
  }

  method rutina() = rutina
}

class Aparato {
  method puedeSerUsadoPor(paciente) 
  method usa(paciente)
}

class Magneto inherits Aparato {
  override method puedeSerUsadoPor(paciente) = true
  override method usa(paciente) {
    paciente.nivelDeDolor(0.max(paciente.nivelDeDolor() - paciente.nivelDeDolor()*0.1)) 
  }  
}

class Bicicleta inherits Aparato {
  override method puedeSerUsadoPor(paciente) = paciente.edad() > 8
  override method usa(paciente) {
    paciente.nivelDeDolor(0.max(paciente.nivelDeDolor() - 4)) 
    paciente.nivelDeFortaleza(paciente.nivelDeFortaleza() + 3) 
  } 
}

class Minitramp inherits Aparato {
  override method puedeSerUsadoPor(paciente) = paciente.nivelDeDolor() < 20
  override method usa(paciente) {
    paciente.nivelDeFortaleza(paciente.edad()*0.1 + paciente.nivelDeFortaleza()) 
  } 
}