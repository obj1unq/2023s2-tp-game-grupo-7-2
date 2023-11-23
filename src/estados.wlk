import direcciones.*
import carpincho.*

object activado {

	var property perfil = derecha

	method imagen() {
		return "super" + "-" + carpincho + "-" + self.perfil() + ".png"
	}

	method estaActivo() {
		return true
	}

}

object desactivado {

	var property perfil = derecha

	method imagen() {
		return "" + carpincho + "-" + self.perfil() + ".png"
	}

	method estaActivo() {
		return false
	}

}
