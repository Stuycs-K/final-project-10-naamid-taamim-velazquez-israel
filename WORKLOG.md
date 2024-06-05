# Work Log

## GROUP MEMBER 1: Israel Velazquez Rugama

### 5/22/24

I have finished clearing out my entire home directory. Firefox apparently took nearly a full gigabyte in total and that was fun to clear
I have made a tryhackme room and invited Taamim into it. Currently doesn't have much, but we're ready to work on it, and add the answers into the hints so it's not too hard
We also have created a team name, previously I made it Tameal, but now we have instead gone for 'Isam'... Enjoy!
Found some gifs on the internet to add to the project, trying to figure out how to install processing java
added Processing-java

### 5/22/24 HW

updated Homework.md
found a place to install processing-java but it seems like that'll take .5 GB, which only I can stomach before it makes our GB limit go above 1GB

### 5/23/24 

Delted Homework.md
Struggled with Animation, and trying to figure out how to import a class even though it worked in my previous project
I clapped loudly because it seemed like Mr K was trying to gather everyone's attentions and then people were still talking over him "Childreen should be seen not heard" was the phrase I heard him utter. So then my thought process was to gather everyone's attention to Mr K because he was prolly trying to tell us something and instead it seemed like I was being an idiot... Which I was lmao
I've also attempted to figure out how to import libraries instead of doing an Animation class... This also failed on us. I'm not sure exactly how to continue honestly
I've figured out how to make it work :D. I had forgotten a bit of java cause it was processing, I have to do 'new Animation' in order to get it to work

### 5/23/24 HW

We discussed creating different functions in order to make the workload more seamless and clean. 
I have also discovered that the only way to work with gifs in processing is with our old graphics project :/
This will be fun to consider the implications of. I'll try and find out if you can convert a gif into a the series of kmages that it is.
otherwise there's almost no real way to do our project D;

### 5/24/24

I have discovered a way to turn online gifs into images in order to work properly with our processing program
I have made a makefile
I have made that makefile not have any error when you try to make clean, because it was bothering me D;
Added some code in processing to make the MODE / FILE_TYPE loop around so that I can change it without having to look back at the code
Added a processing-java command to work well in conjunction with Taamim's export code once they add it

### 5/24-27/24 HW
I have pulled old processing code in order to more efficiently encode messages or file. Does not currenntly work with gifs, will need to be updated to include those.
I added some code in the future so I can ask about the way arguments work in processing. Also some code to add some cool text to our build so people can see their changes live.
Made a string array to further make text additions easier to track
Started working on the draw loop and adding if statement for our different functions
Added different modes to accept images and messages as a part of encrypting...Which should have been there from the beginning but don't ask me lmao
Arguments for gifs will be fun
Will pull Graphics project to repo tomorrow for better testing

### 5/28/24

I added a lot of stuff. Made the window resize, added more code... TO BE EXPANDED LATER
I also got rid of sll the errors, and noe know how the arguments work for processing. only thing left really is to make the new functions, and then make the makefile work with the program

### 5/28/24 HW
Tested the logistics for how exactly to encode a gif, and encode into a gif. Seems like we just need to encode a gif to have every single byte into a massive array, basically it's just how a png works but with a lot of images.
In order to encode intk a gif, we just do the encode process normally, putting it into the different colors. Except we move to a new png lf the gif if we run out of room.
decoding will be harder. we'd need to find a condition to stop. we debated over having one tilr being all red, followed by one tile being all blue, and the final tile being all green in order to tell us to stop. works better for gifs rather than images tho, cause those cllors only appear for a second

### 5/29/24
Started working on the makefile
Allowed the file to work with arguments
Found out that gifs get converted via an earlier method we have
All we need to do it encode and decode in a specific way

### 5/29/24 HW
Made some minor modifications to the processing code
Getting ready to start encoding an image into the colors

### 5/30/24
I worked on processing
Fixed how I did the setup
Really close to being done

### 5/30/24 HW
So here's how it'll work out
run "processing-java --sketch="name" (int mode) (int filetype1) (int frames1) (string filename) (int filetype2) (int frames2) (string filename2)
then from there, we'll have encyrpt/decrypt modes, and let the user cyxle through Diffs to see the difference vs the original image
so the diffs and display are all in draw, everything else is in setup

### 5/31/24
So I am nearly done with the encryption method, even though a lot of the work I did wasn't needed
I still need to be able to end the encrption whenever so then I need a closing statement to the encryption like all red, then green, then blue
moved some stuff from the setup to the draw
Need to finish Decrypt

### 5/31/24 HW
Finished Encryption
Encryption now needs red, green, blue, and then a red pixel back to back at the very end
I find this hughly improbably to find in a file naturally, so imma keep it
decrypt comes next

### 6/3/24
Encrypt also works with gifs now, forgot to do that earlier
Pasting run command here: processing-java --sketch="./GifEncoding/" --run (int mode) (int file_type) (int frame) (string encodefile) (int file_type2) (int frame2) (string encodeInto)
Need to fix encyrpting

### 6/3/24 HW
Ahh, white pixels overtook my images somehow
encryption code seems to be broken. or background. it's verg trippy all honesty

### 6/5/24
Started working encryption for images, seems to work when encyrpting. Gonna start on decrypting to make sure lmao
Made sure Encrypt was compatible with decrypt. It seems to work with messages. I'm starting to work on a function to tell the decoder when to stop for both images/gifs and messages. 

## GROUP MEMBER 2: Taamim Naamid

### May 22, 2024

Doing some worksheet filling

### May 22, 2024 (HW)

Tried to figure out how to use processing-java in order to run processing from terminal?, which would be useful since then we can just tun it from a makefile (not much luck).

### May 23, 2024

Tried to work on getting processing-java and failed, the PATH is not PATH-ing even thought I added it to like .bashrc or something and failed, it works on windows though so maybe that means something / worth considering.

### May 23, 2024 (HW)

Tried to get processing-java to work again, but Ubuntu seems to be really averse to working the way I think it would. Supposedly just adding it to the PATH should work (did for windows at least) but Ubuntu really doesn't care about it (maybe my cmd was wrong or something? It is definitely added to thr PATH though).

### May 24, 2024

Working on the video side because hopefully GIFs aren't too terribly difficult to do. Right now, the idea is to use a lossless format (currently looking at FFmpeg) and then do some stuff with that and eventually getting encoding/decoding working on it, after I figure out how it'll work. It would be kind of funny if we can just turn it into a GIF and then use normal GIF operations on it and ultimately turn it back into an FFmpeg but I don't think that is an interesting solution (it would be cool if I can try to figure out how to do it with a lossy compression format but that doesn't seem like something that I can figure out very easily beacuse video compression is good and awesome and terrible for keeping frames exactly the same as you put them in for the sake of efficiency).
Also here is a link that might be useful for the FFmped into GIF route https://video.stackexchange.com/questions/23530/use-ffmpeg-to-create-a-video-from-a-few-images.
I have also come to raelize that Processing might just solve these problems because its built in video maker might have the capability to export a video as a lossless video format (I don't know how compatible this will be in a general situation ofr what kind of file that it'll turn into, but it's probably more convenient to use a video made in Processing in Processing.

### May 28, 2024 (HW)

Looked into the FFmpeg stuff and I think that it should be doable to extract frames and stitch them together to form a video. Theoretically, it should also be possible to also extract and encrypt things in audio as well (using FLAC if we want to do this) but honestly I think that this is enough research for a game plan in order to get things done.

### May 28, 2024

Me when FFmpeg (does not end well)

### May 29, 2024 (HW)

Tried to get FFmpeg to work on Windows, and it doesn't like me (at least it's mutual). I think I have something working, though, so that's a good "start" since GIF encoding shouldn't be that bad theoretically...

### May 29, 2024

FFmpeg is working on windows but it really doesn't want to work? Like I'm following commands that should make it work word-for-word but no the video format is not real and windows will not recognize it and execute me at the stake for even trying to make this sad excuse of an mp4 or something idk.

### May 30, 2024 (HW)

FFmpeg is working on windows, but actually I think? This means we should be able to stitch together images into videos, which should allow us to also add audio on top of that if I'm not mistaken.

### May 30, 2024

See last commit/push message

### May 31, 2024 (HW)

FFmpeg is not working on windows, in fact. For some reason, the exact same command that works on ubuntu / marge creates an mp4 on windows that just isn't recognized on windows (the mp4 made on ubuntu works though), so I'm kind of just being stupid and might have to just download ffmpeg on Kali and pretend like I know how ffmpeg works on Linux at least (so lossy conversion checking is TBD)

### May 31, 2024

I continue my prolongued battle against ffmpeg but this time I get the power-up that may be AVI

### June 3, 2024 (HW)

I have found out that Windows just doesn't want to support .AVI, even after installing the extension to support .AVI in the Microsoft Store... so to VLC media player we go to download a usable video player with a funny traffic cone. Anyways, I'm doing ffmpeg things and we're abt to find out if they worked losslessly.
HOLY SHIT I THINK IT WORKED YES FINALLY WAIT I NEED TO LOG THESE TERMINAL COMMANDS OMG
Turn a .AVI to PNGs: ffmpeg -i video.avi -vf fps=30 image.png
Turn PNGs to a .AVI: ffmpeg -framerate 30 -i image.png -codec copy video.avi
Turn .mp4 to .AVI: ffmpeg -i video.mp4 -vcodec copy -acodec copy video.avi
Further Processing tests must be done to conclude the effectiveness of this but looking good so far with this 1 frame lol
OK so upon those further tests, all the frames are equivalent but... the videos themselves aren't (yipee). This is still a massive step in the right direction.
OK wait interestingly enough, although the ffmpeg cmd to turn .mp4 into .avi gave videos with the same # of bytes in windows/linux, they were not equivalent (byte 8999 is different at the very least).
OK so if mp4 -> v1 -> images1 -> v2 - > images2 -> v3, then v1!=v2!=v2, which sucks, because all the frames are equal and I literally just don't know enough about video formats to figure this out (it is 3 am tbf but I also feel more awake now than I do in most of my classes)
OK SO IVE KINDA FIGURE OUT A WAY TO DO IT (lossless conversion of video->pngs->video)
- video0.mp4 -> video1.avi
- video1.avi -> images1.png
- images1.png -> video2.avi
- video2.avi -> images2.avi
- images2.avi -> video3.avi
- video3.avi -> images3.avi
- images3.avi -> video4.avi
After all that, we have video3.avi == video4.avi... I don't know why it doesn't happen in an earlier iteration but y'know we'll take it and optimize it from here at not literally 3 AM

I'm like really confused but for unrelated reasons but I'm going to mess around with ffmpeg flags to see if I get some cool results.
OK after flag experimentation, I can confirm that I changed no flags but video2 == video3 lol dunno why it didn't work the first time around
So that's cool and all... but what if we just like could get video1 to video2 to work?
I think the issue is that the extra flags that I've used to convert .pngs to .avis are overriding default values, but my .mp4 to .avi cmd has no flags so it does have those default vals that are goofing it a bit (maybe, idk thats just my theory. Maybe conversion from .mp4 to .avi is just much more optimized than .png collection to .avi)
OK so I think that I've figured out that... I don't know what flags to use? Like this somewhat roundabout system works and isn't that bad I guess, but still doesn't feel right (and I can't figure out what flags I need to not make it 30kb)
OK so I realized that mp4 -> frames -> avi doesn't really work either (im guessing that it has something to do with YUV color space vs RGB causing awkwardness)
I think that turning a video into an avi and then avi to avi and then to editable frames into another post avi is working so ill use it
Ok... don't know what I did exactly but now it takes 4 videos again... s i c k
Also js to confirm... idt we can convert back to mp4
I lost the plot a little so here are the cmds we need:



Turn .mp4 to .AVI: ffmpeg -i video.mp4 -vcodec copy -acodec copy video.avi
Turn a .AVI to PNGs: ffmpeg -i video.avi -vf fps=30 image.png
Turn PNGs to a .AVI: ffmpeg -framerate 30 -i image.png -codec copy video.avi
