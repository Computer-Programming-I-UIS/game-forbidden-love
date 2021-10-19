class Player extends Actor {
  float dragX = 0.01;
  float velLimit = 10;
  float inputDelta = 0.5;

  float reloadDelay = 200;
  int lastMilreLoad;

  float projectileSpread = 0.02;

  int animationSpeed = 250;

  int lastMilAni;
  int frameC;
  ArrayList<PImage> images;

  ArrayList<Projectile> projectiles;

  int tintDuration = 50;
  int lastMilTint;

  int state;

  final int NORM = 0;
  final int DEAD = 1;

  Player(int size_, String fileName_) {
    super(fileName_+"0000.png");
    lastMilAni = millis();
    frameC = 0;

    lastMilreLoad = millis();

    projectiles = new ArrayList<Projectile>();

    images = new ArrayList<PImage>();
    for (int c = 0; c < size_; c++)
      images.add(loadImage(fileName_+nf(c,4)+".png"));
    img = images.get(0);

    maxHealth = 100;
    health = maxHealth;

    cWidth = img.width;
    cHeight = img.height/2;
  }

  Player(float x_, float y_, int size_, String fileName_) {
    super(x_, y_,fileName_+"0000.png");
    lastMilAni = millis();
    frameC = 0;

    projectiles = new ArrayList<Projectile>();

    images = new ArrayList<PImage>();
    for (int c = 0; c < size_; c++)
      images.add(loadImage(fileName_+nf(c,4)+".png"));
    img = images.get(0);

    health = 100;

    cWidth = img.width;
    cHeight = img.height/2;
  }

  @Override
  void update() {
    if (state == NORM && health <= 0) {
      state = DEAD;
    } else if (state == DEAD && loc.y < camera.loc.y+height/2) {
      movementControl(new PVector());
    } else if (state == NORM){
      inputCalculations();

      checkWalls();

      animationController();

      prjectileController();
    }

    drawImage();
  }

  void prjectileController() {

    if (zHold && millis() - lastMilreLoad > reloadDelay) {
      PVector v = new PVector(30,0);
      v.rotate(random(-PI*projectileSpread,PI*projectileSpread));
      projectiles.add(new Projectile(loc.x,loc.y,v.x,v.y,1,randomTexturedProjectile()));
      lastMilreLoad = millis();
      scores.shot++;
    }

    for (int c = 0; c < projectiles.size(); c++) {
      Projectile p = projectiles.get(c);
      if (p.dead) {
        projectiles.remove(p);
        continue;
      }
      if (boss != null && boss.state != boss.DEAD && p.hit(boss)) {
        if (p.hitBossPart == p.BODY) {
          boss.decreaseHealth(p.power*1);
          boss.lastMilTint = millis();

          Particle particle = new Particle(p.loc.x, p.loc.y, Particle.TEXT, 0, "-"+p.power);
          particle.floatUp = true;
          particles.add(particle);

          projectiles.remove(p);
          scores.shotHit++;
          continue;

        } else if (p.hitBossPart == p.ARM) {
          boss.decreaseHealth(p.power*.25);
          boss.lastMilTint = millis();

          Particle particle = new Particle(p.loc.x, p.loc.y, Particle.TEXT, 0, "-"+p.power*.25);
          particle.floatUp = true;
          particles.add(particle);

          projectiles.remove(p);
          scores.shotHit++;
          continue;

        } else if (p.hitBossPart == p.CRYSTAL) {
          boss.decreaseHealth(p.power*5);
          boss.lastMilTint = millis();

          Particle particle = new Particle(p.loc.x, p.loc.y, Particle.TEXT, 0, "-"+p.power*5);
          particle.floatUp = true;
          particles.add(particle);

          projectiles.remove(p);
          scores.shotHit++;
          continue;

        } else if (!p.bounced){
          float xDif = max(p.loc.x,boss.loc.x)-min(p.loc.x,boss.loc.x);
          float yDif = max(p.loc.y,boss.loc.y)-min(p.loc.y,boss.loc.y);

          float angle = atan2(yDif,xDif);

          float angleDifference = angle - p.vel.heading();
          angleDifference = p.loc.y < boss.loc.y ? -angleDifference : angleDifference;


         float newAngle = PI-p.vel.heading()-angleDifference*2;

         PVector temp = new PVector(p.vel.mag(),0);

         temp.rotate(newAngle);

         p.vel = temp;
         p.bounced = true;

        }
      }

      for (int i = 0; i < enemies.size(); i++) {
        Enemy e = enemies.get(i);
        if (p.hit(e)) {
          if (e.state == e.NORM) {
            e.decreaseHealth(p.power);
            e.lastMilTint = millis();

            Particle particle = new Particle(p.loc.x, p.loc.y, Particle.TEXT, 0, "-"+p.power);
            particle.floatUp = true;
            particles.add(particle);

            scores.shotHit++;
          }

          projectiles.remove(p);
          continue;
        }
      }

      p.update();
    }
  }

  String randomTexturedProjectile() {
    int rand = (int)random(0,8);
    return "Sprites/Projectiles/Projectile000"+rand+".png";
  }

  void inputCalculations() {
    PVector input = new PVector();
    if (rightHold)
      input.x += 1;
    if (leftHold)
      input.x -= 1;
    if (downHold)
      input.y += 1;
    if (upHold)
      input.y -= 1;
    input.normalize();
    movementControl(input);
  }

  void movementControl(PVector input_) {
      input_.mult(inputDelta);

      input_.add(new PVector(0, gravity));

      acc = input_;

      if (shiftHold)
        vel.limit(velLimit/2);
      else
        vel.limit(velLimit);

      vel.sub(new PVector(vel.x*dragX*deltaTime, 0));

      simplePhysicsCal();
  }

  void animationController() {

    float angleStep = velLimit*.1;
    float angleChangePoint1 = 2.5;
    float angleChangePoint2 = 7;

    if (rightHold) {

      if (vel.y > angleStep*angleChangePoint1) {

        if(vel.y > angleStep*angleChangePoint2)

          animate(10,11,animationSpeed,true);
        else
          animate(12,13,animationSpeed,true);


      } else if (vel.y < -angleStep*angleChangePoint1) {

        if(vel.y < -angleStep*angleChangePoint2)

          animate(18,19,animationSpeed,true);
        else
          animate(16,17,animationSpeed,true);


      } else {

        animate(14,15,animationSpeed,true);
      }


    } else {

      if (vel.y > angleStep*angleChangePoint1) {
        if(vel.y > angleStep*angleChangePoint2)
          animate(0,1,animationSpeed,true);
        else
          animate(2,3,animationSpeed,true);


      } else if (vel.y < -angleStep*angleChangePoint1) {
        if(vel.y < -angleStep*angleChangePoint2)
          animate(8,9,animationSpeed,true);
        else
          animate(6,7,animationSpeed,true);


      } else {
        animate(4,5,animationSpeed,true);
      }
    }
  }

  void animate(int min, int max, int aniSpeed, boolean loop) {
    if (millis() - lastMilAni > aniSpeed) {
      frameC++;
      lastMilAni = millis();
    }

    if (frameC < min)
      frameC = min;
    else if (loop && frameC > max)
      frameC = min;
    else if (!loop && frameC > max)
      frameC = max;

    img = images.get(frameC);
  }

  @Override
  void drawImage() {
    pushMatrix();
    translate(loc.x,loc.y);

    if (state == DEAD)
      tint(100);
    else if (millis() - lastMilTint < tintDuration)
    tint(255, 0, 0);

    if (imgFlip)
      scale(-1,1);

    if(img != null)
      image(img, 0, 0);

    noTint();

    popMatrix();
  }

  @Override
  void checkWalls() {

    float camWidthMin  = -camera.loc.x;
    float camWidthMax  = -camera.loc.x+width;
    float camHeightMin = camera.loc.y-height;
    float camHeightMax = camera.loc.y;

    rightWall = loc.x+cWidth/2 > camWidthMax;
    leftWall  = loc.x-cWidth/2 < camWidthMin;
    topWall   = loc.y-cHeight/2 < camHeightMin+ground.height;
    bottomWall= loc.y+cHeight/2 > camHeightMax-ground.height;

    if (leftWall) {
      loc.x = camWidthMin+cWidth/2;
      vel.x = 0;
    }
    if (topWall) {
      vel.y *= -0.5;
      loc.y = camHeightMin + ground.height + cHeight/2;
    }
    if (bottomWall) {
      vel.y *= -0.5;
      loc.y = camHeightMax - ground.height - cHeight/2;
    }
  }



}
