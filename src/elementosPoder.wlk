import wollok.game.*
import randomizer.*

//new Alpiste(position = randomizer.emptyPosition(), peso=(40..100).anyOne())


//object mateFactory {
//	method nuevo() {
//		return new Mate(position=randomizer.emptyPosition())
//	}
//}
//
//object yerbaFactory {
//	
//	method nuevo() {
//		return new Yerba(position=randomizer.emptyPosition())
//	}
//}
//
//object termoFactory {
//	method nuevo() {
//		return new Termo(position=randomizer.emptyPosition())
//	}
//}

object elementosMateManager {
	
	var generados = #{}
	
	const elementos = [mate, yerba, termo]
	
	
	//method seleccionarFactory() {

//      Para una probabilidad de 10% alpiste 90% manzana		
//		const x = 0.randomUpTo(1)
//		return if (x < 0.10) alpisteFactory else manzanaFactory 
		
	//	return factories.anyOne() //igual de probabilidad
	//}
	
	method generar() {
		if(generados.size() == 0 ) { 		
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
	const property position
	
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

