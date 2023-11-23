import wollok.game.*

class Sonido{
	
	const property sonido
	
	method reproducir(){
		sonidoGameplay.parar()
		sonido.play()
	}
	
	method parar(){
		sonido.stop()
	}
}

object sonidoGameplay inherits Sonido(sonido = game.sound("gameplay.mp3")){
	
	override method reproducir(){
		sonido.play()
		sonido.shouldLoop(true)
	}
}

object sonidoGameplay2 inherits Sonido(sonido = game.sound("gameplay2.mp3")){
	
	override method reproducir(){
		sonido.play()
		sonido.shouldLoop(true)
	}
}

object sonidoGameover inherits Sonido(sonido = game.sound("gameover.mp3")){}

object sonidoWinner inherits Sonido(sonido = game.sound("winner.mp3")){}

object sonidoSuperpoder inherits Sonido(sonido = game.sound("superpoder.mp3")){}

