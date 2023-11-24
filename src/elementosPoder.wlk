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
			elementos.forEach({elemento => elemento.agregarYGenerar(generados)})
		}
	}
	
	method quitar(elemento) {
		generados.remove(elemento)
		game.removeVisual(elemento)
	}
}

class ElementoMate {
	var property position
	
	method image()
	
	method colision(personaje) {
		personaje.agarrarElemento(self)	
		elementosMateManager.quitar(self)
	}
	
	method accionColision(personaje) {}
	
	method solido() {
		return false
	}
	
	method agregarYGenerar(generados) {
		game.addVisual(self)
		generados.add(self)
	}
}


object mate inherits ElementoMate(position=randomizer.emptyPosition()) {
	
	
	override method image() {
		return "mate.png"
	}
		
}

object yerba inherits ElementoMate(position=randomizer.emptyPosition()) {
	
	override method image() {
		return "yerba.png"
	}

}

object termo inherits ElementoMate(position=randomizer.emptyPosition()) {

	override method image() {
		return "termo.png"
	}

}

