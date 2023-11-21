import wollok.game.*

class Sonido{
	
	const property sonido
	
	method reproducir(){
		game.schedule(3000, {sonido.play()})
		sonido.shouldLoop(true)
	}
	
	method parar(){
		sonido.stop()
	}
}

object sonidoGameplay inherits Sonido(sonido = game.sound("gameplay.mp3")){

}

object sonidoGameover inherits Sonido(sonido = game.sound("gameover.mp3")){
	
	override method reproducir(){
		super()
		sonidoGameplay.parar()
		
	}
}

object sonidoWinner inherits Sonido(sonido = game.sound("winner.mp3")){
	
	override method reproducir(){
		super()
		sonidoGameplay.parar()
	}
}