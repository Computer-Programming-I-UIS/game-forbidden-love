class Control_Camara extends Objetos_Juego {
  Control_Camara() {
    super(width/2, height/2);

    des = loc.copy();
    valorSuavizado = .025;
  }
  Control_Camara(float x_, float y_) {
    super(x_, y_);

    des = loc.copy();
    valorSuavizado = .1;
  }
   @Override
   void update() {
    suavizadoMovimiento();

    if (vel.x > 0)
      vel.x = 0;

    CalculoFisicas();
    translate(loc.x, loc.y);
  }

}
