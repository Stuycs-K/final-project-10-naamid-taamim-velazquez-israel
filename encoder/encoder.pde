// make thing change on keyboard input (space)

import java.util.Arrays;
int LINEAR = 0;
int SELECTIVE = 1;
int FILE = 2;
int DIFF = 3;
int TEST = 4;
int MODE = TEST;
int FILEBYTES = 100576;
String OGFILENAME = "original01.png";
String EDITEDFILENAME = "edited01.png";
color BLACK = color(0);
color WHITE = color(255);
PImage image1;
PImage image2;
int diffMode = 0;
boolean ENCODE = false;
boolean DECODE = false;

//Note: for code that runs one time place all code in setup.
void setup() {
  size(640, 360); // big cat / space
  //size(263,256); // grumpy cat
  //0. If you want to change the size to display the image you can print the dimensions here:
  //println(img.width,img.height);

  image1 = loadImage(OGFILENAME);
  image2 = loadImage(EDITEDFILENAME);

  //e
  //1. Add the cat.png file to the sketch before running.
  if (MODE!=DIFF&&ENCODE) {
    PImage img = loadImage(OGFILENAME);
    //2. Write the MESSAGETOARRAY method
    //convert the string into an array of ints in the range 0-3
    //String messageToEncode = "Idk what im doing, this is just a new test case I guess?";
    String messageToEncode = "This is a message encoded using LSBSteganography. There are two modes that can be selected. This text is getting longer but is just used to make more pixels different.";
    //String messageToEncode = "To be honest, I don't really know what I'm doing. This should be working, though, shouldn't it? Doesn't conceptually make sense why it wouldn't.";
    //String messageToEncode = "This";
    String fileToEncode = "inputfile.png";
    int[] parts = new int[0];
    if (MODE==LINEAR) {
      parts = messageToArray(messageToEncode);
    } if (MODE==FILE) {
      parts = fileToArray(fileToEncode);
      System.out.println("\nEncoded image is "+(parts.length/4)+" bytes");
    }
    //3. Write the MODIFY method.
      
    //save the modified image to disk.
    image(img,0,0);
    loadPixels();
    modifyImage(img, parts);
    img.updatePixels();
    img.save(EDITEDFILENAME);
  }
  //e
  if (MODE==FILE&&DECODE) {
    PImage img3 = loadImage(EDITEDFILENAME);
    image(img3,0,0); //<>//
    loadPixels();
    //println(img3.width,img3.height); //<>//
    PImage decodeAttempt = decodeFile(EDITEDFILENAME,FILEBYTES); //<>//
    image(decodeAttempt,0,0);
    ////println(decodeAttempt.width,decodeAttempt.height);
  } if (MODE==LINEAR&&DECODE) {
    PImage img3 = loadImage(EDITEDFILENAME);
    image(img3,0,0);
    loadPixels();
    String decoded = decodeLinear(img3);
    println(decoded);
  }
  if (MODE==TEST) {
    byte byteHolder1[] = loadBytes("1secv1.avi");
    byte byteHolder2[] = loadBytes("1secv2.avi");
    print(byteHolder1.length+" "+byteHolder2.length);
    for (int i=0;i<byteHolder1.length;i++) {
      if (byteHolder1[i]!=byteHolder2[i]) {
        print(i);
        break;
      }
    }
  }
}
int [] messageToArray(String s) {
  int[]parts = new int[s.length()*4]; //optionally include the terminating character here.
  //calculate the array

  /**Verify the contents of the array before you do more.
   'T' -> 01010100 -> 01 01 01 00 -> 1, 1, 1, 0
   'h' -> 01101000 -> 01 10 10 00 -> 1, 2, 2, 0
   'i' -> 01101001 -> 01 10 10 01 -> 1, 2, 2, 1
   's' -> 01110011 -> 01 11 00 11 -> 1, 3, 0, 3
   ...etc.
   So your data array would look like this:
   { 1, 1, 1, 0, 1, 2, 2, 0, 1, 2, 2, 1, 1, 3, 0, 3...}
   */

   for (int i=0;i<s.length();i++) {
      for (int j=0;j<4;j++) {
        parts[i*4+j]=(s.charAt(i)>>(6-2*j))&3;
        //print(((s.charAt(i)>>(6-2*j))&3)+" ");
      } 
      //System.out.println();
   } 
  return parts;
}
int [] fileToArray(String filename) {
  byte byteHolder[] = loadBytes(filename);
  int[] parts = new int[byteHolder.length*4];
  // change so it goes thru all of byte holder
  for (int i=0;i<byteHolder.length;i++) {
    for (int j=0;j<4;j++) {
      parts[i*4+j]=(byteHolder[i]>>(6-2*j))&3;
    } 
  } 
  byte[] test = new byte[parts.length/4];
  // change so test goes thru all of original
  for (int i=0;i<test.length;i++) {
    test[i] = 0;
    for (int j=0;j<4;j++) {
       test[i]=(byte)(test[i]<<2|parts[i*4+j]);
    }
  }
  return parts;
}
void modifyImage(PImage img, int[]messageArray) {
  //load the image into an array of pixels.
  loadPixels();

  //You can use img.pixels[index] to access this array
  if (MODE == LINEAR) {
    // REMEMBER TO ADD THE 3 3 3 3
    //LINEAR mode :
    //Loop over the pixels in order. For each pixel:
    //-Take one array value and write it to the red channel of the pixel. 
    //-When there are no more letters, write a terminating character.
    //This means 4 pixels will store 1 char value from your String.
    //The terminating character is the value 255.
    //Note: (255 is 11111111b and 11b is just 3, make the termination 
    //pixel store {3,3,3,3}
    
    for (int i=0;i<messageArray.length;i++) {
      int red = (int)red(pixels[i]);
      red = red >> 2;
      red = red << 2;
      red+=messageArray[i];
      //if (i%4==0) {println();}
      //print((red&3)+".");
      img.pixels[i] = color(red,green(pixels[i]),blue(pixels[i]));
    }
    for (int i=0;i<4;i++) {
      int red = (int)red(pixels[i]);
      red = red >> 2;
      red = red << 2;
      red+=3;
      //print((red&3)+".");
      img.pixels[messageArray.length+i] = color(red,green(pixels[messageArray.length+i]),blue(pixels[messageArray.length+i]));
    }
    
  } else if (MODE == SELECTIVE) {
    //SELECTIVE MODE:
    //when the red and green end in 00, modify the last 2 bits of blue with the bit value.
    //e.g.   if the pixel is r = 1100 ,g=1100 and blue=11xy, replace the xy in the blue with the next message value.
    //To terminate the message:
    //when no more message is left to encode, change all the remaining red values that end in 00 to 01.
    //This means the number of pixels that qualify for decoding will be a multiple of 4.
  } else if (MODE == FILE) {
    for (int i=0;i<messageArray.length;i++) {
      
      int red = ((int)red(img.pixels[i]) >> 2);
      red = (red << 2);
      red += messageArray[i];
      //print((red&3)+" ");
      img.pixels[i] = color(red,green(img.pixels[i]),blue(img.pixels[i]));
      
      //int red = (int)(red(img.pixels[i])+(messageArray[i]-((int)(red(img.pixels[i]))&3)));
      //img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i]));
    }
  }

  //write the pixel array back to the image.
  img.updatePixels();
  updatePixels();
}
