import wollok.game.*
import carpincho.*

class Pasto {
	
	const property position
	
	method image() {
		return "pasto.png"
	}
	
	method colision(personaje) {}
	
}

class Asfalto {
	
	const property position
	
	method image() {
		return "asfalto.png"
	}
	
	method colision(personaje) {}
	
}

class Rio {
	
	const property position
	const energiaQueSaca
	
	method image() {
		return "rio.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
}

class RioBotella {
	
	const property position
	const energiaQueSaca
	
	method image() {
		return "rio-botella.png"
	}
	
	method colision(personaje) {}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
}

class Tronco {
	
	const property position
	
	method image() {
		return "tronco.png"
	}
	
	method colision(personaje) {}
	
}

object vida {
	var property position=game.at(0, game.height() - 1)
	
	
	method image() {
		return return "vida-" + carpincho.vidaVisual() + ".png"
	}
	
	method colision(personaje) {}
}

object salida {
	var property position=game.at(7, 11)

	
	method image() {
		return "salida.png"
	}
	
	method colision(personaje){
		game.stop()
	}
}
