import processing.video.*;
Capture myCapture;
int[] pixelArray;
PImage img = new PImage(640, 480);
ArrayList<PImage> images;
int row = 0;
int blockSize = 75;

void setup() {
  size(640, 480);
  myCapture = new Capture(this, width, height, "iGlasses", 30);
  println(myCapture.list());
  images = new ArrayList<PImage>();
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
  
  for (int i=0; i<width/blockSize; i++) {
    for (int j=0; j<height/blockSize; j++) {
      PImage block = createImage(blockSize, blockSize, RGB);
      block.loadPixels();
      for (int k=0; k<block.width; k++) {
        for (int m=0; m<block.height; m++) {
          block.pixels[m*block.width + k] = int(brightness(img.get(i*blockSize + k, j*blockSize + m)));
        }
      }
      block.updatePixels();

      if (images.size() == counter) {
        images.add(block);
      } 
      else {
        PImage old = images.get(counter);
        int diffCounter = 0;
        int numPixels = old.width*old.height;
        int thresholdPixels = int(0.2 * numPixels);
        for (int r=0; r<numPixels; r++) {
          if (abs(old.pixels[r] - block.pixels[r]) > 10) {
            diffCounter++;
            if (diffCounter > thresholdPixels) {
              rect(i*blockSize, j*blockSize, blockSize, blockSize);
              break;
            }
          }
        }
        images.set(counter, block);
      }
      counter++;
    }
  }
  fill(255);
  text(frameRate, 0, 15);
}

void keyPressed() {
  if (key == ' ') {
  }
}

