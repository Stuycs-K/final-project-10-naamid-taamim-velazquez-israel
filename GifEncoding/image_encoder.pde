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
    if (i>=1) {
      println("Encoded file is too big to fit in a single image, moving onto the next");
      if (i==gif.imageCount-1) {
         println("Dude the file youre trying to encode is way too big comparative to what you're trying to encode it onto...");
      }
    }
    PImage img = gif.images[i];
    modifyFile(img, parts, index);
    index+=gif.images[i].pixels.length;
  }
  for (int i=0; i<gif.imageCount;i++) {
    PImage img = gif.images[i];
    String tmp = gif.file.substring(0, gif.file.indexOf("."))+"edit"+nf(i+1,5)+gif.file.substring(gif.file.indexOf("."));
    println(tmp);
    img.save(tmp);
  }
}

void modifyFile(PImage img, int[] parts, int index) {
  img.loadPixels();
  int pixel = 0;
  for (int i=index*3; i<parts.length && pixel<img.width*img.height; i+=3) {
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

void modifyGIF(Animation gif, int[] parts) {
  int index = 0; int red; int green; int blue;
  for (int j=0; j<gif.imageCount; j++) {
    PImage img = gif.images[j];
    int pixel = 0;
    for (int i=index; pixel<img.pixels.length && i<parts.length; i+=3) {
      red = (int)(red(img.pixels[pixel])+(parts[i]-((int)(red(img.pixels[pixel]))&3)));
      if (i+2<index) {
        green = (int)(green(img.pixels[pixel])+(parts[i+1]-((int)(green(img.pixels[pixel]))&3)));
        blue = (int)(blue(img.pixels[pixel])+(parts[i+2]-((int)(blue(img.pixels[pixel]))&3)));
      }
      else if (i+1<index) {
        green = (int)(green(img.pixels[pixel])+(parts[i+1]-((int)(green(img.pixels[pixel]))&3)));
        blue = (int)blue(img.pixels[pixel]);
      }
      else {
        green = (int)green(img.pixels[pixel]);
        blue = (int)blue(img.pixels[pixel]);
      }
      img.pixels[pixel] = color(red, green, blue);
      pixel++;
      index = i+3;
    }
  }
  println(index-3);
}
