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

class PacienteResistente inherits Paciente{
  override method usaAparato(aparato){
    super(aparato)
    self.nivelDeFortaleza(self.nivelDeFortaleza() + 1)
  }
}

class PacienteCaprichoso inherits Paciente{
  override method puedeHacerLaRutina(){
    return super() and rutina.any({ a => a.color() == "rojo" })
  }

  override method hacerRutina(){
    super()
    super()
  }
}

class PacienteRapidaRecuperacion inherits Paciente{
  var property factorNivelDeDolor = 3
  override method hacerRutina() {
    super()
    self.nivelDeDolor(self.nivelDeDolor()-factorNivelDeDolor)
  }
}

class Aparato {
  var property color = "blanco" 
  method puedeSerUsadoPor(paciente) 
  method usa(paciente)
  method necesitaMantenimiento()
  method hacerMantenimiento()
}

class Magneto inherits Aparato {
  var property puntosDeImantacion = 800
  override method puedeSerUsadoPor(paciente) = true
  override method usa(paciente) {
    paciente.nivelDeDolor(0.max(paciente.nivelDeDolor() - paciente.nivelDeDolor()*0.1)) 
    puntosDeImantacion = 0.max(puntosDeImantacion - 1)
  }
  override method necesitaMantenimiento() = puntosDeImantacion < 100

  override method hacerMantenimiento(){
    puntosDeImantacion += 500
  }
}

class Bicicleta inherits Aparato {
  var property cantidadDesajustesDeTornillos = 0
  var property cantidadDePerdidasDeAceite = 0
  override method puedeSerUsadoPor(paciente) = paciente.edad() > 8
  override method usa(paciente) {
    if(paciente.nivelDeDolor() > 30){
      cantidadDesajustesDeTornillos += 1
    }
    if(paciente.edad().between(30, 50)){
      cantidadDePerdidasDeAceite += 1
    }
    paciente.nivelDeDolor(0.max(paciente.nivelDeDolor() - 4)) 
    paciente.nivelDeFortaleza(paciente.nivelDeFortaleza() + 3) 
  }
  override method necesitaMantenimiento() = cantidadDesajustesDeTornillos >= 10 or cantidadDePerdidasDeAceite >= 5

  override method hacerMantenimiento(){
    cantidadDesajustesDeTornillos = 0
    cantidadDePerdidasDeAceite = 0
  }
}

class Minitramp inherits Aparato {
  override method puedeSerUsadoPor(paciente) = paciente.nivelDeDolor() < 20
  override method usa(paciente) {
    paciente.nivelDeFortaleza(paciente.edad()*0.1 + paciente.nivelDeFortaleza()) 
  }
  override method necesitaMantenimiento() = false

  override method hacerMantenimiento(){
  }
}

object centroDeKinesiologia{
  const property pacientes = #{}
  const property aparatos = #{}

  method asignarPaciente(unPaciente){
    pacientes.add(unPaciente)
  }

  method agregarAparato(unAparato){
    aparatos.add(unAparato)
  }

  method coloresAparatos(){
    return aparatos.map({ a => a.color() }).asSet()
  }

  method pacientesMenoresDe8Anios(){
    return pacientes.filter({ p => p.edad() < 8 })
  }

  method pacientesQueNoPuedenHacerRutina(){
    return pacientes.count({ p => not p.puedeHacerLaRutina() })
  }

  method estaEnOptimasCondiciones() = aparatos.all({ a => not a.necesitaMantenimiento() })

  method aparatosQueNecesitanMantenimiento() = aparatos.filter({ a => a.necesitaMantenimiento() })

  method estaComplicado() = aparatos.size() / 2 <= self.aparatosQueNecesitanMantenimiento().size()

  method visitaDeTecnico(){
    self.aparatosQueNecesitanMantenimiento().forEach({ a => a.hacerMantenimiento() })
  }
}