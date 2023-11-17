import carpincho.*
import extras.*
import wollok.game.*
import obstaculos.*
import enemigos.*


object _ {
	
	method generar(position) {
		//El vacio no agrega nada
	}	
}


object c {
	method generar(position) {
		game.addVisual(carpincho)
		carpincho.position(position)
		//game.addVisual(carpincho)
		//No agrega el visual para hacerlo al final
	}		
}


object m {
	method generar(position) {
		game.addVisual(new Muro(position=position))
	}			
}


object p {
	
	method generar(position){
	game.addVisual(new Salida(position=position))	
		
	}
	
}


object b{
	method generar(position) {
		game.addVisual(new Negro(position=position))
	}	
	
}


object mapa {
	
	var celdas = [
		[b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b],
		[m,m,m,m,m,m,m,m,p,m,m,m,m,m,m,m,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],			
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],		
		[m,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m],
		[m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m]		
	].reverse() //reverse porque el y crece en el orden inverso
	
	
	
	method generar() {
		game.width(celdas.anyOne().size())
		game.height(celdas.size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
		//agrego al final por un tema del z index
	}
	
	method generarCelda(x,y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
}