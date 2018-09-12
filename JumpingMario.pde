SideJumper mario;
float left;
float right;
float up;
float down;

float gravity = .5;

float grount = 700;

void setup(){
  size(800,800);
  
  mario = new SideJumper();
  mario.image = loadImage();

}
