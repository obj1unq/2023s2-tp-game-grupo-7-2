import wollok.game.*
import randomizer.*

object charco {
	method position() = game.at(5, 5)
	method image() = "charco.png"
	
}

object tronco {
	
}

class Cerca {
	var property position
	
	method image()
	
}

class CercaHorizontal inherits Cerca{
	method position(){
		//position = 
	}
	
	override method image() = "cerca-horizontal.png"
	
}

class CercaVertical inherits Cerca{
	method position(){
		//position = 
	}
	
	override method image() = "cerca-vertical.png"
	
}


