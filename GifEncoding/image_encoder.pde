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
    img.loadPixels();
    int size = gif.images[i].pixels.length;
    modifyFile(gif.images[i], parts, index);
    index+=size;
    if (index>=parts.length/3) {
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

void modifyFile(PImage img, int[] parts, int index) {
  img.loadPixels();
  int pixel = 0;
  for (int i=index*3; i<parts.length && pixel<img.width*img.height; i+=3) {
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
