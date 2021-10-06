class GameObject {
  PVector loc; // Vector posicion
  PVector vel; // Vector velocidad
  PVector acc; // Vector aceleracion

  PVector des; // Complemento para el suavizado
  float smoothFactor; //Definicion del fator suavizado de 0 a 1 

  /**
   * Crea nuevo objeto de juego
   */
  GameObject() {
    loc = new PVector();
    vel = new PVector();
    acc = new PVector();
    des = new PVector();
  }

  /**
   * Nuevo objeto de juego
   *
   */
  GameObject(float x_, float y_) {
    loc = new PVector(x_,y_);
    vel = new PVector();
    acc = new PVector();
    des = new PVector();
  }

  void update(){}

  void simplePhysicsCal() {
    vel.add(acc.copy().mult(deltaTime));
    loc.add(vel.copy().mult(deltaTime));
  }

  /**
   * Hace que los movimientos sean mas suaves.
   * Pone una nueva variable no se como decir "setear en español"
   */
  void smoothMove() {
    float vX = des.x - loc.x;
    float vY = des.y - loc.y;

    vX *= smoothFactor;
    vY *= smoothFactor;

    vel = new PVector(vX, vY);
  }

  void setsmoothFactor(float smoothFactor_) {
    smoothFactor = smoothFactor_;
  }


}
