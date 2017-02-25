PImage photo;
int cutoff = 5;
int current = 0;
int factor = 8;
int gap = 1;

void setup() {
  fullScreen();
  photo = loadImage("CheHigh.jpg");
  photo.loadPixels();
  background(255);
  if(photo.width >= photo.height)
    photo.resize(width/factor,0);
  else
    photo.resize(0,height/factor);
  frameRate(1000);
}

void draw() {
  float mean = 0;
  int i = 0;
  int last = current;
  
  //FPS
  fill(0);
  noStroke();
  rect(0,0,30,20);
  fill(255);
  textSize(15);
  text((int)frameRate, 0,15);
  
  if(current < photo.width*photo.height-1) {
    //calculating mean pixel brightness
    do{
      mean = (mean*i + brightness(photo.pixels[current]))/(i+1.0);
      i++;
      current++;
    }
    while(current%photo.width != 0 && abs(mean-brightness(photo.pixels[current])) < cutoff);
    
    //drawing line
    stroke(0);
    strokeWeight((factor-gap) - (int)(mean/255.0*(factor-gap)));
    
    int x1 = last%photo.width * factor;
    int x2 = (current-1)%photo.width * factor;
    int y1 = (current-1)/photo.width * factor;
    line(x1,y1,x2,y1);     
  }
  
  else {
    println("finished");
    save("save.jpg");
    noLoop();
  }
}

void keyPressed() {
  save("save.jpg");
}