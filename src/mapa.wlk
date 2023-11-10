import wollok.game.*
import carpincho.*
import extras.*
import enemigos.*

object _ {
	
	method generar(position) {
		//El vacio no agrega nada
	}	
}

object a {
	method generar(position) {
		carpincho.position(position)
		//game.addVisual(pepita)
		//No agrega el visual para hacerlo al final
	}		
}

object h {
	method generar(position) {
		humanosManager.iniciarGeneracionYMovimiento()
	}	
}
object p{
	method generar(position) {
		perrosManager.iniciarGeneracionYMovimiento()
	}		
}

object v{
	method generar(position) {
		vida.position(position)
		game.addVisual(vida)
	}		
}

object s{
	method generar(position) {
		salida.position(position)
		game.addVisual(salida)
	}		
}

object mapa {
	
	
	var celdas = [
		[v,_,_,_,_,_,_,s,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[h,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[p,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,a,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]	
	].reverse() //reverse porque el y crece en el orden inverso
	
	
	
	method generar() {
		game.width(celdas.anyOne().size())
		game.height(celdas.size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
		game.addVisual(carpincho) //agrego al final por un tema del z index
	}
	
	method generarCelda(x,y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
}