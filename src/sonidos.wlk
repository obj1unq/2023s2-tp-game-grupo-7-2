import wollok.game.*

class Sonido{
	
	const property sonido
	
	method reproducir(){
		game.schedule(500, {sonido.play()})
		//sonido.shouldLoop(true)
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

object sonidoGameplay2 inherits Sonido(sonido = game.sound("gameplay2.mp3")){
	
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

object sonidoWinner inherits Sonido(sonido = game.sound("winner.mp3")){
	
	override method reproducir(){
		super()
		sonidoGameplay.parar()
	}
}

object sonidoSuperpoder inherits Sonido(sonido = game.sound("superpoder.mp3")){
	
		override method reproducir(){
		super()
		sonidoGameplay.parar()
	}
	
	
}