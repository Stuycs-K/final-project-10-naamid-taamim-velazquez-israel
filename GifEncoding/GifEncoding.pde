import java.io.*;
import java.util.*;
import java.math.*;

Animation gif;

final int VIDEO = 2;
//GIF == 3

final int DISPLAY = 4;
final int ENCRYPT = 5;
final int DECRYPT = 6;
final int DIFF_R = 7;
final int dIFF_G = 8;
final int DIFF_B = 9;
final int DIFF = 10;

int MODE =  DISPLAY;
int FILE_TYPE;


void setup() {
  gif = new Animation("androidSpin", 30);
  gif.display(0,0);
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
   FILE_TYPE++;
 }
 if (FILE_TYPE>GIF) {
   FILE_TYPE=VIDEO; 
 }
}
