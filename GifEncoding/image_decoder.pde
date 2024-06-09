byte[] decodeImage(Animation gif, int n) { // works
  byte[] num = new byte[gif.images[n].width*gif.images[n].height];
  int byteNum = 0;
  PImage img = gif.images[n];
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

byte[] decodeImageFromGif(Animation gif, int distance) {
  byte[] nums = new byte[distance/4];
  int n = 0;
  for (int j=0; j<gif.imageCount; j++) {
    PImage img = gif.images[j];
    for (int i=0; i<distance/3 && i<img.pixels.length; i++) {
      nums[n] = (byte)(nums[n]<<2);
      nums[n] += (byte)((int)(red(img.pixels[i]))&3);
      if (i%4==1) {
        n++;
      }
      nums[n] = (byte)(nums[n]<<2);
      nums[n] += (byte)((int)(green(img.pixels[i]))&3);
      if (i%4==2) {
        n++;
      }
      nums[n] = (byte)(nums[n]<<2);
      nums[n] += (byte)((int)(blue(img.pixels[i]))&3);
      if (i%4==3) {
        n++;
      }
      //println((int)(red(img.pixels[i]))&3);
    }
    distance-=img.pixels.length*3;
  }
  return nums;
  
}

void split(byte[][] arr, byte[] arr2, int distance) {
  int size = 0;
  int index = 0;
  distance/=4;
  byte[] tmp = new byte[distance];
  for (int i=0; i<arr2.length; i++) {
    tmp[i-size] = arr2[i];
    if (i-size==tmp.length-1 && distance!=index-1) {
      byte[] storage = new byte[tmp.length];
      for (int j=0; j<tmp.length; j++) {
        storage[j] = tmp[j];
      }
      arr[index] = storage;
      index++;
      size=i+1;
      tmp = new byte[distance];
    }
  }
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


byte[] officialDecodeGif(Animation gif, int num) {
  byte[] arr = new byte[num/4];
  int index = 0;
  int byteNum = 0;
  for (int j=0; j<gif.imageCount; j++) {
    PImage img = gif.images[j];
    int pixel = 0;
    for (int i=index; i<img.pixels.length && i*3<num; i++) {
      arr[byteNum] = (byte)(arr[byteNum]<<2);
      arr[byteNum] += (byte)((int)(red(img.pixels[pixel]))&3);
      if (i%4==1) {
        byteNum++;
      }
      arr[byteNum] = (byte)(arr[byteNum]<<2);
      arr[byteNum] += (byte)((int)(green(img.pixels[pixel]))&3);
      if (i%4==2) {
        byteNum++;
      }
      arr[byteNum] = (byte)(arr[byteNum]<<2);
      arr[byteNum] += (byte)((int)(blue(img.pixels[pixel]))&3);
      if (i%4==3) {
        byteNum++;
      }
      index=i+1;
    }
  }
  return arr;
}
