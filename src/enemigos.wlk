import wollok.game.*
import direcciones.*

class Perro {
	var property position = game.at(0, 5)
	const energiaQueSaca
	
	method image() 
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
		perrosManager.quitar(self)
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
	
	
}

class PerroDomesticado inherits Perro {
	override method image() {
		return "perro-domesticado.png"
	}
	
}

class PerroCallejero inherits Perro {
	override method image() {
		return "perro-callejero.png"
	}
	
	override method colision(personaje) {
		super(personaje)
		personaje.position(game.at(personaje.position().x(), personaje.position().y()-3))	
	}
}

object callejeroFactory {
	
	method nuevo() {
		return new PerroCallejero(energiaQueSaca = 100)
	}
}

object domesticadoFactory {
	method nuevo() {
		return new PerroDomesticado(energiaQueSaca = 50)
	}
}

object perrosManager {
	
	const generados = #{}
	
	const factories = [callejeroFactory, domesticadoFactory]
	
	
	method seleccionarFactory() {
		return factories.anyOne() 
	}
	
	method iniciarGeneracionYMovimiento() {
		self.iniciarGeneracion(2)
		self.iniciarMovimiento()
	}
	
	method iniciarGeneracion(segundos) {
		game.onTick(segundos * 1000,"PERROS", {self.generar()})
	}
	
	method cambiarGeneracion(segundos) {
		game.removeTickEvent("PERROS")
		self.iniciarGeneracion(segundos)
	}
	
	method iniciarMovimiento() {
		game.onTick(1000, "MOVER", { generados.forEach({ perro => perro.mover()}) })
	}
	
	method generar() {
		const perro = self.seleccionarFactory().nuevo() 		
		game.addVisual(perro)	
		generados.add(perro)
		
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