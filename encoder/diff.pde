void showDiff() {
  if (diffMode==1) {
    image(image1,0,0);
    return;
  }
  for (int i=0;i<image1.width;i++) {
    for (int j=0;j<image1.height;j++) {
      set(i,j,WHITE);
      if (image1.get(i,j)!=image2.get(i,j)&&diffMode==2 ||
          red(image1.get(i,j))!=red(image2.get(i,j))&&diffMode==3 ||
          green(image1.get(i,j))!=green(image2.get(i,j))&&diffMode==4 ||
          blue(image1.get(i,j))!=blue(image2.get(i,j))&&diffMode==0) {
        set(i,j,BLACK);
      }
    }
  }
}

void draw() {
  if (MODE==DIFF) {
    textSize(50);
    textAlign(RIGHT);
    if (diffMode==1) {
      fill(130);
    } else if (diffMode==2) {
      fill(0);
    } else if (diffMode==3) {
      fill(255,0,0);
    } else if (diffMode==4) {
      fill(0,255,0);
    } else if (diffMode==0) {
      fill(0,0,255);
    }
    if (diffMode==1) {
      text("Mode "+diffMode+": Normal Image",1200,600);
    } else if (diffMode==2) {
      text("Mode "+diffMode+": All Differences",1200,600);
    } else if (diffMode==3) {
      text("Mode "+diffMode+": Red Differences",1200,600);
    } else if (diffMode==4) {
      text("Mode "+diffMode+": Green Differences",1200,600);
    } else if (diffMode==0) {
      text("Mode "+(diffMode+5)+": Blue Differences",1200,600);
    }
  }
}

void keyPressed() {
  if (key==' '&&MODE==DIFF) {
    diffMode++;
    diffMode%=5;
    showDiff();
  }
}
