import java.io.*;
import java.util.*;
import java.math.*;

final int MESSAGE = 0;
final int IMG = 1;
final int VIDEO = 2;
//GIF == 3

final int ENCRYPT = 4;
final int DECRYPT = 5;
final int DISPLAY = 6;
final int DIFF_R = 7;
final int DIFF_G = 8;
final int DIFF_B = 9;
final int DIFF = 10;

int MODE;
int FILE; int FILE2;
String[] arr = new String[] {"MESSAGE", "IMAGE", "VIDEO", "GIF", "ENCRYPT", "DECRYPT", "DISPLAY", "DIFF_R", "DIFF_G", "DIFF_B", "DIFF"};
PImage newImage; Animation newGif; String newMessage; //stuff to encode
Animation oldGif; //stuff to encode into

void setup() {
  size(0, 0);
  //processing-java --sketch="./GifEncoding/" --run (int mode) (int file_type) (int frame) (string encodefile) (int file_type2) (int frame2) (string encodeInto) (int copout)
  //                                                  0            1             2               3                  4                 5               6               7
  //processing-java --sketch="./GifEncoding/" --run 4 0 1 "This is a message" 1 1 0-
  //Decrypt
  //processing-java --sketch="./GifEncoding/" --run (int mode) (int file_decoded) (int frames) (string encodedfile) (int file_decoded) (int frames2) (string decodedInto) (int copout)
  //                                                  0            1             2               3                  4                 5               6                      7
  //processing-java --sketch="./GifEncoding/" --run 4 0 1 "This is a message" 1 1 0-
  boolean maybe = false;
  //String[] args = new String[9];
  if (maybe) {
    int runMessage =0;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    runMessage = -10;
    
    
    
    
    
    
    
    
    
    
    
    
    
    if (runMessage==-10) { //Cat.png onto idk.mp4
      args[0] = "4";
      args[1] = "1";
      args[2] = "1";
      args[3] = "data/normal/temp/cat.png";
      args[4] = "3";
      args[5] = "30";
      args[6] = "data/normal/image.tif";
      //args[7] = "19206";
    }
    // decode video
    if (runMessage==-9) { //Cat.png onto idk.mp4
      args[0] = "5";
      args[1] = "3";
      args[2] = "30";
      args[3] = "data/normal/temp/imageedit.tif";
      args[4] = "1";
      args[5] = "1";
      args[6] = "data/catReturned.png";
      args[7] = "132";
    }
    
    if (runMessage==-8) { //blah.mp4 onto 1sec.mp4
      args[0] = "4";
      args[1] = "2";
      args[2] = "1";
      args[3] = "data/blah.mp4";
      args[4] = "3";
      args[5] = "30";
      args[6] = "data/normal/image.tif";
      //args[7] = "19206";
    }
    // decode video
    if (runMessage==-7) {
      args[0] = "5";
      args[1] = "3";
      args[2] = "30";
      args[3] = "data/temp/imageedit.tif";
      args[4] = "2";
      args[5] = "1";
      args[6] = "data/returnedBlah.mp4";
      args[7] = "132";
    }
    
    if (runMessage==-6) {//help.gif onto big.png
      args[0] = "4";
      args[1] = "2";
      args[2] = "1";
      args[3] = "data/help.gif";
      args[4] = "3";
      args[5] = "30";
      args[6] = "data/normal/temp/big.png";
      //args[7] = "19206";
    }
    // decode video
    if (runMessage==-5) {//help.gif onto big.png
      args[0] = "5";
      args[1] = "3";
      args[2] = "30";
      args[3] = "data/temp/originaledit.tif";
      args[4] = "1";
      args[5] = "1";
      args[6] = "data/secretcat.png";
      args[7] = "132";
    }
    
    // encode video
    if (runMessage==-4) { //"Hello there world, this is an encoded image" onto cat.png
      args[0] = "4";
      args[1] = "0";
      args[2] = "1";
      args[3] = "Hello there world, this is an encoded image";
      args[4] = "3";
      args[5] = "30";
      args[6] = "data/normal/temp/cat.png";
      //args[7] = "19206";
    }
    // decode video
    if (runMessage==-3) { //"Hello there world, this is an encoded image (Keyboard gibberish" onto cat.png
      args[0] = "5";
      args[1] = "3";
      args[2] = "30";
      args[3] = "data/normal/temp/catedit.png";
      args[4] = "2";
      args[5] = "1";
      args[6] = "terminal";
      //args[7] = "19206";
    }
  }
  MODE = Integer.parseInt(args[0]);
  FILE = Integer.parseInt(args[1]);
  FILE2 = Integer.parseInt(args[4]);
  
  int x;
  int y;
  int[] parts;

  if (FILE==GIF) {
    //String filename = args[3].substring(0, args[3].indexOf("."));
    String filename = args[3];
    newGif = new Animation(filename, Integer.parseInt(args[2]));
    parts = newGif.parts;
  }
  else if (FILE==IMG) {
    newGif = new Animation(args[3]);
    parts = fileToArray(args[3]);
  }
  else if (FILE==MESSAGE) {
    newMessage = args[3];
    parts = messageToArray(newMessage);
  }
  else {
    parts = fileToArray(args[3]);
    println(parts.length/4);
  }
  if (FILE2==GIF && MODE!=DECRYPT) {
    //String filename = args[6].substring(0, args[6].indexOf("."));
    String filename = args[6];
    oldGif = new Animation(filename, Integer.parseInt(args[5]));
    x = oldGif.images[0].width;
    y = oldGif.images[0].height;
  }
  else if (FILE2==IMG && MODE!=DECRYPT) {
    oldGif = new Animation(args[6]);
    x=oldGif.images[0].width;
    y=oldGif.images[0].height;
  }
  else {
    x = 0;
    y = 0;
  }
  if (MODE==ENCRYPT) {
    modifyFile(oldGif, parts);
    println("This is for copout "+parts.length/4);
  }
  else if (MODE==DECRYPT) {
    if (FILE2==MESSAGE) {
      if (FILE==IMG) {
        print(decodeText(newGif.images[0]));
      }
      else {
        print(decodeTextGif(newGif));
      }
    }
    else if (FILE2==IMG) {
      byte[] arr;
      arr = decodeImage(newGif, 0);
      saveBytes(args[6],arr);
      oldGif=new Animation(args[6]);
      x = oldGif.images[0].width;
      y=oldGif.images[0].height;
    }
    //else if (FILE2==GIF) { // FILE2 is a gif
    //  byte[] arr;
    //  arr = decodeImageFromGif(newGif, Integer.parseInt(args[7]));
    //  byte[][] arr2 = new byte[Integer.parseInt(args[5])][];
    //  int distance = Integer.parseInt(args[8]);
    //  split(arr2, arr, distance);
    //  for (int i=0; i<arr2.length; i++) {
    //    saveBytes(args[6]+nf(i,5)+".png",arr2[i]);
    //    //if (i<arr2.length) {
    //    //  println(Arrays.toString(arr2[i]));
    //    //}
    //  }
    //  oldGif=new Animation(args[6], arr2.length);
    //  x = oldGif.images[0].width;
    //  y=oldGif.images[0].height;
    //}
    else if (FILE==GIF) {
      byte[] arr = officialDecodeGif(newGif, Integer.parseInt(args[7]));
      saveBytes(args[6], arr);
    }
    else {
      byte[] arr;
      arr = decodeImageFromGif(newGif, Integer.parseInt(args[7]));
      saveBytes(args[6], arr);
    }
  }
  MODE = DISPLAY;
  windowResize(x, y);
}

void draw() {
  
  if (MODE==DISPLAY && oldGif!=null) {
    background(255,255,255);
    oldGif.display(0,0);
    delay(1000);
  }
  else if (MODE==DIFF) {
    diffCalled(oldGif.images[0], newGif.images[0]);
  }
  else if (MODE==DIFF_R) {
    diffCalledRed(oldGif.images[0], newGif.images[0]);
  }
  else if (MODE==DIFF_G) {
    diffCalledGreen(oldGif.images[0], newGif.images[0]);
  }
  else if (MODE==DIFF_B) {
    diffCalledBlue(oldGif.images[0], newGif.images[0]);
  }
  
}

void keyPressed() {
 if (key==' ') {
   MODE++;
 }
 if (MODE>DIFF) {
   MODE=DISPLAY;
 }
}

void modifyVideo(int[] parts) {
  
}
