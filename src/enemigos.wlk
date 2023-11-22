import wollok.game.*
import direcciones.*

class Enemigo {
	var property position
	const property energiaQueSaca
	const property image
	const manager
	 
	method accionColision(personaje) {}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
	}
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method mover(direccion){
		const proxima = direccion.siguiente(self.position())
		if(self.puedeOcupar(proxima)) {
			self.position(proxima)
		} else {
			manager.quitar(self)
		}
	}
	
	method solido() {
		return false
	}
}

class Perro inherits Enemigo {
	 
	
	override method colision(personaje) {
		super(personaje)
		manager.quitar(self)
	}
	
}

class PerroCallejero inherits Perro {
	
	override method colision(personaje) {
		super(personaje)
		personaje.position(game.at(personaje.position().x(), personaje.position().y() - self.efectoDeEnfrentamiento(personaje.position())))	
	}
	
	method efectoDeEnfrentamiento(posicionPersonaje) {
		return if(posicionPersonaje.x() >= 3) 3 else posicionPersonaje.x()
	}
}

class EnemigosManager {
	const generados = #{}
	const factories
	
	
	method seleccionarFactory() {
		return factories.anyOne() 
	}
	
	method iniciarGeneracionYMovimiento(segundos, position, direccion) {
		self.iniciarGeneracion(segundos, position)
		self.iniciarMovimiento(direccion)
	}
	
	method iniciarGeneracion(segundos, position) {
		game.onTick(segundos * 1000,"ENEMIGOS", {self.generar(position)})
	}
	
	method iniciarMovimiento(direccion) {
		game.onTick(1000, "MOVER", { generados.forEach({ enemigo => enemigo.mover(direccion)}) })
	}
	
	method cambiarGeneracion(segundos, position) {
		game.removeTickEvent("ENEMIGOS")
		self.iniciarGeneracion(segundos, position)
	}
	
	method generar(position) {
		if(generados.size() < self.limite() ) {
			const enemigo = self.seleccionarFactory().nuevo(position) 		
			game.addVisual(enemigo)	
			generados.add(enemigo)
		}
	}
	
	method quitar(enemigo) {
		generados.remove(enemigo)
		game.removeVisual(enemigo)
	}
	
	
	method limite()
}


object callejeroFactory {
	
	method nuevo(position) {
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perrosManager)
	}
}

object callejeroIzquierdaFactory {
	
	method nuevo(position) {
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perrosManagerIzquierda)
	}
}

object domesticadoFactory {
	method nuevo(position) {
		return new Perro(energiaQueSaca = 50, position = position, image = "perro-domesticado.png", manager = perrosManager)
	}
}


object domesticadoIzquierdaFactory {
	method nuevo(position) {
		return new Perro(energiaQueSaca = 50, position = position, image = "perro-domesticado-izquierda.png", manager = perrosManagerIzquierda)
	}
}

object perrosManager inherits EnemigosManager(factories = [callejeroFactory, domesticadoFactory]) {
	
	override method limite() {
		return 10
	}
}

object perrosManagerIzquierda inherits EnemigosManager(factories = [callejeroIzquierdaFactory, domesticadoIzquierdaFactory]) {
	
	override method limite() {
		return 9
	}
}

object alcoholicaFactory {
	
	method nuevo(position) {
		return new Enemigo(position = position, energiaQueSaca = 4000, image = "humana-alcohol.png", manager = humanosManager)
	}
}

object antiCarpiFactory {
	method nuevo(position) {
		return new Enemigo(position = position, image = "humana-anti-carpi.png", energiaQueSaca = 4000, manager = humanosManager)
	}
}

object humanosManager inherits EnemigosManager(factories = [alcoholicaFactory, antiCarpiFactory]) {
	
	override method limite() {
		return 3
	}
}


class Auto inherits Enemigo {
	
	
	override method colision(personaje) {
		super(personaje)
		autosManager.quitar(self)
		personaje.position(game.at(personaje.position().x() - self.efectoDeEnfrentamiento(personaje.position()), personaje.position().y()))	
	}
	
	method efectoDeEnfrentamiento(posicionPersonaje) {
		return if(posicionPersonaje.x() >= 4) 4 else posicionPersonaje.x()
	}
}

object autoFactory {
	method nuevo(position) {
		return new Auto(position = position, image = "auto.gif", energiaQueSaca = 200, manager = autosManager)
	}
}

object autosManager inherits EnemigosManager(factories = [autoFactory]) {
	
	override method limite() {
		return 5
	}
	
}

object gansoFactory {
	method nuevo(position) {
		return new Perro(position = position, image = "ganso.png", energiaQueSaca = 200, manager = gansosManager)
	}
}

object gansosManager inherits EnemigosManager(factories = [gansoFactory]) {
	
	override method limite() {
		return 4
	}

}
