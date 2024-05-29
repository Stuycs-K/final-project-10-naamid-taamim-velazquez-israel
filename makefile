
convertPNG:
	@convert $(ARGS) images.png
clean:
	@rm images-* 2> /dev/null || true
run: ./GifEncoding/GifEncoding.pde
	touch tmp.tmp; echo $(ARGS) > tmp.tmp
	sed -E "s/ .*//" tmp.tmp
	rm tmp.tmp
	processing-java --sketch="./GifEncoding/" --run $(ARGS)
