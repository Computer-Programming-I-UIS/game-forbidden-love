class Control_Camara extends Objetos_Juego {
  Control_Camara() {
    super(width/2, height/2);

    des = loc.copy();
    valorSuavizado = .025;
  }
