import wollok.game.*
import direcciones.*

class Enemigo {
	var property position
	const property energiaQueSaca
	const property image
	 
	method quitarEnemigo()
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
			self.quitarEnemigo()
		}
	}
}

class Perro inherits Enemigo {
	 
	
	override method colision(personaje) {
		super(personaje)
		perrosManager.quitar(self)
	}
	

	override method quitarEnemigo() {
		perrosManager.quitar(self)
	}
	
}

class PerroIzq inherits Enemigo {
	 
	
	override method colision(personaje) {
		super(personaje)
		perrosManagerIzquierda.quitar(self)
	}
	

	override method quitarEnemigo() {
		perrosManagerIzquierda.quitar(self)
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
		return new PerroCallejero(energiaQueSaca = 100, position = position, image = "perro-callejero.png")
	}
}

object domesticadoFactory {
	method nuevo(position) {
		return new Perro(energiaQueSaca = 50, position = position, image = "perro-domesticado.png")
	}
}

object callejeroIzquierdaFactory {
	
	method nuevo(position) {
		return new PerroCallejeroIzq(energiaQueSaca = 100, position = position, image = "perro-callejero.png")
	}
}

object domesticadoIzquierdaFactory {
	method nuevo(position) {
		return new PerroIzq(energiaQueSaca = 50, position = position, image = "perro-domesticado-izquierda.png")
	}
}

class EnemigosManager {
	const generados = #{}
	const factories
	
	method generar(position)
	
	
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
	
	
}

object perrosManager inherits EnemigosManager(factories = [callejeroFactory, domesticadoFactory]) {
	
	
	override method generar(position) {
		const perro = self.seleccionarFactory().nuevo(position) 		
		game.addVisual(perro)	
		generados.add(perro)
		
	}
	
	method quitar(perro) {
		generados.remove(perro)
		game.removeVisual(perro)
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
		return new Humano(position = position, energiaQueSaca = 4000, image = "humana-alcohol.png")
	}
}

object antiCarpiFactory {
	method nuevo(position) {
		return new Humano(position = position, image = "humana-anti-carpi.png", energiaQueSaca = 4000)
	}
}


class Humano inherits Enemigo{
	
	
	override method quitarEnemigo() {
		humanosManager.quitar(self)
	}

}

object humanosManager inherits EnemigosManager(factories = [alcoholicaFactory, antiCarpiFactory]) {
	
	const limite = 3	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			const humana = self.seleccionarFactory().nuevo(position) 		
			game.addVisual(humana)	
			generados.add(humana)
			
		}
	}
	
	method quitar(humana) {
		generados.remove(humana)
		game.removeVisual(humana)
	}
	
}


class Auto inherits Enemigo {
	
	override method quitarEnemigo() {
		autosManager.quitar(self)
	}
	
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
		return new Auto(position = position, image = "auto.gif", energiaQueSaca = 200)
	}
}

object autosManager inherits EnemigosManager(factories = [autoFactory]) {
	
	const limite = 5	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			const auto = self.seleccionarFactory().nuevo(position) 		
			game.addVisual(auto)	
			generados.add(auto)
			
		}
	}
	
	method quitar(auto) {
		generados.remove(auto)
		game.removeVisual(auto)
	}
	
}

class Ganso inherits Enemigo {
	
	override method quitarEnemigo() {
		gansosManager.quitar(self)
	}
}

object gansoFactory {
	method nuevo(position) {
		return new Ganso(position = position, image = "ganso.png", energiaQueSaca = 200)
	}
}

object gansosManager inherits EnemigosManager(factories = [gansoFactory]) {
	
	const limite = 5	
	
	override method generar(position) {
		if(generados.size() < limite ) {
			const ganso = self.seleccionarFactory().nuevo(position) 		
			game.addVisual(ganso)	
			generados.add(ganso)
			
		}
	}
	
	method quitar(ganso) {
		generados.remove(ganso)
		game.removeVisual(ganso)
	}
	
}

class Charco {
	method image() {
		return "charco.png"
	}
}
