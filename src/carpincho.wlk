import wollok.game.*
import direcciones.*

	object 	moviendose {
	method puedeMover() {
		return true
	}
	

}

object carpincho {
	var position = game.at(2, 2)
	var energia = 1000
	var property perfil = derecha
	var property estado = moviendose
	
	method position() {
		return position
	}
	


	method position(_position) {
		position = _position
	}
	
	//method image() = "carpincho-derecha.png"
	
	method image() {
		return "" + self + "-" + self.perfil() + ".png"
	}
	
	method energiaParaMover() {
		return 10
	}
	
	method vidaVisual() {
		return if(energia > 750) 1000 
			   else if(energia > 500) 750
			   else if(energia > 250) 500
			   else if(energia > 100) 250
			   else if(energia > 0) 100
			   else 0
			   
	}
	
	method tieneEnergiaParaMover() {
		return energia > self.energiaParaMover()

	}
	
	method pertenece(posicion) {
		return tablero.pertenece(posicion)
	}
	
		method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion) 
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima) and self.estado().puedeMover()
	}
	
	method validarMover(direccion) {
		if(not self.sePuedeMover(direccion)) {
			self.error("No puedo moverme ahí")
		} 
	}
	
	method mover(direccion) {
		self.validarMover(direccion)
		const proxima = direccion.siguiente(self.position())		
		self.position(proxima)
		self.cambiarPerfil(direccion)
		
	}
	
	method cambiarPerfil(direccion){
		if (direccion == izquierda || direccion == derecha){
			self.perfil(direccion)	
		} else {
			self.perfil(self.perfil())
		}
	}
	
	method enfrentarseA(personaje) {
		energia -= personaje.energiaQueSaca()
		if(not self.tieneEnergiaParaMover()) {
			game.removeTickEvent("MOVER")
			game.schedule(3000, {game.stop()})
		}
	}
	
	method enfrentarseAVisual(personaje) {
		self.enfrentarseA(personaje)
	}
	

}


