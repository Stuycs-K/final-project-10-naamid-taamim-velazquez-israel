import java.util.Arrays;
int LINEAR = 0;
int SELECTIVE = 1;
int FILE = 2;
int DECODE = 3;
int MODE = FILE;


//Note: for code that runs one time place all code in setup.
void setup() {
  size(1200, 600);
  
  //println();println();println();println();println();println();println();

  //1. Add the cat.png file to the sketch before running.
  PImage img = loadImage("cat.png");
  
  //0. If you want to change the size to display the image you can print the dimensions here:
  //println(img.width,img.height);

  //2. Write the MESSAGETOARRAY method
  //convert the string into an array of ints in the range 0-3
  int[]parts;
  
  if(MODE == FILE){
    parts = fileToArray("inputfile.dat");
    println("Number of bytes:"+parts.length/4  );
  }else{
    String messageToEncode = "This is a message encoded using LSBSteganography. There are two modes that can be selected. This text is getting longer but is just used to make more pixels different.";
    parts = messageToArray(messageToEncode);
  }

  //3. Write the MODIFY method.
  modifyImage(img, parts);

  //save the modified image to disk.
  img.save("modifiedCat.png");
  image(img, 0, 0);
  
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
  

  /**Verify the contents of the array before you do more.
   'T' -> 01010100 -> 01 01 01 00 -> 1, 1, 1, 0
   'h' -> 01101000 -> 01 10 10 00 -> 1, 2, 2, 0
   'i' -> 01101001 -> 01 10 10 01 -> 1, 2, 2, 1
   's' -> 01110011 -> 01 11 00 11 -> 1, 3, 0, 3
   ...etc.
   So your data array would look like this:
   { 1, 1, 1, 0, 1, 2, 2, 0, 1, 2, 2, 1, 1, 3, 0, 3...}
   */
  return parts;
}

void modifyImage(PImage img, int[]messageArray) {
  //load the image into an array of pixels.
  img.loadPixels();

  //You can use img.pixels[index] to access this array
  if (MODE == LINEAR || MODE==FILE) {
    //LINEAR mode :
    //Loop over the pixels in order. For each pixel:
    //-Take one array value and write it to the red channel of the pixel. 
    //-When there are no more letters, write a terminating character.
    //This means 4 pixels will store 1 char value from your String. The terminating character is the value 255.
    //Note: (255 is 11111111b and 11b is just 3, make the termination 
    //pixel store {3,3,3,3}
    for (int i=0; i<messageArray.length; i++) {
      //print(red(img.pixels[i]) + " " + messageArray[i]+ " ");
      int red = (int)(red(img.pixels[i])+(messageArray[i]-((int)(red(img.pixels[i]))&3)));
      img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i]));
      //println(red(img.pixels[i]));
    }
  } else if (MODE == SELECTIVE) {
    //SELECTIVE MODE:
    //when the red and green end in 00, modify the last 2 bits of blue with the bit value.
    //e.g.   if the pixel is r = 1100 ,g=1100 and blue=11xy, replace the xy in the blue with the next message value.
    //To terminate the message:
    //when no more message is left to encode, change all the remaining red values that end in 00 to 01.
    //This means the number of pixels that qualify for decoding will be a multiple of 4.
  }

  //write the pixel array back to the image.
  img.updatePixels();
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
   //debug(name, arr);
   
   return arr;
}

void debug(String name, int[] arr) {
  byte[] b = loadBytes(name);
  byte[] nums = new byte[arr.length];
  for (int i=0; i<arr.length; i++) {
    nums[i] = (byte)arr[i];
  }
  saveBytes("Output.png", nums);
  PImage img = loadImage("Output.png");
  byte[] after = new byte[arr.length/4];
  for (int i=0; i<arr.length; i++) {
    after[i/4] = (byte)(after[i/4]<<2);
    println(img.pixels[i]);
    byte red = (byte)((int)(red(img.pixels[i]))&3);
    after[i/4]+=red;
  }
  int count = 0;
  for (int i=0; i<b.length; i++) {
    println(b[i]+": "+arr[i*4]+", "+arr[i*4+1]+", "+arr[i*4+2]+", "+arr[i*4+3] + " -> " + after[i]);
    if (b[i]!=after[i]) {
      count++;
    }
  }
  println(count);
}
