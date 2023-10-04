import wollok.game.*
import direcciones.*

class Perro {
	var property position = game.at(0, 5)
	const energiaQueSaca
	const estado  
	
	method image() {
		return estado.image()
	}
	
	method colision(personaje) {
		estado.colision(personaje, self)
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(){
		const proxima = derecha.siguiente(self.position())
		if(self.puedeOcupar(proxima)) {
			self.position(proxima)
		} else {
			perrosManager.quitar(self)
		}
	}
	
	
//	method proximaDireccion(){
//		if (self.puedeOcupar(derecha.siguiente(self.position())) && not self.estaDeRegreso()) {
//			estaDeRegreso = false
//			return derecha.siguiente(self.position())
//		}
//		else if (self.puedeOcupar(izquierda.siguiente(self.position()))){
//			estaDeRegreso = true
//			return izquierda.siguiente(self.position())
//		}
//		else{
//			estaDeRegreso = false
//			return derecha.siguiente(self.position())
//		}
//	
//	}
	
}

object perroDomesticado {
	method image() {
		return "perro-domesticado.png"
	}
	
	method colision(personaje, perro) {
		personaje.enfrentarseAVisual(perro)
		perrosManager.quitar(perro)	
	}
}

object perroCallejero {
	method image() {
		return "perro-callejero.png"
	}
	
	method colision(personaje, perro) {
		personaje.enfrentarseAVisual(perro)
		personaje.position(game.at(personaje.position().x(), personaje.position().y()-3))	
		perrosManager.quitar(perro)
	}
}

object callejeroFactory {
	
	method nuevo() {
		return new Perro(energiaQueSaca = 100, estado = perroCallejero)
	}
}

object domesticadoFactory {
	method nuevo() {
		return new Perro(energiaQueSaca = 50, estado = perroDomesticado)
	}
}

object perrosManager {
	
	var generados = #{}
	
	const factories = [callejeroFactory, domesticadoFactory]
	
	
	method seleccionarFactory() {
		return factories.anyOne() //igual de probabilidad
	}
	
	method generar() {
		const perro = self.seleccionarFactory().nuevo() 		
		game.addVisual(perro)	
		generados.add(perro)
		game.onTick(1000, "MOVER", { perro.mover() })
	}
	
	method quitar(perro) {
		generados.remove(perro)
		game.removeVisual(perro)
	}
	

}


object humano {
	var property position = game.at(0, 7)
	const energiaQueSaca = 4000
	var property estaDeRegreso = false
	
	method image() {
		return "humana.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(){
		const proxima = self.proximaDireccion()
		self.position(proxima)
	}
	
	method proximaDireccion(){
		if (self.puedeOcupar(derecha.siguiente(self.position())) && not self.estaDeRegreso()) {
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
		else if (self.puedeOcupar(izquierda.siguiente(self.position()))){
			estaDeRegreso = true
			return izquierda.siguiente(self.position())
		}
		else{
			estaDeRegreso = false
			return derecha.siguiente(self.position())
		}
	
	}
}

object auto {
	
}