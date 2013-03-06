class Block {
  int x, y, width, height;
  ArrayList<PImage> pastImages;
  PImage old;
  PImage update;
  boolean different;
  Block(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    pastImages = new ArrayList<PImage>();
    old = createImage(width, height, RGB);
    different = false;
  }

  void updateImage(PImage img) {

    int diffCounter = 0;
    int numPixels = this.width*this.height;
    int thresholdPixels = int(0.2 * numPixels);
    different = false;

    old.loadPixels();
    img.loadPixels();
    for (int i=0; i<this.width; i++) {
      for (int j=0; j<this.height; j++) {
        int num = j*this.width+i;
        int oldPixel = old.pixels[num];
        int newPixel = int(brightness(img.get(this.x + i, this.y + j)));
        if (abs(oldPixel - newPixel) > 10) {
          diffCounter++;
          if (diffCounter > thresholdPixels) {
            different = true;
          }
        }
        old.pixels[num] = newPixel;
      }
    }
    old.updatePixels();    
  }
}

