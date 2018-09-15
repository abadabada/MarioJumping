SideJumper mario;
Coin[] coin;
float left;
float right;
float up;
float down;

int score = 0;

import processing.sound.*;

float gravity = 0.3;

float ground = 600;

PImage groundImg;

PFont font;


SoundFile file;
String audioName = "Mario_Theme_Song.mp3";
String path;

void setup(){
  size(1200,800);
  
  font = loadFont("SuperPlumberBrothers-48.vlw");
  textFont(font);
  
  
  
  mario = new SideJumper();
  mario.image = loadImage("Mario_Standing_Left_Side.png");
  mario.position = new PVector(2 * width/3,ground);
  mario.direction = 1;
  mario.velocity = new PVector(0,0);
  mario.jumpSpeed = 10;
  mario.walkSpeed = 5;
  
  coin = new Coin[4];
  coin[0] = new Coin();
  coin[0].coinImage = loadImage ("mario_coin.png");
  coin[0].coinPosition = new PVector (width/3 , ground - 150);
  coin[0].coinDirection = 1;
  
  coin[1] = new Coin();
  coin[1].coinImage = loadImage ("mario_coin.png");
  coin[1].coinPosition = new PVector (width/3  , ground - 150);
  coin[1].coinDirection = 1;
  
  coin[2] = new Coin();
  coin[2].coinImage = loadImage ("mario_coin.png");
  coin[2].coinPosition = new PVector (width/3  , ground - 150);
  coin[2].coinDirection = 1;
  
  coin[3] = new Coin();
  coin[3].coinImage = loadImage ("mario_coin.png");
  coin[3].coinPosition = new PVector (width/3  , ground - 150);
  coin[3].coinDirection = 1;
  
  
  
  //PlayMusic();
  
}

void draw(){
  
  background(#A8B4F5);
    //ground
  fill(#A7782A);
  stroke(#939393);
  rect(0,652,width,200);
  updateMario();
  MakeCoin();
  ScoreCoins();
  
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
  
  pushMatrix();
  translate(coin[0].coinPosition.x, coin[0].coinPosition.y);
  scale(coin[0].coinDirection,1);
  
  imageMode(CENTER);
  
  
  int k;
  for(int i = 0 ; i < 4 ; i++){
    
    if (i == 0){
      k = i;
    } else if (i == 1){
      k = i + 100;
    } else if ( i == 2){
      k = i + 200;
    } else{
      k = i + 300;
    }
    
    image(coin[0].coinImage,k,0);
    image(coin[1].coinImage,k,0);
    image(coin[2].coinImage,k,0);
    image(coin[3].coinImage,k,0);
      
  }
  
  popMatrix();  
  
}

void ScoreCoins(){
  
  
  
  String result = "COINS: ";
  float marioX = mario.position.x;
  float marioY = mario.position.y - 150;
  
  float coin1X = coin[0].coinPosition.x;
  float coin2X = coin[1].coinPosition.x;
  float coin3X = coin[2].coinPosition.x;
  float coin4X = coin[3].coinPosition.x;
  
  float coin1Y = coin[0].coinPosition.y;
  float coin2Y = coin[1].coinPosition.y;
  float coin3Y = coin[2].coinPosition.y;
  float coin4Y = coin[3].coinPosition.y;
  
  
  if (marioX == coin1X && marioY >= ground && marioY <= coin1Y){ 
      score ++;
      print(result + score);
    } else if (marioX == coin2X + 100){
      score ++;
      print(result + score);
    }else if( marioX == coin3X + 200){
      score ++;
      print(result + score);
    } else if (marioX== coin4X + 300){
      score ++;
      print(result + score);
    }
    textSize(32);
    stroke(#000000);
    fill(#000000);
    text(result + score,20,35);
    

}
