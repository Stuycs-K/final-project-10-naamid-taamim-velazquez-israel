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