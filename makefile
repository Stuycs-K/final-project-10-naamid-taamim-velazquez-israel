
convertPNG:
	@convert $(ARGS) images.png
clean:
	@rm images-* 2> /dev/null || true
run: ./GifEncoding/GifEncoding.pde
	@processing-java --sketch="./GifEncoding/" --run $(ARGS)
