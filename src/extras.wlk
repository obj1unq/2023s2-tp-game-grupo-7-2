import wollok.game.*
import carpincho.*
import direcciones.*

class Extra {
	var property position
	
	method image()
	
	method colision(personaje) {}
	method accionColision(personaje) {}
}

class Pasto inherits Extra {

	
	override method image() {
		return "pasto.png"
	}
	
}

class Asfalto inherits Extra {
	
	override method image() {
		return "asfalto.png"
	}
	
}

class Rio inherits Extra {
	const property energiaQueSaca = 50
	
	override method image() {
		return "rio.png"
	}
	

	override method accionColision(personaje) {
		personaje.enfrentarseAVisual(self)
	}
	
}

class RioBotella inherits Rio {
	
	override method image() {
		return "rio-botella.png"
	}
	
}

class Tronco inherits Extra {
	
	
	override method image() {
		return "tronco.png"
	}
	
	override method colision(personaje) {
		personaje.moverConObjeto(self)
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(direccion){
		const proxima = direccion.siguiente(self.position())
		if(self.puedeOcupar(proxima)) {
			self.position(proxima)
		} else {
			self.quitarTronco()
		}
	}
	
	method quitarTronco() {
		troncosManager.quitar(self)
	}
}

object troncosManager {
	const generados = #{}

	method iniciarGeneracionYMovimiento(segundos, position, direccion) {
		self.iniciarGeneracion(segundos, position)
		self.iniciarMovimiento(direccion)
	}
	
	method iniciarGeneracion(segundos, position) {
		game.onTick(segundos * 1000,"EXTRAS", {self.generar(position)})
	}
	
	method iniciarMovimiento(direccion) {
		game.onTick(1000, "MOVER", { generados.forEach({ enemigo => enemigo.mover(direccion)}) })
	}
	
	method generar(position) {
		const tronco = new Tronco(position = position) 		
		game.addVisual(tronco)	
		generados.add(tronco)
		
	}
	
	method quitar(tronco) {
		generados.remove(tronco)
		game.removeVisual(tronco)
	}
}



class Vereda inherits Extra {
	
	
	override method image() {
		return "vereda.png"
	}
	
}

object vida inherits Extra(position = game.at(0, 0)) {
	
	
	override method image() {
		return return "vida-" + carpincho.vidaVisual() + ".png"
	}
	
}

object salida inherits Extra(position = game.at(0, 0)){

	
	override method image() {
		return "salida.png"
	}
}
