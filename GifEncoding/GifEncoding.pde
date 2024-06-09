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
  boolean maybe = true;
  String[] args = new String[9];
  if (maybe) {
    int runMessage = 7;
    if (runMessage==0) {
      args[0] = "4"; // MODE
      args[1] = "0"; // file1
      args[2] = "1"; // frame1
      args[3] = "This is a message"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/cat.png"; // encodedInto
    }
    else if (runMessage==1) {
      args[0] = "5"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/edited/00000.png"; // encoded
      args[4] = "0"; // file2
      args[5] = "1"; // frame2
      args[6] = "terminal"; // decodeInto
    }
    else if (runMessage==2) {
      args[0] = "4"; // MODE
      args[1] = "0"; // file1
      args[2] = "1"; // frame1
      args[3] = "This is a message"; // encodeInto
      args[4] = "3"; // file2
      args[5] = "30"; // frame2
      args[6] = "./data/normal/normal"; // encodedInto
    }
    else if (runMessage==3) {
      args[0] = "5"; // MODE
      args[1] = "3"; // file1
      args[2] = "30"; // frame1
      args[3] = "./data/edited/"; // encodeInto
      args[4] = "0"; // file2
      args[5] = "1"; // frame2
      args[6] = "terminal"; // encodedInto
    }
    else if (runMessage==4) {
      args[0] = "4"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/normal/normal00000.png"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/cat.png"; // encodedInto
    }
    else if (runMessage==5) {
      args[0] = "5"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/edited/00000.png"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/returned.png"; // encodedInto
    }
    else if (runMessage==6) { // Not working: image onto gif
      args[0] = "4"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/normal/cat.png"; // encodeInto
      args[4] = "3"; // file2
      args[5] = "30"; // frame2
      args[6] = "./data/normal/normal"; // encodedInto
    }
    else if (runMessage==7) { // not working: image from gif
      args[0] = "5"; // MODE
      args[1] = "3"; // file1
      args[2] = "30"; // frame1
      args[3] = "./data/normal/normal"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/cats.png"; // encodedInto
      args[7] = "116280"; // Amount of bytes
    }
    else if (runMessage==8) { // gif onto image
      args[0] = "4"; // MODE
      args[1] = "2"; // file1
      args[2] = "30"; // frame1
      args[3] = "./data/help.gif"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/big.png"; // encodedInto
    }
    else if (runMessage==9) { // gif from image
      args[0] = "5"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/edited/00000.png"; // encodeInto
      args[4] = "2"; // file2
      args[5] = "30"; // frame2
      args[6] = "./data/normal/cats.gif"; // encodedInto
      args[7] = "5804408"; //How big parts is
    }
    else if (runMessage==10) { // gif onto image
      args[0] = "4"; // MODE
      args[1] = "2"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/ffmpeg.mp4"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/big.png"; // encodedInto
    }
    else if (runMessage==11) { // gif from image
      args[0] = "5"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/edited/00000.png"; // encodeInto
      args[4] = "2"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/blah.mp4"; // encodedInto
      args[7] = "11452"; //How big parts is
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
    println(parts.length);
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
  if (MODE==ENCRYPT && FILE2!=GIF) {
    modifyFile(oldGif, parts);
  }
  else if (MODE==ENCRYPT && FILE2==GIF) {
    modifyGIF(oldGif, parts);
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
      officialDecodeGif(newGif, Integer.parseInt(args[7]));
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
