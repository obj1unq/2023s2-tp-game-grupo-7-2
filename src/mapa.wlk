import wollok.game.*
import carpincho.*
import extras.*
import enemigos.*
import direcciones.*
import obstaculos.*
import elementosPoder.*
import sonidos.*
import tablero.*

object _ {

	method generar(position) {
	}

}

object a {

	method generar(position) {
		carpincho.reiniciar()
		game.addVisual(new Pasto(position = position))
		carpincho.position(position)
		
	}

}

object h {

	method generar(position) {
		humanoManager.reiniciar()
		game.addVisual(new Piso(position = position))
		humanoManager.iniciarGeneracionYMovimiento(3, position, derecha)
	}

}

object p {

	method generar(position) {
		perroManager.reiniciar()
		game.addVisual(new Vereda(position = position))
		perroManager.iniciarGeneracionYMovimiento(2, position, derecha)
	}

}

object pi {

	method generar(position) {
		perroManagerIzquierda.reiniciar()
		game.addVisual(new Vereda(position = position))
		perroManagerIzquierda.iniciarGeneracionYMovimiento(2, position, izquierda)
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

object fi {

	method generar(position) {
		autoManager.reiniciar()
		game.addVisual(new Asfalto(position = position))
		autoManager.iniciarGeneracionYMovimiento(4, position, izquierda)
	}

}

object fd {

	method generar(position) {
		autoManagerDerecha.reiniciar()
		game.addVisual(new Asfalto(position = position))
		autoManagerDerecha.iniciarGeneracionYMovimiento(4, position, derecha)
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
		gansoManager.reiniciar()
		game.addVisual(new Tierra(position=position))
		gansoManager.iniciarGeneracionYMovimiento(3, position, izquierda)
	}
}

object q {
	method generar(position) {
		game.addVisual(new Piso(position=position))
	}
}


object mapa {
	const property sonido = sonidoGameplay
	
	var celdas = [
		[v,dv,dv,m,m,m,m,s,m,m,m,m,m,m,m],
		[n,n,n,n,n,n,n,n,n,n,n,n,n,n,gn],
		[l,ta,r,r,l,r,l,r,l,r,r,r,l,r,l],
		[r,ta,l,r,r,r,l,l,r,l,r,l,r,r,r],
		[h,q,q,q,q,q,q,q,q,q,q,q,q,q,q],
		[d,d,d,d,d,d,d,d,d,d,d,d,d,d,d],
		[p,k,k,k,k,k,k,k,k,k,k,k,k,k,k],
		[f,f,f,f,f,f,f,f,f,f,f,f,f,f,fi],
		[fd,f,f,f,f,f,f,f,f,f,f,f,f,f,f],
		[k,k,k,k,k,k,k,k,k,k,k,k,k,k,pi],
		[d,d,d,d,d,d,d,d,a,d,d,d,d,d,d]	
	].reverse() 
	
	
	method generar() {
		elementosMateManager.reiniciar()
		
		tablero.configurar()
		
		game.width(celdas.anyOne().size())
		game.height(celdas.size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
		game.addVisual(vida)
		game.addVisual(carpincho) 
		
		self.comenzar()
	}
	
	method generarCelda(x,y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
	method comenzar() {
		game.schedule(500, {sonido.reproducir()})
		
		
		keyboard.up().onPressDo({carpincho.mover(arriba)})	
		keyboard.down().onPressDo({carpincho.mover(abajo)})
		keyboard.left().onPressDo({carpincho.mover(izquierda)})
		keyboard.right().onPressDo({carpincho.mover(derecha)})
		keyboard.x().onPressDo({carpincho.activarSuperPoder()})
		keyboard.e().onPressDo({game.say(carpincho, "Mi energia es: " + carpincho.energia().toString())})
		
		game.onCollideDo(carpincho, {algo => algo.colision(carpincho)})
		game.whenCollideDo(carpincho, {algo => algo.accionColision(carpincho)})
		
		game.schedule(4000, {elementosMateManager.generar()})
	}

	
}