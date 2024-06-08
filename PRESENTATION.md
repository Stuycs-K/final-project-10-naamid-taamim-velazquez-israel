# This document is required.

In order to run processing-java, to my knowledge, you need to add it to your PATH.
This can be done by downloading another processing folder, then:
## Windows
- Going to Environment Variables
- Editing PATH and adding it as a variable
## Ubuntu
- Use `nano ~/.bashrc`
- At the very end of the file, add a little command that looks like
- `export PATH="<PATH TO PROCESSING FOLDER>:$PATH"`
Note: The processing-java file must live with processing.exe
If `processing-java` runs and gives you something that works, then you're good.

You also need to download and install FFmpeg!

# Let's Encode a GIF

So, you probably remember that one image processing lab where we encoded images and text and stuff onto other images, but what if we did this with a GIF?
I mean, theoretically, a GIF is just a series of images, so this shoulnd't be that unreasonable, right?
Yes, in fact, this is not that unreasonable of a task if you go about it with the right approach.
However, we must consider some reasons why we are allowed to use GIFs instead of other "video" formats

## Why are GIFs usable?

GIFs are a collection of PNGs, which is really important because it means that GIFs are lossless. This allows us to extract each of the PNGs in a GIF and put them back into a GIF without any shenanigans.
To do this, we have a variety of options. We can use tools such as FFMpeg or ImageMagick to extract the frames from a GIF for us.
All we have to do is run a normal command like `convert something.gif something.png`, right? Surely there won't be any foreseeable issue with something this simple?

Anyways, now that we have frames, we can do our actual editing on these frames. We already did something like this right?
Yep, if you remember the image processing lab, it now becomes pretty trivial to encrypt data or decrypt data from out images, but let's do it one better.

Isn't it really annoying that you have to encode images signifantly smaller than your original image?
This is because we only utilized the red color channel, meaning the data we encrypted not only had to be 2 bits of a byte, but that byte was only 1/3 of all the colors shown at all...
Well, let's change it so that we just put data on all of the color channels. You might argue that this makes it easier to sport if there is secret data encrypted onto something, and you might be right, but if someone can tell that the red channel has been modified anyways, they would probably have been able to detect if the green/blue channels were modified and vise versa.

But wait, GIFs! Unlike our image lab, we didn't even consider if data we needed to extract was in multiple images (because that wasn't the task).
But with GIFs, which are just multiple images stitched together, we can encode even bigger things than just one of our frames can hold by carrying over our data that we need to decrypt between multiple frames!
We can even encode GIFs onto other GIFs like this! Since we can just encode all the bytes of a GIF onto another GIF, we don't even need to worry about when the frames of the GIF we encode start or end.

However, speaking of the start and ending of decoding, we need to talk about when to stop taking in data for our decrypt mode. 
The way we did this in the image processing lab is to use the exact number of bytes we expect our output to be. This is an interesting approach, but let's just make an ending sequence.
An ending sequence is easy to do with text messages since ASCII doesnt use all values of a byte (so something like 1000 0000 is not actual ASCII, and can be used as an ending condition), but is a little more complicated for if things *can* actually hold all values of a byte (like a color value).
For this... we can just use a simple combination that's unlikely. Something like an all-red pixel then an all-green pixel then an all-blue pixel should suffice. This isn't a *good* solution by any means, but it is *a* solution.

So now, with our edited images and a decoder that is modified alongisde the changes of our encoder, all we have left to do is stitch together the images into a GIF and see if our code works (which it hopefully does, or else this would be really awkward).

# Let's Do Some Video Stuff

So, GIFs are cool and all, but another form of stitched-together-images is a video.
Now, this seems like it would be just like GIFs, right? Well, you'd be completely wrong...

## Why are videos harder than GIFs?

Isn't it cool how videos, despite having a whole lot of frames of images, can be so small in file size?
Well its because the video is compressed, meaning images and audio are left *around* the same.
But *around* the same does not mean that it *is* the same, and compression means that you lose data, meaning that it is really hard to encode data because it can straight up be lost.

## Compression

This means we need to avoid compression at all costs at every step of our procedures, which is an interesting task because usually with video compression, the idea is to compress things as much as possible but maintain an acceptable level of output.
ImageMagick will no longer
