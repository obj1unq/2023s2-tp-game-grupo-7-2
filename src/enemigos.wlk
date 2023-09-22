import wollok.game.*
import direcciones.*

class Perro {
	var property position = game.at(0, 5)
	const energiaQueSaca = 50
	var property estaDeRegreso = false
	
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
		const proxima = self.proximaDireccion()
		self.position(proxima)
	}
	
	method proximaDireccion(){
		if (self.puedeOcupar(derecha.siguiente(self.position())) && not self.estaDeRegreso()) {
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
		else if (self.puedeOcupar(izquierda.siguiente(self.position()))){
			estaDeRegreso = true
			return izquierda.siguiente(self.position())
		}
		else{
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
	
	}
	
}

object humano {
	var property position = game.at(0, 7)
	const energiaQueSaca = 4000
	var property estaDeRegreso = false
	
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
		const proxima = self.proximaDireccion()
		self.position(proxima)
	}
	
	method proximaDireccion(){
		if (self.puedeOcupar(derecha.siguiente(self.position())) && not self.estaDeRegreso()) {
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
		else if (self.puedeOcupar(izquierda.siguiente(self.position()))){
			estaDeRegreso = true
			return izquierda.siguiente(self.position())
		}
		else{
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
	
	}
}

object auto {
	
}