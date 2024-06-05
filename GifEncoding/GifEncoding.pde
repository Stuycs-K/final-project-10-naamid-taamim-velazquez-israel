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
PImage oldImage; Animation oldGif; //stuff to encode into

void setup() {
  size(0, 0);
  //processing-java --sketch="./GifEncoding/" --run (int mode) (int file_type) (int frame) (string encodefile) (int file_type2) (int frame2) (string encodeInto)
  //                                                  0            1             2               3                  4                 5               6
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
    parts = fileToArray(args[3]);
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
  }
  else if (MODE==DECRYPT) {
    
  }

  
  

  windowResize(x, y);
}

void draw() {
  
  if (MODE==DISPLAY) {
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
    modifyFile(gif.images[i], parts, index);
    index+=gif.images[i].width*gif.images[i].height;
  }
}

void modifyFile(PImage img, int[] parts, int index) {
  img.loadPixels();
  int pixel = 0;
  for (int i=index*3; i<parts.length; i+=3) {
    //print(red(img.pixels[i]) + " " + messageArray[i]+ " ");
    //int red = (int)(red(img.pixels[i])+(parts[i]-((int)(red(img.pixels[i]))&3)));
    //img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i]));
    //println(red(img.pixels[i]));
    if (i+2<parts.length) {
      int red = (int)(red(img.pixels[pixel])+(parts[i]-((int)(red(img.pixels[pixel]))&3)));
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

void modifyVideo(int[] parts) {
  
}
