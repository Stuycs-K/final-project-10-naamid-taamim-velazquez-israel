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
  //processing-java --sketch="./GifEncoding/" --run (int mode) (int file_type) (int frame) (string encodefile) (int file_type2) (int frame2) (string encodeInto)
  //                                                  0            1             2               3                  4                 5               6
  //processing-java --sketch="./GifEncoding/" --run 4 0 1 "This is a message" 1 1 0-
  //Decrypt
  //processing-java --sketch="./GifEncoding/" --run (int mode) (int file_decoded) (int frames) (string encodedfile) (int file_decoded) (int frames2) (string decodedInto)
  //                                                  0            1             2               3                  4                 5               6
  //processing-java --sketch="./GifEncoding/" --run 4 0 1 "This is a message" 1 1 0-
  boolean maybe = true;
  String[] args = new String[7];
  if (maybe) {
    int runMessage = 3;
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
      args[3] = "./data/normal/normal00.png"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/cat.png"; // encodedInto
    }
    else if (runMessage==5) {
      args[0] = "5"; // MODE
      args[1] = "1"; // file1
      args[2] = "1"; // frame1
      args[3] = "./data/edited/"; // encodeInto
      args[4] = "1"; // file2
      args[5] = "1"; // frame2
      args[6] = "./data/normal/cat.png"; // encodedInto
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
    parts = new int[2];
  }
  
  if (FILE2==GIF) {
    //String filename = args[6].substring(0, args[6].indexOf("."));
    String filename = args[6];
    oldGif = new Animation(filename, Integer.parseInt(args[5]));
    x = oldGif.images[0].width;
    y = oldGif.images[0].height;
  }
  else if (FILE2==IMG) {
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
    //byte[][] nums = new byte[oldGif.imageCount][oldGif.frame[0].width*oldGif.frame[0].height];
    //nums = getBytes(oldGif,nums[0].length);
    //saveBytes("Output.png", nums);
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
  }

  windowResize(x, y);
}

void draw() {
  MODE = DISPLAY;
  if (MODE==DISPLAY && oldGif!=null) {
    background(255,255,255);
    oldGif.display(0,0);
    delay(1000);
  }
  else if (MODE==DIFF) {
    
  }
  else if (MODE==DIFF_R) {
    
  }
  else if (MODE==DIFF_G) {
    
  }
  else if (MODE==DIFF_B) {
    
  }
  
}

void keyPressed() {
 if (key==' ') {
   MODE++;
 }
 if (MODE>DIFF) {
   MODE=DISPLAY;
 }
 if (key=='f') {
   FILE++;
 }
 if (FILE>GIF) {
   FILE=MESSAGE; 
 }
}

int [] messageToArray(String s) {
  int[]parts = new int[s.length() * 4+4]; //optionally include the terminating character here.
  //calculate the array
  for (int i=0; i<s.length(); i++) {
    char c = s.charAt(i);
    char tmp = 128;
    for (int j=0; j<4; j++) {
      if ((c&tmp)!=0) {
         parts[i*4+j]=2;
         c-=tmp;
      }
      tmp/=2;
      if ((c&tmp)!=0) {
         parts[i*4+j]+=1;
         c-=tmp;
      }
      tmp/=2;
    }
  }
  for (int i=0; i<4; i++) {
    parts[s.length()*4+i]=3; 
  }
  
  return parts;
}

int[] fileToArray(String name) {
   byte[] b = loadBytes(name);
   int[] arr = new int[b.length*4];
   for (int i=0; i<b.length; i++) {
     arr[i*4] = ((b[i]&128)/64) + (b[i]&64)/64;
     arr[i*4+1] = ((b[i]&32)/16) + (b[i]&16)/16;
     arr[i*4+2] = ((b[i]&8)/4) + (b[i]&4)/4;
     arr[i*4+3] = ((b[i]&2)) + (b[i]&1);
   }
   return arr;
}

void modifyFile(Animation gif, int[] parts) {
  int index = 0;
  for (int i=0; i<gif.imageCount; i++) {
    PImage img = gif.images[i];
    int size = gif.images[i].width*gif.images[i].height;
    modifyFile(gif.images[i], parts, index);
    index+=size;
    if (index>=parts.length) {
      img.loadPixels();
      //println((parts.length/3)-+size+(parts.length%3+2)/3);
      //println(index);
      //println(size);
      int pixel = (parts.length/3)-index+size+(parts.length%3+2)/3;
      img.pixels[pixel+1] = color(255,0,0);
      img.pixels[pixel+2] = color(0,255,0);
      img.pixels[pixel+3] = color(0,0,255);
      img.pixels[pixel+4] = color(255,0,0);
      img.updatePixels();
      i+=gif.imageCount;
    }
  }
  
  for (int i=0; i<gif.imageCount;i++) {
    PImage img = gif.images[i];
    img.save("./data/edited/"+ nf(i,5)+".png");
  }
}

byte[][] getBytes(PImage img, int total) {
  byte[][] nums = new byte[total][];
  img.loadPixels();
  //for (int i=0; i<total*4; i++) {
  //  if (i%4==0) {
  //    nums[i/4] = 0;
  //  }
  //  nums[i/4] = (byte)(nums[i/4]<<2);
  //  byte red = (byte)((int)(red(img.pixels[i]))&3);
  //  nums[i/4]+=red;
  //  //print((nums[i/4]&3)+", ");
  //}
  
  ////for (int i=0; i<total; i++) {
  ////  println(nums[i]);
  ////}
  
  return nums;
}

void modifyFile(PImage img, int[] parts, int index) {
  img.loadPixels();
  int pixel = 0;
  for (int i=index*3; i<parts.length && pixel<img.width*img.height; i+=3) {
    //print(red(img.pixels[i]) + " " + messageArray[i]+ " ");
    //int red = (int)(red(img.pixels[i])+(parts[i]-((int)(red(img.pixels[i]))&3)));
    //img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i]));
    //println(red(img.pixels[i]));
    if (i+2<parts.length) {
      int red = (int)(red(img.pixels[pixel])+
      (parts[i]-
      ((int)(red(img.pixels[pixel]))&3)));
      int green = (int)(green(img.pixels[pixel])+(parts[i+1]-((int)(green(img.pixels[pixel]))&3)));
      int blue = (int)(blue(img.pixels[pixel])+(parts[i+2]-((int)(blue(img.pixels[pixel]))&3)));
      img.pixels[pixel] = color(red, green, blue);
    }
    else if (i+1<parts.length) {
      int red = (int)(red(img.pixels[pixel])+(parts[i]-((int)(red(img.pixels[pixel]))&3)));
      int green = (int)(green(img.pixels[pixel])+(parts[i+1]-((int)(green(img.pixels[pixel]))&3)));
      img.pixels[pixel] = color(red, green, blue(img.pixels[pixel]));
    }
    else if (i<parts.length) {
      int red = (int)(red(img.pixels[pixel])+(parts[i]-((int)(red(img.pixels[pixel]))&3)));
      img.pixels[pixel] = color(red, green(img.pixels[pixel]), blue(img.pixels[pixel]));
    }
    pixel++;
  }

  img.updatePixels();
}

String decodeText(PImage img) {
  img.loadPixels();
  String end = "";
  String bit = "";
  for (int i=0; i<img.pixels.length; i++) {
    int red = (int)(red(img.pixels[i]))&3;
    int green = (int)(green(img.pixels[i]))&3;
    int blue = (int)(blue(img.pixels[i]))&3;
    bit += convertToBits(red) + convertToBits(green) + convertToBits(blue);
    if (bit.length()>=8) {
      if (!bit.substring(0,8).equals("11111111")) {
        end += (char)(Byte.parseByte(bit.substring(0, 8),2));
        bit = bit.substring(8);
      }
      else {
        i+=img.pixels.length;
      }
    }
  }
  return end;
}

String decodeTextGif(Animation gif) {
  String end = "";
  String bit = "";
  for (int i=0; i<gif.imageCount; i++) {
    PImage img = gif.images[i];
    img.loadPixels();
    for (int j=0; j<img.pixels.length; j++) {
      int red = (int)(red(img.pixels[j]))&3;
      int green = (int)(green(img.pixels[j]))&3;
      int blue = (int)(blue(img.pixels[j]))&3;
      bit += convertToBits(red) + convertToBits(green) + convertToBits(blue);
      if (bit.length()>=8) {
        if (!bit.substring(0,8).equals("11111111")) {
          end += (char)(Byte.parseByte(bit.substring(0, 8),2));
          bit = bit.substring(8);
        }
        else {
          j+=img.pixels.length;
          i+=gif.imageCount;
        }
      }
    }
  }
  
  
  return end;
}

String convertToBits(int num) {
  if (num==3) {
    return "11";
  }
  else if (num==2) {
    return "10";
  }
  else if (num==1) {
    return "01";
  }
  return "00";
}

void modifyVideo(int[] parts) {
  
}
