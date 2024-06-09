void diffCalled(PImage img1, PImage img2) {
  img1.loadPixels();
  img2.loadPixels();
  PImage img3 = createImage(img1.width, img1.height, RGB);
  img3.loadPixels();
  for (int i=0; i<img1.pixels.length; i++) {
    if (img1.pixels[i]==img2.pixels[i]) {
      img3.pixels[i] = color(255,255,255);
    }
    else {
      img3.pixels[i] = color(0, 0, 0);
    }
  }
  image(img3, 0, 0);
}

void diffCalledRed(PImage img1, PImage img2) {
  img1.loadPixels();
  img2.loadPixels();
  PImage img3 = createImage(img1.width, img1.height, RGB);
  img3.loadPixels();
  for (int i=0; i<img1.pixels.length; i++) {
    if (red(img1.pixels[i])==red(img2.pixels[i])) {
      img3.pixels[i] = color(255,255,255);
    }
    else {
      img3.pixels[i] = color(0, 0, 0);
    }
  }
  image(img3, 0, 0);
}

void diffCalledGreen(PImage img1, PImage img2) {
  img1.loadPixels();
  img2.loadPixels();
  PImage img3 = createImage(img1.width, img1.height, RGB);
  img3.loadPixels();
  for (int i=0; i<img1.pixels.length; i++) {
    if (green(img1.pixels[i])==green(img2.pixels[i])) {
      img3.pixels[i] = color(255,255,255);
    }
    else {
      img3.pixels[i] = color(0, 0, 0);
    }
  }
  image(img3, 0, 0);
}

void diffCalledBlue(PImage img1, PImage img2) {
  img1.loadPixels();
  img2.loadPixels();
  PImage img3 = createImage(img1.width, img1.height, RGB);
  img3.loadPixels();
  for (int i=0; i<img1.pixels.length; i++) {
    if (blue(img1.pixels[i])==blue(img2.pixels[i])) {
      img3.pixels[i] = color(255,255,255);
    }
    else {
      img3.pixels[i] = color(0, 0, 0);
    }
  }
  image(img3, 0, 0);
}
