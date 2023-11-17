import wollok.game.*

class Sonido{
	
	const property sonido
	
	method reproducir(){
		game.schedule(500, {sonido.play()})
	}
	
	method parar(){
		sonido.stop()
	}
}

object sonidoGameplay inherits Sonido(sonido = game.sound("gameplay.mp3")){

	override method reproducir(){
		super()
		sonido.shouldLoop(true)
	}
}

object sonidoGameover inherits Sonido(sonido = game.sound("gameover.mp3")){
	
	override method reproducir(){
		super()
		sonidoGameplay.parar()
	}
}
