convertImage: 
	ffmpeg -i $(ARGS) ./GifEncoding/data/image.tif
	ffmpeg -i <frames>.tif -c:v ffv1 <video>.avi