class Cam2D extends GameObject {
  Cam2D() {
    super(width/2, height/2);

    des = loc.copy();
    smoothFactor = .025;
  }
  Cam2D(float x_, float y_) {
    super(x_, y_);

    des = loc.copy();
    smoothFactor = .1;
  }
  @Override
  void update() {
    smoothMove();

    if (vel.x > 0)
      vel.x = 0;

    simplePhysicsCal();
    translate(loc.x, loc.y);
  }

}
