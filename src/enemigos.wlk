import wollok.game.*
import direcciones.*

class Perro {
	var property position = game.at(0, 4)
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

object alcoholicaFactory {
	
	method nuevo() {
		return new Humano(position = game.at(0, 7))
	}
}

object antiCarpiFactory {
	method nuevo() {
		return new Humano(position = game.at(0, 7), image = "humana-anti-carpi.png")
	}
}


class Humano {
	var property position
	var property image = "humana-alcohol.png"
	const energiaQueSaca = 4000
	var property estado = estadoDerecha
	

	
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
		const proxima = estado.moverse(self.position())
		if (not self.puedeOcupar(proxima)) {
			estado = estado.siguienteEstado()
		}
		return proxima
	}
	

}

object humanosManager {
	
	const generados = #{}
	const limite = 3
	
	const factories = [alcoholicaFactory, antiCarpiFactory]
	
	
	method seleccionarFactory() {
		return factories.anyOne() 
	}
	
	method iniciarGeneracionYMovimiento() {
		self.iniciarGeneracion(3)
		self.iniciarMovimiento()
	}
	
	method iniciarGeneracion(segundos) {
		game.onTick(segundos * 1000,"HUMANA", {self.generar()})
	}
	
	method iniciarMovimiento() {
		game.onTick(1000, "MOVER", { generados.forEach({ humana => humana.mover()}) })
	}
	
	method generar() {
		if(generados.size() < limite ) {
			const humana = self.seleccionarFactory().nuevo() 		
			game.addVisual(humana)	
			generados.add(humana)	
		}
	}
	
}

object estadoDerecha {
	
	
	method moverse(position) {
		return derecha.siguiente(position)
	}
	
	method siguienteEstado() {
		return estadoIzquierda
	}
}

object estadoIzquierda {
	method moverse(position) {
		return izquierda.siguiente(position)
	}
	
	method siguienteEstado() {
		return estadoDerecha
	}
}

object auto {
	
}

class Charco {
	method image() {
		return "charco.png"
	}
}
