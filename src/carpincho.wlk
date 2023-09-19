import wollok.game.*
import direcciones.*

object carpincho {
	var position = game.at(2, 5)
	
	method position() {
		return position
	}

	method position(_position) {
		position = _position
	}
	
	method image() = "carpincho-izquierda.png"
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}
	
	method validarMover(direccion) {
		if(not self.sePuedeMover(direccion)) {
			self.error("No puedo ir ahí")
		} 
	}
	
	method mover(direccion) {
		//self.validarMover(direccion)
		if( self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())		
		self.position(proxima)	
		}
			
	}
}
