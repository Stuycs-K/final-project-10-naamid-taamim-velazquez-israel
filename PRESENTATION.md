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
Note: The processing-java file must live with processing.exe (supposedly)

# Let's Encode a GIF

So, you probably remember that one image processing lab where we encoded images and text and stuff onto other images, but what if we did this with a GIF?
I mean, theoretically, a GIF is just a series of images, so this shoulnd't be that unreasonable, right?
Yes, in fact, this is not that unreasonable of a task if you go about it with the right approach.
However, we must consider some reasons why we are allowed to use GIFs instead of other "video" formats

## Why are GIFs usable?

GIFs are a collection of PNGs, which is really important because it means that GIFs are lossless. This allows us to extract each of the PNGs in a GIF and put them back into a GIF without any shenanigans.
To do this, we have a variety of options. We can use tools such as FFMpeg
