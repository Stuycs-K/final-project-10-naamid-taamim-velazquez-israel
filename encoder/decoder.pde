String decodeLinear(PImage img) {
  loadPixels();
  String message = "";
  int valHolder = 0;
  for (int i=0;i<pixels.length;i++) {
    if (i%4==0) {
      if (valHolder==255) {
        //println("done after "+i+"pixels");
        break;
      } message+=(char)(valHolder);
      valHolder=0;
      //println();
    }
    valHolder = valHolder << 2;
    valHolder += (int)(red(pixels[i]))&3;
    //print(((int)(red(pixels[i]))&3)+" ");
  } return message;
}
PImage decodeFile(String filename, int fileBytes) {
  byte valHolder = 0;
  PImage img = loadImage(filename);
  image(img,0,0);
  img.loadPixels();
  byte[] byteHolder = new byte[fileBytes];
  for (int i=0;i<fileBytes*4;i++) {
    if (i%4==0&&i!=0) {
      byteHolder[i/4-1]=valHolder;
      valHolder = 0;
    }
    valHolder = (byte)(valHolder << 2);
    valHolder = (byte)(valHolder | (int)(red(pixels[i]))&3);
  } saveBytes("extractedImage.png",byteHolder);
  return loadImage("extractedImage.png");
}
