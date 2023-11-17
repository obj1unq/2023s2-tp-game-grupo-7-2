import wollok.game.*
import randomizer.*

object charco {
	method position() = game.at(5, 5)
	method image() = "charco.png"
	
}


class Cerca {
	var property position = game.at(0, 0)
	
	method colision(personaje) {}
	method accionColision(personaje) {}
	
	method image() = "cerca.png"
	
}

