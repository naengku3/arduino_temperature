import processing.serial.*;

Serial p;
void setup() {
  p = new Serial(this, "COM11", 9600);
  size(400, 400);
}

void draw() {
  if(p.available()>0) {
  String m = p.readStringUntil('\n');
  if(m != null) {
    print(m);
    if( float(m) >28) background(255,0,0);
    else background(0,255,0);
    textSize(128);
    text(m, 20, 250);
    }
  }
  
}
