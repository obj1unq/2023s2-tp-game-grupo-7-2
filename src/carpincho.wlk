import wollok.game.*
import direcciones.*
import sonidos.*
import extras.*
import tablero.*
import estados.*

object carpincho {

	var property position = game.at(0, 0)
	var energia = 1000
	const elementosParaSuperPoder = #{}
	var poder = desactivado
	
	
	method reiniciar() {
		energia = 1000
		elementosParaSuperPoder.clear()
		poder = desactivado
	}

	method image() {
		return poder.imagen()
	}

	method poder() {
		return poder
	}
	
	method energia() {
		return energia
	}

	method energiaParaMover() {
		return 10
	}

	method vidaVisual() {
		return if (energia > 750) 1000 else if (energia > 500) 750 else if (energia > 250) 500 else if (energia > 100) 250 else if (energia > 0) 100 else 0
	}

	method tieneEnergiaParaMover() {
		return energia > self.energiaParaMover()
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return tablero.puedeOcupar(proxima) and self.tieneEnergiaParaMover()
	}

	method mover(direccion) {
		if (not self.sePuedeMover(direccion)) {
			game.say(self, "No puedo ir ahí")
		} else {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
			poder.perfil(direccion)
		
		}
	}

	method enfrentarseAVisual(personaje) {
		energia -= personaje.energiaQueSaca()
		if (not self.tieneEnergiaParaMover()) {
			game.schedule(1000, {
				tablero.perdedor()
			})
		}
	}

	method activarSuperPoder() {
		self.validarActivarSuperPoder()
		poder = activado
		//sonidoGameplay.parar()
		sonidoSuperpoder.reproducir()
		game.schedule(5000, { poder = desactivado
			sonidoGameplay.reproducir()
		})
		elementosParaSuperPoder.removeAll(elementosParaSuperPoder)

	}

	method validarActivarSuperPoder() {
		if (not self.tieneElementosNecesariosParaSuperPoder()) {
			game.say(carpincho, "Todavia no puedo activar el poder!")
		} else {
			poder = activado
			game.schedule(5000, { poder = desactivado
			})
			elementosParaSuperPoder.removeAll(elementosParaSuperPoder)
		}
		
	}


	method tieneElementosNecesariosParaSuperPoder() {
		return elementosParaSuperPoder.size() == 3
	}

	method agarrarElemento(elemento) {
		if (elementosParaSuperPoder.contains(elemento)) {
			game.say(carpincho, "Ya tengo este elemento!")
		} else {
			elementosParaSuperPoder.add(elemento)
		}
		
	}


}
