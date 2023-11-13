import wollok.game.*
import carpincho.*

class Pasto {
	
	const property position
	
	method image() {
		return "pasto.png"
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
