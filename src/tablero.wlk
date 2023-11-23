import wollok.game.*
import mapa.*
import pantallas.*
import sonidos.*

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
	
	method configurar() {
		game.clear()
		
		game.width(15)
		game.height(11)
		game.cellSize(70)
	}
	
	method iniciar() {
		self.configurar()
		
		game.addVisual(pantallaInicio)
		keyboard.enter().onPressDo({mapa.generar()})
	}
	
	method perdedor() {
		self.configurar()
		
		game.addVisual(pantallaPerdedor)
		keyboard.enter().onPressDo({mapa.generar()})
		keyboard.space().onPressDo({game.stop()})
	}
	
	method ganador() {
		self.configurar()
		
		game.addVisual(pantallaGanador)
		keyboard.enter().onPressDo({mapa.generar()})
		keyboard.space().onPressDo({game.stop()})
	}

}
