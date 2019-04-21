PGraphics pgOriginal;
PGraphics pgFiltered;
PImage img, g_img;
int pgO_x, pgO_y, pgF_x, pgF_y;

void setup() {
  size(450,450);
  img = loadImage("./data/the_kiss_gustav_klimt.png");
  g_img = loadImage("./data/the_kiss_gustav_klimt.png");
  grayscale(g_img);
  pgO_x = 0;
  pgO_y = 0;
  pgF_x = img.width+10;
  pgF_y = 0;
  
  pgOriginal = createGraphics(img.width, img.height);
  pgFiltered = createGraphics(img.width, img.height);
  
}

void draw() {
  pgOriginal.beginDraw();
  pgOriginal.background(img);
  pgOriginal.stroke(0);
  pgOriginal.endDraw();
  image(pgOriginal, pgO_x, pgO_y);
  histogram(img, pgO_x);
  
  pgFiltered.beginDraw();
  pgFiltered.background(g_img);
  pgFiltered.stroke(75);
  pgFiltered.endDraw();
  image(pgFiltered, pgF_x, pgF_y);
  histogram(g_img, pgF_x);
}

void grayscale(PImage img) {  
  for(int i=0; i<img.width; i++){
    for(int j=0; j<img.height; j++){
      color c = img.get(i,j);
      c = color(Math.round((red(c) + green(c) + blue(c))/3));
      img.set(i,j,c);      
    } //<>//
  }
}

void histogram(PImage img, int x){
  int[] hist = new int[256];
  
  // Calculate the histogram
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int bright = int(brightness(img.get(i, j)));
      hist[bright]++; 
    }
  }
  // Find the largest value in the histogram
  int histMax = max(hist);
  
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < img.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, img.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, img.height, 0));
    line(i+x, img.height*2, i+x, y+img.height);
  }
}
