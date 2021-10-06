class Cam2D extends GameObject{
  
  /**
  *Crea una camara donde 0,0 es el centro de la pantalla
  * Tambien hace mas suave el paneo de camara
  */
  
  Cam2D() { 
    super(width/2, height/2);
    
    des=loc.copy();
    smoothFactor = .025; //Suavidad de camara
  }
  
    /**
  *Crea un camara donde 0,0 esta en x,y
  * Repetimos la suavidad del paneo de camara
  */
  
  Cam2D(float x_, float y_) {
    super(x_, y_);

    des = loc.copy();
    smoothFactor = .1;
  }
  
    /**
  *"Overrides" resetea el momento donde gameObject esta en blanco
  * y deberia correr cada tick (frame) del juego
  */
  
    @Override
  void update() {
    smoothMove();

    if (vel.x > 0)
      vel.x = 0;

    simplePhysicsCal();
    translate(loc.x, loc.y);
  }
}
  
