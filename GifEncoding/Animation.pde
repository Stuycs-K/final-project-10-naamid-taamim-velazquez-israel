//Code Borrowed from James Paterson because I can't seem to import this from processing so I must copy paste it manually... Also edited it to suite my needs
public class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  public Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = nf(5,i) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
