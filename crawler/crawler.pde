String url = "https://en.wikipedia.org/wiki/"; //language can be selected via url
int gap = 5;
int radius = 600;
Site start = new Site("Brutalism"); //initial topic
int t = 0;
int delay = 50;
float angle;
int toDraw = 0;
int speed = 100;

void setup() {
    fullScreen();
    smooth(16);
    textSize(12);
    fill(255);
    stroke(255);
    strokeWeight(gap/2);
    frameRate(30);
    
    start.deeper();
    
    println("FINISHED");
}

void drawones(){
    background(20);
    textSize(30);
    textAlign(CENTER,CENTER);
    text(start.toString(), width/2, height/2);
    
    noFill();
    float r = radius*(1+cos(2*PI*t/delay));
    arc(width/2, height/2, r, r, -angle, -angle+1.05*PI*(1+cos(2*PI*t/delay)));
    t++;
    if(t > delay) {
        start.plot();
        t = delay;
    }
}

void draw(){
    background(20);
    textSize(30);
    textAlign(CENTER,CENTER);
    translate(width/2, height/2);
    
    text(start.toString(),0,0);
    
    start.buildup();
    
    noFill();
    float r = 2*radius;//*(1+cos(2*PI*toDraw/start.numChild));
    arc(0,0, r, r, -angle, -angle+1.05*PI*(1+cos(2*PI*toDraw/start.numChild)));
}



void mousePressed(){
    start.select();
}