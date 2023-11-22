import wollok.game.*
import carpincho.*
import extras.*
import enemigos.*
import direcciones.*
import obstaculos.*

object _ {

	method generar(position) {
	}

}

object a {

	method generar(position) {
		game.addVisual(new Pasto(position = position))
		carpincho.position(position)
	}

}

object h {

	method generar(position) {
		game.addVisual(new Piso(position = position))
		humanosManager.iniciarGeneracionYMovimiento(3, position, derecha)
	}

}

object p {

	method generar(position) {
		game.addVisual(new Vereda(position = position))
		perrosManager.iniciarGeneracionYMovimiento(2, position, derecha)
	}

}

object pi {

	method generar(position) {
		game.addVisual(new Vereda(position = position))
		perrosManagerIzquierda.iniciarGeneracionYMovimiento(2, position, izquierda)
	}

}

object v {

	method generar(position) {
		game.addVisual(new Pasto(position = position))
		vida.position(position)
	}

}

object s {

	method generar(position) {
		salida.position(position)
		game.addVisual(new Pasto(position = position))
		game.addVisual(salida)
	}

}

object d {

	method generar(position) {
		game.addVisual(new Pasto(position = position))
	}

}

object dv {

	method generar(position) {
		game.addVisual(new PastoConVida(position = position))
	}

}

object f {

	method generar(position) {
		game.addVisual(new Asfalto(position = position))
	}

}

object fg {

	method generar(position) {
		game.addVisual(new Asfalto(position = position))
		autosManager.iniciarGeneracionYMovimiento(4, position, izquierda)
	}

}

object r {

	method generar(position) {
		game.addVisual(new Rio(position = position, energiaQueSaca = 100))
	}

}

object l {

	method generar(position) {
		game.addVisual(new RioBotella(position = position, energiaQueSaca = 100))
	}

}


object ta {

	method generar(position) {
		game.addVisual(new TroncoConAgua(position = position))
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
		game.addVisual(new Pasto(position=position))
		game.addVisual(new Cerca(position=position))
	}
}

object gn{
	method generar(position) {
		game.addVisual(new Tierra(position=position))
		gansosManager.iniciarGeneracionYMovimiento(3, position, izquierda)
	}
}

object q {
	method generar(position) {
		game.addVisual(new Piso(position=position))
	}
}


object mapa {
	
	
	var celdas = [
		[v,dv,dv,m,m,m,m,s,m,m,m,m,m,m,m],
		[n,n,n,n,n,n,n,n,n,n,n,n,n,n,gn],
		[l,ta,r,r,l,r,l,r,l,r,r,r,l,r,ln],
		[rn,ta,l,r,r,r,l,l,r,l,r,l,r,r,r],
		[h,q,q,q,q,q,q,q,q,q,q,q,q,q,q],
		[d,d,d,d,d,d,d,d,d,d,d,d,d,d,d],
		[p,k,k,k,k,k,k,k,k,k,k,k,k,k,k],
		[f,f,f,f,f,f,f,f,f,f,f,f,f,f,fg],
		[f,f,f,f,f,f,f,f,f,f,f,f,f,f,f],
		[k,k,k,k,k,k,k,k,k,k,k,k,k,k,pi],
		[d,d,d,d,d,d,d,d,a,d,d,d,d,d,d]	
	].reverse() 
	
	
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