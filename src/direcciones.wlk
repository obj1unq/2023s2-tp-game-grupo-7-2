import wollok.game.*
import mapa.*

object derecha {

	method siguiente(position) {
		return position.right(1)
	}

}

object izquierda {

	method siguiente(position) {
		return position.left(1)
	}

}

object arriba {

	method siguiente(position) {
		return position.up(1)
	}


}

object abajo {

	method siguiente(position) {
		return position.down(1)
	}

}

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

class Pantalla {
	const property position = game.at(0, 0)
	
	const property image
}

object pantallaInicio inherits Pantalla(image = "pantalla-inicio.png") {}

object pantallaGanador inherits Pantalla(image = "pantalla-ganador.png") {}

object pantallaPerdedor inherits Pantalla(image = "pantalla-perdedor.png") {}
