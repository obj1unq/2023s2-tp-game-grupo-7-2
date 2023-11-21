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

class PerroIzq inherits Enemigo {
	 
	
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

class PerroCallejeroIzq inherits PerroIzq {
	
	override method colision(personaje) {
		super(personaje)
		personaje.position(game.at(personaje.position().x(), personaje.position().y() - self.efectoDeEnfrentamiento(personaje.position())))	
	}
	
	method efectoDeEnfrentamiento(posicionPersonaje) {
		return if(posicionPersonaje.y() >= 3) 3 else posicionPersonaje.y()
	}
}

object callejeroFactory {
	
	method nuevo(position) {
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perrosManager)
	}
}

object domesticadoFactory {
	method nuevo(position) {
		return new Perro(energiaQueSaca = 50, position = position, image = "perro-domesticado.png", manager = perrosManager)
	}
}

object callejeroIzquierdaFactory {
	
	method nuevo(position) {
		return new PerroCallejeroIzq(energiaQueSaca = 100, position = position, image = "perro-callejero.png", manager = perrosManagerIzquierda)
	}
}

object domesticadoIzquierdaFactory {
	method nuevo(position) {
		return new PerroIzq(energiaQueSaca = 50, position = position, image = "perro-domesticado-izquierda.png", manager = perrosManagerIzquierda)
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
		const perroIzq = self.seleccionarFactory().nuevo(position) 		
		game.addVisual(perroIzq)	
		generados.add(perroIzq)
		
	}
	
	method quitar(enemigo) {
		generados.remove(enemigo)
		game.removeVisual(enemigo)
	}
	
	
}

object perrosManager inherits EnemigosManager(factories = [callejeroFactory, domesticadoFactory]) {
	
	
	override method generar(position) {
		const perro = self.seleccionarFactory().nuevo(position) 		
		game.addVisual(perro)	
		generados.add(perro)
		
	}

}

object perrosManagerIzquierda inherits EnemigosManager(factories = [callejeroIzquierdaFactory, domesticadoIzquierdaFactory]) {
	
	
	override method generar(position) {
		const perroIzq = self.seleccionarFactory().nuevo(position) 		
		game.addVisual(perroIzq)	
		generados.add(perroIzq)
		
	}
	
	method quitar(perroIzq) {
		generados.remove(perroIzq)
		game.removeVisual(perroIzq)
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
	
	const limite = 3	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			super(position)
		}
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
	
	const limite = 5	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			super(position)
			
		}
	}
	
}

object gansoFactory {
	method nuevo(position) {
		return new Enemigo(position = position, image = "ganso.png", energiaQueSaca = 200, manager = gansosManager)
	}
}

object gansosManager inherits EnemigosManager(factories = [gansoFactory]) {
	
	const limite = 5	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			super(position)
			
		}
	}

	
}
