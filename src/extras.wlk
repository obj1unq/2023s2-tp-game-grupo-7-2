import wollok.game.*
import carpincho.*
import direcciones.*
import sonidos.*

class Extra {

	var property position

	method image()

	method colision(personaje) {
	}

	method accionColision(personaje) {
	}

	method solido() {
		return false
	}

}

class Pasto inherits Extra {

	override method image() {
		return "pasto.png"
	}

}

class PastoConVida inherits Pasto {
	
	override method solido() {
		return true
	}

}

class Tierra inherits Extra {

	override method image() {
		return "tierra.png"
	}

}

class Asfalto inherits Extra {

	override method image() {
		return "asfalto.png"
	}

}

class TroncoConAgua inherits Extra {

	override method image() {
		return "troncoConAgua.png"
	}

}

class Piso inherits Extra {

	override method image() {
		return "piso.png"
	}

}

class Rio inherits Extra {

	const property energiaQueSaca = 10

	override method image() {
		return "rio.png"
	}

 	override method accionColision(personaje) {
 		if(not personaje.poder().estaActivo()) {
 			personaje.enfrentarseAVisual(self)
 		}
	}

}

class RioBotella inherits Rio {

	override method image() {
		return "rio-botella.png"
	}

}

class Vereda inherits Extra {

	override method image() {
		return "vereda.png"
	}

}

object vida inherits Extra(position = game.at(0, 0)) {

	override method image() {
		return "vida-" + carpincho.vidaVisual() + ".png"
	}

	override method solido() {
		return true
	}

}

object salida inherits Extra(position = game.at(0, 0)) {

	override method image() {
		return "familia-carpincho.png"
	}

	override method colision(personaje) {
		game.schedule(3000, { game.stop()})
		game.schedule(1000, { sonidoWinner.reproducir() })
	}

}

