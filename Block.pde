class Block {
  int x, y, width, height, lastMovement, pastCount, pastViews;
  ArrayList<PImage> pastImages;
  PImage old;
  boolean different, showPast;

  Block(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    pastImages = new ArrayList<PImage>();
    old = createImage(width, height, RGB);
    different = showPast = false;
    lastMovement = pastCount = pastViews = 0;
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
    //    if(different) {
    //      showPastImage();  
    //    }
    lastMovement++;

    if (different && lastMovement > 300) {
      pastImages.add(img.get(this.x, this.y, this.width, this.height));
      lastMovement = 0;
    }
  }

  void showPastImage() {
    if (pastImages.size() > 0 && showPast) {
      PImage pastImage = pastImages.get(pastCount);
      image(pastImage, this.x, this.y);
      pastViews++;

      if (pastViews > 30) {
        pastViews = 0;
        pastCount++;
        showPast = false;
        if (pastCount >= pastImages.size()) pastCount = 0;
      }
    }
  }
  
  void reset() {
    different = showPast = false;
    lastMovement = pastCount = pastViews = 0;
    pastImages.clear();
  }
}

