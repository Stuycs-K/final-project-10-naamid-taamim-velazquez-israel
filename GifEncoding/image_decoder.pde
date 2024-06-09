byte[] decodeImage(Animation gif) { // works
  byte[] num = new byte[gif.images[0].width*gif.images[0].height];
  int byteNum = 0;
  PImage img = gif.images[0];
  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {
    num[byteNum] = (byte)(num[byteNum]<<2);
    num[byteNum] += (byte)(red(img.pixels[i]))&3;
    if (i%4==1) {
      byteNum++;
      if (checker(img, i)) {
        break;
      }
    }
    num[byteNum] = (byte)(num[byteNum]<<2);
    num[byteNum] += (byte)(green(img.pixels[i]))&3;
    if (i%4==2) {
      byteNum++;
      if (checker(img, i)) {
        break;
      }
    }
    num[byteNum] = (byte)(num[byteNum]<<2);
    num[byteNum] += (byte)(blue(img.pixels[i]))&3;
    if (i%4==3) {
      byteNum++;
      if (checker(img, i)) {
        break;
      }
    }
  }
  
  byte[] returned = new byte[byteNum];
  for (int i=0; i<byteNum; i++) {
    returned[i] = num[i];
  }
  
  return returned;
  
}

byte[] decodeImageFromGif(Animation gif) { // does not work
  byte[] num = new byte[gif.images[0].width*gif.images[0].height*1000+100];
  int byteNum = 0;
  int tracker = 0;
  for (int j=0; j<gif.imageCount; j++) {
    PImage img = gif.images[j];
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      num[byteNum] = (byte)(num[byteNum]<<2);
      num[byteNum] += (byte)(red(img.pixels[i]))&3;
      if (i%4+tracker%3==1) {
        byteNum++;
        if (checker(img, i)) {
          tracker=-1;
          break;
        }
      }
      num[byteNum] = (byte)(num[byteNum]<<2);
      num[byteNum] += (byte)(green(img.pixels[i]))&3;
      if (i%4+tracker%3==2) {
        byteNum++;
        if (checker(img, i)) {
          tracker=-1;
          break;
        }
      }
      num[byteNum] = (byte)(num[byteNum]<<2);
      num[byteNum] += (byte)(blue(img.pixels[i]))&3;
      if (i%4+tracker%3==3) {
        byteNum++;
        if (checker(img, i)) {
          tracker=-1;
          break;
        }
      }
    }
    if (tracker==-1) {
      break;
    }
    tracker = img.pixels.length%3;
  }
  
  byte[] returned = new byte[byteNum];
  for (int i=0; i<byteNum; i++) {
    returned[i] = num[i];
  }
  
  return returned;
  
}

int change(int tracker) {
  if (tracker==3) {
    return 0;
  }
  return tracker+1;
}

boolean checker(PImage img, int index) {
  return (int)(red(img.pixels[index]))==255 && (int)(red(img.pixels[index+3]))==255 && (int)(blue(img.pixels[index+2]))==255 && (int)(green(img.pixels[index+1]))==255;
}

String decodeText(PImage img) {//works
  img.loadPixels();
  String end = "";
  String bit = "";
  for (int i=0; i<img.pixels.length; i++) {
    int red = (int)(red(img.pixels[i]))&3;
    int green = (int)(green(img.pixels[i]))&3;
    int blue = (int)(blue(img.pixels[i]))&3;
    bit += convertToBits(red) + convertToBits(green) + convertToBits(blue);
    if (bit.length()>=8) {
      if (!bit.substring(0,8).equals("11111111")) {
        end += (char)(Byte.parseByte(bit.substring(0, 8),2));
        bit = bit.substring(8);
      }
      else {
        i+=img.pixels.length;
      }
    }
  }
  return end;
}

String decodeTextGif(Animation gif) {//works
  String end = "";
  String bit = "";
  for (int i=0; i<gif.imageCount; i++) {
    PImage img = gif.images[i];
    img.loadPixels();
    for (int j=0; j<img.pixels.length; j++) {
      int red = (int)(red(img.pixels[j]))&3;
      int green = (int)(green(img.pixels[j]))&3;
      int blue = (int)(blue(img.pixels[j]))&3;
      bit += convertToBits(red) + convertToBits(green) + convertToBits(blue);
      if (bit.length()>=8) {
        if (!bit.substring(0,8).equals("11111111")) {
          end += (char)(Byte.parseByte(bit.substring(0, 8),2));
          bit = bit.substring(8);
        }
        else {
          j+=img.pixels.length;
          i+=gif.imageCount;
        }
      }
    }
  }
  
  
  return end;
}

String convertToBits(int num) {//works
  if (num==3) {
    return "11";
  }
  else if (num==2) {
    return "10";
  }
  else if (num==1) {
    return "01";
  }
  return "00";
}
