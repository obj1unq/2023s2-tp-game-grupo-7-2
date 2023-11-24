import wollok.game.*
import randomizer.*

object elementosMateManager {
	
	var generados = #{}
	
	const elementos = [mate, yerba, termo]
	
	method reiniciar() {
		generados.clear()
		elementos.forEach({elemento => elemento.position(randomizer.emptyPosition())})
	}
	
	method generar() {
		
		if(generados.isEmpty()) { 		
			game.addVisual(mate)	
			game.addVisual(yerba)
			game.addVisual(termo)
			generados.addAll(elementos)
		}
	}
	
	method quitar(elemento) {
		generados.remove(elemento)
		game.removeVisual(elemento)
	}
}

class ElementosMate {
	var property position
	
	method image() {
		return "mate.png"
	}
	
	method colision(personaje) {
		personaje.agarrarElemento(self)	
		elementosMateManager.quitar(self)
	}
	
	method accionColision(personaje) {}
	
	method solido() {
		return false
	}
}


object mate inherits ElementosMate(position=randomizer.emptyPosition()) {
	
	
	override method image() {
		return "mate.png"
	}
		
}

object yerba inherits ElementosMate(position=randomizer.emptyPosition()) {
	
	override method image() {
		return "yerba.png"
	}

}

object termo inherits ElementosMate(position=randomizer.emptyPosition()) {

	override method image() {
		return "termo.png"
	}

}

