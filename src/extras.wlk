import wollok.game.*
import carpincho.*

object pasto {
	
	var property position=game.at(0, 0)
	
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
