import wollok.game.*
import mapa.*
import pantallas.*

object tablero {

	method pertenece(position) {
		return position.x().between(0, game.width() - 1) and 
			position.y().between(0, game.height() - 1)
	}
	
	method puedeOcupar(position) {
		return self.pertenece(position) and not self.haySolido(position) 
	}
	
	method haySolido(position) {
		return game.getObjectsIn(position).any({elemento => elemento.solido()})
	}
	
	method iniciar() {
		game.width(15)
		game.height(11)
		game.cellSize(70)
		game.addVisual(pantallaInicio)
		keyboard.enter().onPressDo({mapa.generar()})
	}

}
