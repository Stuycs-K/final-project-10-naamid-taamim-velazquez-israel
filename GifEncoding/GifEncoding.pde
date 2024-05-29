import java.io.*;
import java.util.*;
import java.math.*;

Animation gif;
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

int MODE =  DISPLAY;
int FILE_TYPE = MESSAGE;
String[] arr = new String[] {"MESSAGE", "IMAGE", "VIDEO", "GIF", "DISPLAY", "ENCRYPT", "DECRYPT", "DIFF_R", "DIFF_G", "DIFF_B", "DIFF"};


void setup() {
  size(0, 0);
  gif = new Animation("data/"+"androidSpin", 49);
  gif.display(0,0);
  windowResize(gif.images[0].width, gif.images[0].height);
  //put text on screen with arr[MODE]
  //put text on screen with arr[FILE_TYPE]
	println("Press space to change the mode. F to change the file_type");
  if (args==null) {
    args = new String[0];
  }
  if (args.length>0) {
    println(args[0]);
  }
}

void draw() {
  PImage newImage;
  Animation newGif;
  int[] parts;
  if (MODE==DISPLAY) {
    gif.display(0,0);
    delay(75);
  }
  else if (MODE==ENCRYPT) {
    String argument = "";
    if(FILE_TYPE == MESSAGE){
      parts = messageToArray(argument);
    }else{
      parts = fileToArray(argument);
    }
  }
  text("MODE =" + arr[MODE], 0, 10);
  text("FILE_TYPE to encode" + arr[FILE_TYPE], 0, 20);
}

void keyPressed() {
 if (key==' ') {
   MODE++;
 }
 if (MODE>DIFF) {
   MODE=DISPLAY;
 }
 if (key=='f') {
   FILE_TYPE++;
 }
 if (FILE_TYPE>GIF) {
   FILE_TYPE=MESSAGE; 
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
