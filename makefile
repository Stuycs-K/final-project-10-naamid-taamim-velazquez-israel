<<<<<<< HEAD
convertImage: 
	ffmpeg -i $(ARGS) ./GifEncoding/data/image.tif
	ffmpeg -i <frames>.tif -c:v ffv1 <video>.avi
=======
run:
	processing-java --sketch=$(PWD)/GifEncoding --run $(ARGS)
>>>>>>> aa95502db446dca1ddc558b6ea241cafc6e8bb90
