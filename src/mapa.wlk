import wollok.game.*
import carpincho.*
import extras.*
import enemigos.*
import direcciones.*

object _ {
	
	method generar(position) {
	}	
}

object da {
	method generar(position) {
		game.addVisual(new Pasto(position=position))
		carpincho.position(position)
	}		
}

object h {
	method generar(position) {
		humanosManager.iniciarGeneracionYMovimiento(3, position, derecha)
	}	
}
object p{
	method generar(position) {
		game.addVisual(new Vereda(position=position))
		perrosManager.iniciarGeneracionYMovimiento(2, position, derecha)
	}		
}

object v{
	method generar(position) {
		game.addVisual(new Tierra(position=position))
		vida.position(position)
		
	}		
}

object s{
	method generar(position) {
		salida.position(position)
		game.addVisual(salida)
	}		
}


object d{
	method generar(position) {
		game.addVisual(new Pasto(position=position))
	}		
}

object f{
	method generar(position) {
		game.addVisual(new Asfalto(position=position))
	}		
}

object fg{
	
	method generar(position) {
		game.addVisual(new Asfalto(position=position))
		autosManager.iniciarGeneracionYMovimiento(4, position, izquierda)
	}		
}

object r{
	method generar(position) {
		game.addVisual(new Rio(position=position, energiaQueSaca=100 ))
	}		
}

object l{
	method generar(position) {
		game.addVisual(new RioBotella(position=position, energiaQueSaca=100))
	}		
}

object ln{
	method generar(position) {
		game.addVisual(new RioBotella(position=position))
		troncosManager.iniciarGeneracionYMovimiento(3, position, izquierda)
	}		
}

object rn{
	method generar(position) {
		game.addVisual(new Rio(position=position))
		troncosManager.iniciarGeneracionYMovimiento(3, position, derecha)
	}		
}

object k{
	method generar(position) {
		game.addVisual(new Vereda(position=position))
	}
}

object n{
	method generar(position) {
		game.addVisual(new Tierra(position=position))
	}
}

object m{
	method generar(position) {
		game.addVisual(new Tierra(position=position))
		game.addVisual(new Rocas(position=position))
	}
}

object gn{
	method generar(position) {
		game.addVisual(new Tierra(position=position))
		gansosManager.iniciarGeneracionYMovimiento(3, position, izquierda)
	}
}


object mapa {
	
	
	var celdas = [
		[v,n,n,m,m,m,m,s,m,m,m,m,m,m,m],
		[n,n,n,n,n,n,n,n,n,n,n,n,n,n,gn],
		[l,r,r,r,l,r,l,r,l,r,r,r,l,r,ln],
		[rn,r,l,r,r,r,l,l,r,l,r,l,r,r,r],
		[h,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[d,d,d,d,d,d,d,d,d,d,d,d,d,d,d],
		[p,k,k,k,k,k,k,k,k,k,k,k,k,k,k],
		[f,f,f,f,f,f,f,f,f,f,f,f,f,f,fg],
		[f,f,f,f,f,f,f,f,f,f,f,f,f,f,f],
		[k,k,k,k,k,k,k,k,k,k,k,k,k,k,k],
		[d,d,d,d,d,d,d,d,da,d,d,d,d,d,d]	
	].reverse() //reverse porque el y crece en el orden inverso
	
	
	
	method generar() {
		game.width(celdas.anyOne().size())
		game.height(celdas.size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
		game.addVisual(vida)
		game.addVisual(carpincho) 
	}
	
	method generarCelda(x,y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
}