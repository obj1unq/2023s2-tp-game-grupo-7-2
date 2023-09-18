import wollok.game.*

object carpincho {
	var position = game.at(2, 5)
	
	method position() {
		return position
	}

	method position(_position) {
		position = _position
	}
	
	method image() = "carpincho-izquierda.png"
	
	method mover(direccion) {
		const proxima = direccion.siguiente(self.position())		
		self.position(proxima)		
	}
}
