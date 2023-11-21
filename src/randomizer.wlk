import wollok.game.*
import mapa.*
import extras.*

object randomizer {
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 2).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if( self.laPosicionEstaDisponible(position)) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
	method laPosicionEstaDisponible(posicion) {
		return not game.getObjectsIn(posicion).contains(salida) and 
		 	   not game.getObjectsIn(posicion).contains(vida) 
	}
	
}
