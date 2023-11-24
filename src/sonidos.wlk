import wollok.game.*

class Sonido{
	
	var property sonido
	
	method reproducir(){
		sonidoGameplay.parar()
		self.reiniciar()
		sonido = self.nombre()
		sonido.play()
	}
	
	method parar(){
		sonido.stop()
	}
	
	method reiniciar(){
		if(sonido != null){
			sonido = null
		}
	}
	
	method nombre()
}

object sonidoGameplay inherits Sonido(sonido = game.sound("gameplay.mp3")){
	
	override method reproducir(){
		self.reiniciar()
		sonido = self.nombre()
		sonido.play()
		sonido.shouldLoop(true)
	}
	
	override method nombre(){
		return game.sound("gameplay.mp3")
	}
}

object sonidoGameplay2 inherits Sonido(sonido = game.sound("gameplay2.mp3")){
	
	override method reproducir(){
		self.reiniciar()
		sonido.play()
		sonido.shouldLoop(true)
	}
	
	override method nombre(){
		return game.sound("gameplay2.mp3")
	}
}

object sonidoGameover inherits Sonido(sonido = game.sound("gameover.mp3")){
	
	override method nombre(){
		return game.sound("gameover.mp3")
	}
}

object sonidoWinner inherits Sonido(sonido = game.sound("winner.mp3")){
	
	override method nombre(){
		return game.sound("winner.mp3")
	}
}

object sonidoSuperpoder inherits Sonido(sonido = game.sound("superpoder.mp3")){
	
	override method nombre(){
		return game.sound("superpoder.mp3")
	}
}

