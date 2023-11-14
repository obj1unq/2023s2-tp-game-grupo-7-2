import wollok.game.*
import direcciones.*

class Enemigo {
	var property position
	const energiaQueSaca
	const property image
	 
	method quitarEnemigo()
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
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

class PerroCallejero inherits Perro {
	
	override method colision(personaje) {
		super(personaje)
		personaje.position(game.at(personaje.position().x(), personaje.position().y()-3))	
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
	
	method cambiarGeneracion(segundos, position) {
		game.removeTickEvent("ENEMIGOS")
		self.iniciarGeneracion(segundos, position)
	}
	
	method iniciarMovimiento(direccion) {
		game.onTick(1000, "MOVER", { generados.forEach({ enemigo => enemigo.mover(direccion)}) })
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
		personaje.position(game.at(personaje.position().x()-4, personaje.position().y()))	
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
			const humana = self.seleccionarFactory().nuevo(position) 		
			game.addVisual(humana)	
			generados.add(humana)
			
		}
	}
	
	method quitar(auto) {
		generados.remove(auto)
		game.removeVisual(auto)
	}
	
}

class Charco {
	method image() {
		return "charco.png"
	}
}
