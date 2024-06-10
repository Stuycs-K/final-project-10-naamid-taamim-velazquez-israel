[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/ecp4su41)

## Group Info
Group Members:
- Taamim Naamid
- Isravel Velazquez

## Overview

Our project is to perform video stegonography, despite the challenges that may arise with compression and such.
Our plan to do this is to convert videos into their respective frames, then encode onto those frames, turn them back into videos, then break these new videos back into frames for decoding. This must all be done carefully and without any lossy conversions.

## Instructions
In order to run processing-java, to my knowledge, you need to add it to your PATH.
This can be done by downloading another processing folder, then:
### Windows
- Going to Environment Variables
- Editing PATH and adding it as a variable
### Ubuntu
- Use `nano ~/.bashrc`
- At the very end of the file, add a little command that looks like
- `export PATH="<PATH TO PROCESSING FOLDER>:$PATH"`
Note: The processing-java file must live with processing.exe

You also need to download and install [FFmpeg](https://ffmpeg.org/download.html)!

If `processing-java` and `ffmpeg` are recognized commands and visually do the right thing, you're good.

Now how do you use these you may ask?

# ffmpeg

### to convert a video into frames:

ffmpeg -i <video> <images>.tif

### to convert frames into a video:
ffmpeg -i <frames>.tif -c:v ffv1 <video>.avi


### real example of how we would use this given an original video, original.mp4, and a hidden messsage, secret.txt, that we want to encode onto our original video, which would be called encoded.avi 
ffmpeg -i original.mp4 -comprsesion_level 0 temp/normal_images%05d.tif

### use processing to encode the data of secret.txt onto the normal_images
ffmpeg -i temp/normal_images%05d.tif -c:v ffv1 encoded.avi

// encoding is done, now we can decode
ffmpeg -i encoded.avi temp/tampered_images%05d.tif

# Processing-java

How do you use this you may ask?
> Simply type "processing-java --sketch=$(PWD)/GifEncoding --run"
this will automatically run the program. But it runs it without any arguments, which isn't too useful

You can add arguments to the command by running:

"processing-java --sketch=$(PWD)/GifEncoding --run (int mode) (int FILE_TYPE) (int Frames) (String filename) (int FILE_TYPE) (int frames) (String filename)
What do these variables mean you may ask? I explain all of this in the [Presentation.md](PRESENTATION.md), which is linked here. in the Encoding Process section

Video will be attached here --> 