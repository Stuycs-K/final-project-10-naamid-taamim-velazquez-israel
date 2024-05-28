import java.io.*;
import java.util.*;
import java.math.*;

Animation gif;
final int MESSAGE = 0;
final int IMAGE = 1;
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
int FILE_TYPE;
String[] arr = new String[] {"MESSAGE", "IMAGE", "VIDEO", "GIF", "DISPLAY", "ENCRYPT", "DECRYPT", "DIFF_R", "DIFF_G", "DIFF_B", "DIFF"};


void setup() {
  gif = new Animation("androidSpin", 30);
  gif.display(0,0);
  //put text on screen with arr[MODE]
  //put text on screen with arr[FILE_TYPE]
}

void draw() {
  PImage newImage;
  Animation newGif;
  int[] parts;
  if (MODE==DISPLAY) {
    gif.display(0,0);
  }
  else if (MODE==ENCYRPT) {
    /*
    String argument = argument;
    if(FILE_TYPE != MESSAGE){
      parts = fileToArray(argument);
    }else{
      parts = messageToArray(argument);
    }
    */
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