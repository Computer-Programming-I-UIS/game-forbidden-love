class Projectiles{
  PVector loc; //"loc"ation o vector localizacion
  PVector vel; //"vel"ocity o vector velocidad
  PVector acc; //"acc"eleration o vector aceleracion
  
  boolean dead;
  PImage img; //"img"age
  
  boolean bounced;
  
  final int arm = 0;
  final int body = 1;
  final int eye = 2;
  final int closeArms= 3;
  
  int power;
  
  Projectiles(){
    loc = new PVector();
    vel = new PVector();
    acc = new PVector();
  }
  
  //Creamos un nuevo proyectil a continuacion.
  
  Projectiles(float x_, float y_, int power_){
    loc = new PVector();
    vel = new PVector();
    acc = new PVector();
    power = power_;
  }
  
  Projectiles(float x_, float y_, int xVel_, float yVel, int power_, String fileName_){
    //Ahora le damos valores dinamicos al proyectil.
    loc = new PVector();
    vel = new PVector();
    acc = new PVector();
    power = power_;
  }
