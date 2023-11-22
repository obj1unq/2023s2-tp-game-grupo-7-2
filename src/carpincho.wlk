import wollok.game.*
import direcciones.*
import sonidos.*
import extras.*

object carpincho {

	var property position = game.at(0, 0)
	var energia = 1000
	const elementosParaSuperPoder = #{}
	var poder = desactivado


	method image() {
		return poder.imagen()
	}
	
	method poder() {
		return poder
	}

	method energiaParaMover() {
		return 10
	}

	method vidaVisual() {
		return if (energia > 750) 1000 else if (energia > 500) 750 else if (energia > 250) 500 else if (energia > 100) 250 else if (energia > 0) 100 else 0
	}

	method tieneEnergiaParaMover() {
		return energia > self.energiaParaMover()
	}

	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion) 
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima) and self.tieneEnergiaParaMover()
	}

	method validarMover(direccion) {
		if (not self.sePuedeMover(direccion)) {
			self.error("No puedo moverme ahí")
		}
	}


	method mover(direccion) {
		self.validarMover(direccion)
		const proxima = direccion.siguiente(self.position())		
		self.position(proxima)
		poder.perfil(direccion)
		
	}
	
	method enfrentarseAVisual(personaje) {
		energia -= personaje.energiaQueSaca()
		if(not self.tieneEnergiaParaMover()) {
			game.removeTickEvent("MOVER")
			game.schedule(3000, {game.stop()})
			sonidoGameover.reproducir()
				
		}	
	}
	
	method activarSuperPoder() {
		self.validarActivarSuperPoder()
		poder = activado
		game.schedule(5000, {poder = desactivado})
		elementosParaSuperPoder.removeAll(elementosParaSuperPoder)
	}
	
	method validarActivarSuperPoder() {
		if(not self.tieneElementosNecesariosParaSuperPoder()) {
			self.error("Todavia no puedo activar el poder!")
		}
	}
	
	method tieneElementosNecesariosParaSuperPoder() {
		return elementosParaSuperPoder.size() == 3
	}
	
	method moverConObjeto(objeto) {
		self.position(objeto.position())
	}
	
	method agarrarElemento(elemento) {
		self.validarAgarrarElemento(elemento)
		elementosParaSuperPoder.add(elemento)
	}
	
	method validarAgarrarElemento(elemento) {
		if (elementosParaSuperPoder.contains(elemento)) {
			self.error("Ya tengo este elemento!")
		}
	}
	
}

object activado {
	var property perfil = derecha
	method imagen() {
		return "super" + "-" + carpincho + "-" + self.perfil() + ".png"
	}
	
	method estaActivo() {
		return true
	}
}

object desactivado {
	var property perfil = derecha 
	method imagen() {
		return "" + carpincho + "-" + self.perfil() + ".png"
	}
	
	method estaActivo() {
		return false
	}
}

