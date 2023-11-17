import wollok.game.*
import carpincho.*



object vida {
	method image() {
		return return "vida-" + carpincho.vidaVisual() + ".png"
	}
	
	method position() {
		return game.at(0, game.height() - 2) 
		
	}
	
	method colision(personaje) {}
}

class Salida {
	const property position
	
	method image() {
		return "topDoor-closed.png"
	}
	
	method colision(){
		game.stop()
	}
}


class Muro {
	const property position
	const property image = "muro.png"
	
	method solido() {
		return true
	}
	
}

class Negro{
		const property position
		const property image = "black.png"
	
}


