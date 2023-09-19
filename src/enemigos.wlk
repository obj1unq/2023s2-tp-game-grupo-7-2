import wollok.game.*

object perro {
	const  energiaQueSaca = 50
	method image() {
		return "perro.png"
	}
	
	method position() {
		return game.at(3, 7) 
		
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
		game.removeVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
}

object humano {
	const energiaQueSaca = 4000
	
	method image() {
		return "humana.png"
	}
	
	method position() {
		return game.at(4, 4) 
		
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
}

object auto {
	
}