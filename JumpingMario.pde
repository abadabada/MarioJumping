SideJumper mario;
float left;
float right;
float up;
float down;

import processing.sound.*;

float gravity = 0.3;

float ground = 600;

PImage groundImg;




SoundFile file;
String audioName = "Mario_Theme_Song.mp3";
String path;

void setup(){
  size(1200,800);
  
  //ground
  //fill(#A7782A);
  //stroke(#939393);
  //rect(0,652,width,200);
  
  
  
  mario = new SideJumper();
  mario.image = loadImage("Mario_Standing_Left_Side.png");
  mario.position = new PVector(400,ground);
  mario.direction = 1;
  mario.velocity = new PVector(0,0);
  mario.jumpSpeed = 10;
  mario.walkSpeed = 5;
  
  PlayMusic();
  
}

void draw(){
  background(#A8B4F5);
    //ground
  fill(#A7782A);
  stroke(#939393);
  rect(0,652,width,200);
  updateMario();
}

void updateMario(){
  //only apply gravity if above ground.
  if(mario.position.y < ground){
    mario.velocity.y += gravity;
  }
  else {
    mario.velocity.y = 0;
  }
  // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!\
  if (mario.position.y >= ground && up != 0){
    mario.velocity.y = -mario.jumpSpeed;
  }
  //Walk left and right.
  mario.velocity.x = mario.walkSpeed * (left + right);
  // Check the nextPosition before actually setting the position so we cant move mario if he's colliding.
  PVector nextPosition = new PVector(mario.position.x, mario.position.y);
  nextPosition.add(mario.velocity);
  // Check collision with edge of screen and don't move if at the edge
  float offset = 0;
  if(nextPosition.x > offset && nextPosition.x <(width - offset)){
    mario.position.x = nextPosition.x;
  }
  if (nextPosition.y > offset && nextPosition.y <(height - offset)){
    mario.position.y = nextPosition.y;
  }
  pushMatrix();
  translate(mario.position.x, mario.position.y);
  scale(mario.direction,1);
  
  imageMode(CENTER);
  image(mario.image,0,0);
  
  popMatrix();
}

void keyPressed()
{
  if (key == 'd')
  {
    right = 1;
    mario.direction = -1;
  }
  if (key == 'a')
  {
    left = -1;
    mario.direction = 1;
  }
  if (key == ' ')
  {
    up = -1;
  }
  if (key == 's')
  {
    down = 1;
  }
}

void keyReleased()
{
  if (key == 'd')
  {
    right = 0;
  }
  if (key == 'a')
  {
    left = 0;
  }
  if (key == ' ')
  {
    up = 0;
  }
  if (key == 's')
  {
    down = 0;
  }
}

void PlayMusic(){
  path = sketchPath(audioName);
  file = new SoundFile(this,path);
  file.play();
}

void MakeCoin(){
  
}
