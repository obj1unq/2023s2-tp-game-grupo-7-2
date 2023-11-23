import wollok.game.*
import direcciones.*
import tablero.*

class Enemigo {
	var property position
	const property energiaQueSaca
	const property image
	const manager
	 
	method accionColision(personaje) {}
	
	method colision(personaje) {
		if(not personaje.poder().estaActivo()) {
			personaje.enfrentarseAVisual(self)
			self.efectoDeEnfrentarse(personaje)
		}
	}
	
	method efectoDeEnfrentarse(personaje) {}
	
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

class AnimalDomestico inherits Enemigo {
	 
	override method efectoDeEnfrentarse(personaje) {
		manager.quitar(self)
	}
	
}

class PerroCallejero inherits AnimalDomestico {
	
	override method efectoDeEnfrentarse(personaje) {
		super(personaje)
		personaje.position(game.at(personaje.position().x(), personaje.position().y() - self.efectoDeEnfrentamiento(personaje.position())))	
	}
	
	method efectoDeEnfrentamiento(posicionPersonaje) {
		return if(posicionPersonaje.y() >= 3) 3 else posicionPersonaje.y()
	}
}

class EnemigoManager {
	const generados = #{}
	const factories
	
	method reiniciar() {
		generados.clear()
	}
	
	
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
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perroManager)
	}
}

object callejeroIzquierdaFactory {
	
	method nuevo(position) {
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perroManagerIzquierda)
	}
}

object domesticadoFactory {
	method nuevo(position) {
		return new AnimalDomestico(energiaQueSaca = 50, position = position, image = "perro-domesticado.png", manager = perroManager)
	}
}


object domesticadoIzquierdaFactory {
	method nuevo(position) {
		return new AnimalDomestico(energiaQueSaca = 50, position = position, image = "perro-domesticado-izquierda.png", manager = perroManagerIzquierda)
	}
}

object perroManager inherits EnemigoManager(factories = [callejeroFactory, domesticadoFactory]) {
	
	override method limite() {
		return 10
	}
}

object perroManagerIzquierda inherits EnemigoManager(factories = [callejeroIzquierdaFactory, domesticadoIzquierdaFactory]) {
	
	override method limite() {
		return 9
	}
}

object alcoholicaFactory {
	
	method nuevo(position) {
		return new Enemigo(position = position, energiaQueSaca = 4000, image = "humana-alcohol.png", manager = humanoManager)
	}
}

object antiCarpiFactory {
	method nuevo(position) {
		return new Enemigo(position = position, image = "humana-anti-carpi.png", energiaQueSaca = 4000, manager = humanoManager)
	}
}

object humanoManager inherits EnemigoManager(factories = [alcoholicaFactory, antiCarpiFactory]) {
	
	override method limite() {
		return 3
	}
}


class Auto inherits Enemigo {
	
	
	override method efectoDeEnfrentarse(personaje) {
		autoManager.quitar(self)
		personaje.position(game.at(personaje.position().x() - self.efectoDeEnfrentamiento(personaje.position()), personaje.position().y()))		
	}
	
	method efectoDeEnfrentamiento(posicionPersonaje) {
		return if(posicionPersonaje.x() >= 4) 4 else posicionPersonaje.x()
	}
}

object autoVioletaFactory {
	method nuevo(position) {
		return new Auto(position = position, image = "auto-violeta-izquierda.gif", energiaQueSaca = 200, manager = autoManager)
	}
}

object autoAzulFactory {
	method nuevo(position) {
		return new Auto(position = position, image = "auto-azul-izquierda.png", energiaQueSaca = 200, manager = autoManager)
	}
}

object autoCelesteFactory {
	method nuevo(position) {
		return new Auto(position = position, image = "auto-celeste-derecha.png", energiaQueSaca = 200, manager = autoManagerDerecha)
	}
}

object autoRojoFactory {
	method nuevo(position) {
		return new Auto(position = position, image = "auto-rojo-derecha.png", energiaQueSaca = 200, manager = autoManagerDerecha)
	}
}

object autoManager inherits EnemigoManager(factories = [autoVioletaFactory, autoAzulFactory]) {
	
	override method limite() {
		return 5
	}
	
}

object autoManagerDerecha inherits EnemigoManager(factories = [autoCelesteFactory, autoRojoFactory]) {
	
	override method limite() {
		return 4
	}
	
}

object gansoFactory {
	method nuevo(position) {
		return new AnimalDomestico(position = position, image = "ganso.png", energiaQueSaca = 200, manager = gansoManager)
	}
}

object gansoManager inherits EnemigoManager(factories = [gansoFactory]) {
	
	override method limite() {
		return 4
	}

}
