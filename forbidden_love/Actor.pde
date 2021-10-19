class Actor extends GameObject {

  PImage img;

  int cWidth, cHeight;

  float health, maxHealth;

  boolean topWall, bottomWall, rightWall, leftWall;

  boolean imgFlip;
  Actor() {
    super();
  }
  Actor(float x_, float y_) {
    super(x_, y_);
  }
  Actor(float x_, float y_, String fileName_) {
    super(x_, y_);
    img = loadImage(fileName_);
  }

  Actor(String fileName_) {
    super();
    img = loadImage(fileName_);
  }
  @Override
  void update() {
    simplePhysicsCal();
  }
  void drawImage() {
    pushMatrix();
    translate(loc.x,loc.y);

    ellipse(0,0,10,10);

    popMatrix();
  }
  void offScreenS(float screenExtention) {
    if (loc.x < 0 - img.width/2       -screenExtention)
      loc.x = width + img.width/2     +screenExtention;
    if (loc.x > width + img.width/2   +screenExtention)
      loc.x = 0 - img.width/2         -screenExtention;
    if (loc.y < 0 - img.height/2      -screenExtention)
      loc.y = height + img.height/2   +screenExtention;
    if (loc.y > height + img.height/2 +screenExtention)
      loc.y = 0 - img.height/2        -screenExtention;

  }
  void offScreenB() {

    if ((loc.x < 0 + img.width/2 && vel.x < 0) || (loc.x > width - img.width/2 && vel.x >= 0))
      vel.x *= -1;

    if ((loc.y < 0 + img.height/2 && vel.y < 0) || (loc.y > height - img.height/2 && vel.y >= 0))
      vel.y *= -1;

  }

  boolean hitCharacter(Actor actor) {
    float aWidthMin  = loc.x-cWidth/2;
    float aWidthMax  = loc.x+cWidth/2;
    float aHeightMin = loc.y-cHeight/2;
    float aHeightMax = loc.y+cHeight/2;

    float bWidthMin  = actor.loc.x-actor.cWidth/2;
    float bWidthMax  = actor.loc.x+actor.cWidth/2;
    float bHeightMin = actor.loc.y-actor.cHeight/2;
    float bHeightMax = actor.loc.y+actor.cHeight/2;

    if (aWidthMax > bWidthMin && bWidthMax > aWidthMin &&
        aHeightMax > bHeightMin && bHeightMax > aHeightMin)
        return true;
    return false;
  }

  void decreaseHealth(float delta) {
    health -= delta;
  }

  void increaseHealth(float delta) {
    health += delta;
    if (health > maxHealth)
      health = maxHealth;
  }

  void checkWalls() {


    float camWidthMin  = -camera.loc.x;
    float camWidthMax  = -camera.loc.x+width;
    float camHeightMin = camera.loc.y-height;
    float camHeightMax = camera.loc.y;

    rightWall = loc.x-cWidth/2 > camWidthMax;
    leftWall  = loc.x+cWidth/2 < camWidthMin;
    topWall   = loc.y+cHeight/2 < camHeightMin;
    bottomWall= loc.y-cHeight/2 > camHeightMax;
  }

}
