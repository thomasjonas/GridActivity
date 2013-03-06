class Block {
  int x, y, width, height;
  ArrayList<PImage> pastImages;
  Block(int x, int y, int width, int height) {
    this.x = x;
    this.y = x;
    this.width = width;
    this.height = height;
    pastImages = new ArrayList<PImage>();
  }
}

