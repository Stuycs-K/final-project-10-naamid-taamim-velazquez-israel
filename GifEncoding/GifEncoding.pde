import java.io.*;
import java.util.*;
import java.math.*;

final int MESSAGE = 0;
final int IMG = 1;
final int VIDEO = 2;
//GIF == 3

final int DISPLAY = 4;
final int ENCRYPT = 5;
final int DECRYPT = 6;
final int DIFF_R = 7;
final int DIFF_G = 8;
final int DIFF_B = 9;
final int DIFF = 10;

int MODE;
int FILE; int FILE2;
String[] arr = new String[] {"MESSAGE", "IMAGE", "VIDEO", "GIF", "DISPLAY", "ENCRYPT", "DECRYPT", "DIFF_R", "DIFF_G", "DIFF_B", "DIFF"};
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

  if (FILE==GIF) {
    newGif = new Animation(args[3], Integer.parseInt(args[2]));
  }
  else if (FILE==IMG) {
    newImage = loadImage(args[3]);
  }
  else if (FILE==MESSAGE) {
    newMessage = args[3];
  }
  else {
    
  }
  
  if (FILE2==GIF) {
    oldGif = new Animation(args[6], Integer.parseInt(args[5]));
    x = oldGif.images[0].width;
    y = oldGif.images[0].height;
  }
  else if (FILE2==IMG) {
    oldImage = loadImage(args[6]);
    x=oldImage.width;
    y=oldImage.height;
  }
  else {
    x = 0;
    y = 0;
  }
  if (MODE==ENCRYPT) {
  
  }
  else if (MODE==DECRYPT) {
    
  }
  else if (MODE==DISPLAY) {
    
  }
  else if (MODE==DIFF) {
    
  }
  else if (MODE==DIFF_R) {
    
  }
  else if (MODE==DIFF_G) {
    
  }
  else if (MODE==DIFF_B) {
    
  }
  
  

  windowResize(x, y);
}

void draw() {
  
  
  
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
     //println((b[i]&128) + " " + (b[i]&64) + " " + (b[i]&32) + " " + (b[i]&16) + " " + (b[i]&8) + " " + (b[i]&4) + " " + (b[i]&2) + " " + (b[i]&1) + " ");
     arr[i*4] = ((b[i]&128)/64) + (b[i]&64)/64;
     arr[i*4+1] = ((b[i]&32)/16) + (b[i]&16)/16;
     arr[i*4+2] = ((b[i]&8)/4) + (b[i]&4)/4;
     arr[i*4+3] = ((b[i]&2)) + (b[i]&1);
     //println(b[i]+": "+arr[i*4]+", "+arr[i*4+1]+", "+arr[i*4+2]+", "+arr[i*4+3]);
   }
   
   return arr;
}

void modifyFile(Animation gif, int[] parts) {

}
