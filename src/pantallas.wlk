import wollok.game.*

class Pantalla {
	const property position = game.at(0, 0)
	
	const property image
}

object pantallaInicio inherits Pantalla(image = "pantalla-inicio.png") {}

object pantallaGanador inherits Pantalla(image = "pantalla-ganador.png") {}

object pantallaPerdedor inherits Pantalla(image = "pantalla-perdedor.png") {}
