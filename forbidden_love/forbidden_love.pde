//Definicion varibles de controles
boolean upHold, letfHold, downHold, rightHold, shiftHold, zHold, xHold, cHold = false;
//Definicion para el game over
boolean gameOver;
//Definicion de clases
Cam2D camera; //Posicionamiento de camara
Player player; //Propiedades del jugador
Score score; //Lo mas importante el contador de puntos

void setup(){
  size(1280,720, P2D); //Renderizado de ventana
  imageMode(CENTER);
  rectMode(CENTER);
  background = loadImage("Sprites/Background.png");
  ground = loadImage("Sprites/Ground.png");
  
}
