import wollok.game.*
import carpincho.*
import direcciones.*
import sonidos.*

class Extra {

	var property position

	method image()

	method colision(personaje) {
	}

	method accionColision(personaje) {
	}

	method solido() {
		return false
	}

}

class Pasto inherits Extra {

	override method image() {
		return "pasto.png"
	}

}

class Tierra inherits Extra {

	override method image() {
		return "tierra.png"
	}

}

class Asfalto inherits Extra {

	override method image() {
		return "asfalto.png"
	}

}

class TroncoConAgua inherits Extra {

	override method image() {
		return "troncoConAgua.png"
	}

}

class Piso inherits Extra {

	override method image() {
		return "piso.png"
	}

}

class Rio inherits Extra {

	const property energiaQueSaca = 10

	override method image() {
		return "rio.png"
	}

	override method accionColision(personaje) {
		personaje.enfrentarseAVisual(self)
	}

}

class RioBotella inherits Rio {

	override method image() {
		return "rio-botella.png"
	}

}

/*class TroncoIzqADer inherits Extra {

 * 	override method image() {
 * 		return "troncoConAgua.png"
 * 	}

 * 	override method colision(personaje) {
 * 		if (personaje.position().equals(self.position())) {
 * 			personaje.moverConObjeto(self)
 * 		}
 * 	}

 * 	method puedeOcupar(posicion) {
 * 		return tablero.pertenece(posicion)
 * 	}

 * 	method mover() {
 * 	 	const proxima = self.position().right(1)
 * 		if (self.puedeOcupar(proxima)) {
 * 			self.position(proxima)
 * 		} else {
 * 			self.quitarTronco()
 * 		
 * 	}

 * 	method estaCarpinchoSobre() {
 * 		return self.position().equals(carpincho.position())
 * 	}

 * 	method quitarTronco() {
 * 		troncosManager.quitar(self)
 * 	}
 * 	

 * }

 * class TroncoDerAIzq inherits Extra {

 * 	override method image() {
 * 		return "troncoConAgua.png"
 * 	}

 * 	override method colision(personaje) {
 * 		if (personaje.position().equals(self.position())) {
 * 			personaje.moverConObjeto(self)
 * 		}
 * 	}

 * 	method puedeOcupar(posicion) {
 * 		return tablero.pertenece(posicion)
 * 	}

 * 	method mover() {
 * 		const proxima = self.position().left(1)
 * 		if (self.puedeOcupar(proxima)) {
 * 			self.position(proxima)
 * 		} else {
 * 			self.quitarTronco()
 * 		} 
 * 	}

 * 	method estaCarpinchoSobre() {
 * 		return self.position().equals(carpincho.position())
 * 	}

 *   	method quitarTronco() {
 * 		troncosManager.quitar(self)
 * 	}

 }*/
object troncosManager {

	const property generados = #{}

	method iniciarGeneracionYMovimiento(segundos, position, direccion) {
		self.iniciarGeneracion(segundos, position, direccion)
		self.iniciarMovimiento()
	}

	method iniciarGeneracion(segundos, position, direccion) {
	// game.onTick(segundos * 1000, "EXTRAS", { self.generar(position, direccion)})
	}

	method iniciarMovimiento() {
		game.onTick(2000, "MOVER", { generados.forEach({ extra => extra.mover()})})
	}

	/*method generar(position, direccion) {
	 * 	const tronco = if (direccion.equals(derecha)) {
	 * 		new TroncoIzqADer(position = position)
	 * 	} else {
	 * 		new TroncoDerAIzq(position = position)
	 * 	}
	 * 	game.addVisual(tronco)
	 * 	generados.add(tronco)
	 * 	if (tronco.estaCarpinchoSobre()) {
	 * 		game.addVisual(carpincho)
	 * 	}
	 }*/
	method troncoSobreCarpincho(posicion) {
		self.generados().find({ tronco => tronco.position().equals(posicion)})
	}

	method quitar(tronco) {
		generados.remove(tronco)
		game.removeVisual(tronco)
	}

}

class Vereda inherits Extra {

	override method image() {
		return "vereda.png"
	}

}

object vida inherits Extra(position = game.at(0, 0)) {

	override method image() {
		return return "vida-" + carpincho.vidaVisual() + ".png"
	}

	override method solido() {
		return true
	}

}

object salida inherits Extra(position = game.at(0, 0)) {

	override method image() {
		return "familia-carpincho.png"
	}

	override method accionColision(personaje) {
		game.schedule(3000, { game.stop()})
		game.schedule(1000, { sonidoWinner.reproducir() })
	}

}

