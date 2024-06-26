//Code Borrowed from James Paterson because I can't seem to import this from processing so I must copy paste it manually... Also edited it to suite my needs
public class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  int[][] nums;
  int[] parts;
  String file;
  
  public Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];
    nums = new int[imageCount][];
    file = imagePrefix;
    int size=0;

    for (int i = 1; i <= imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix.substring(0, imagePrefix.indexOf(".")) +nf(i,5) + imagePrefix.substring(imagePrefix.indexOf("."));
      //String filename = imagePrefix +".png";
      images[i-1] = loadImage(filename);
      nums[i-1] = fileToArray(filename);
      size+=nums[i-1].length;  
    }
    //println(size);
    //println(nums[0].length);
    parts = new int[size];
    int tmp = 0;
    for (int i=0; i<nums.length; i++) {
      for (int j=0; j<nums[i].length; j++) {
        parts[tmp+j] = nums[i][j];
      }
      tmp+=nums[i].length;
    }
  }
  
  public Animation(String imagePrefix) {
    imageCount = 1;
    images = new PImage[1];
    file = imagePrefix;
    images[0] = loadImage(imagePrefix);
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
