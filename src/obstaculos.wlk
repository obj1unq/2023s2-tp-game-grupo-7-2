import wollok.game.*
import randomizer.*


class Cerca {
	var property position = game.at(0, 0)
	
	method colision(personaje) {}
	method accionColision(personaje) {}
	
	method solido() {
		return true
	}
	
	method image() = "cerca.png"
	
}

