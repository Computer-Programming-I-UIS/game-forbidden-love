class GameObject {
  PVector loc; 
  PVector vel; 
  PVector acc; 

  PVector des; 
  float smoothFactor; 

  GameObject() {
    loc = new PVector();
    vel = new PVector();
    acc = new PVector();
    des = new PVector();
  }
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
