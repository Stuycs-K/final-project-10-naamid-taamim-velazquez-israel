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