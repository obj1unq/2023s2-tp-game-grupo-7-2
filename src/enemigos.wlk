import wollok.game.*
import direcciones.*

object perro {
	var property position = game.at(0, 5)
	const energiaQueSaca = 50
	
	method image() {
		return "perro.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
		game.removeVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(){
		const proxima = derecha.siguiente(self.position())
		if(self.puedeOcupar(proxima)) {
			self.position(proxima)
		}
	}
	
}

object humano {
	var property position = game.at(0, 7)
	const energiaQueSaca = 4000
	
	method image() {
		return "humana.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(){
		const proxima = derecha.siguiente(self.position())
		if(self.puedeOcupar(proxima)) {
			self.position(proxima)
		}
	}
}

object auto {
	
}