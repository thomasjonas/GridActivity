import processing.video.*;
Capture myCapture;
int[] pixelArray;
PImage img = new PImage(640, 480);
ArrayList<Block> blocks;
int blockSize = 75;

void setup() {
  size(640, 480);
  myCapture = new Capture(this, width, height, "iGlasses", 30);
  blocks = new ArrayList<Block>();
  for (int i=0; i<width/blockSize; i++) {
    for (int j=0; j<height/blockSize; j++) {
      Block b = new Block(i*blockSize, j*blockSize, blockSize, blockSize);
      blocks.add(b);
    }
  }
}

void captureEvent(Capture myCapture) {
  myCapture.read();
  img.set(0, 0, myCapture.get());
}

void draw() {
  background(0);
  int counter = 0;
  image(img, 0, 0);
  fill(0, 255, 0, 100);        
  noStroke();
  for (int i=0; i<blocks.size(); i++) {
    Block b = blocks.get(i);
    b.updateImage(img);
    if(b.different) {
      rect(b.x, b.y, b.width, b.height);  
    }
  }



  fill(255);
  text(frameRate, 0, 15);
}

void keyPressed() {
  if (key == ' ') {
  }
}

