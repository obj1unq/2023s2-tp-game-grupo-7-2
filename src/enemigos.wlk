import wollok.game.*

object perro {
	var property position = game.at(3, 7)
	const energiaQueSaca = 50
	
	method image() {
		return "perro.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)
		game.removeVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method posicionAleatoria(){
		const x = 0.randomUpTo(game.width())
		const y = 0.randomUpTo(game.height())
		
		position = game.at(x, y)
	}
	
}

object humano {
	var property position = game.at(5, 4)
	const energiaQueSaca = 4000
	
	method image() {
		return "humana.png"
	}
	
	method colision(personaje) {
		personaje.enfrentarseAVisual(self)	
	}
	
	method energiaQueSaca() {
		return energiaQueSaca
	}
	
	method posicionAleatoria(){
		const x = 0.randomUpTo(game.width())
		const y = 0.randomUpTo(game.height())
		
		position = game.at(x, y)
	}
}

object auto {
	
}