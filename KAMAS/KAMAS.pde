import fsm.*; //finite state machine library - to be implemented later on
import processing.net.*;
import SimpleOpenNI.*;  //middleware to execute skeleton tracking
SimpleOpenNI kinect; //declare kinect object 
import java.lang.Runtime;
import processing.video.*; //to run the intro video

PImage backgroundImage1; //background image
PImage backgroundImage2; //background image
PImage backgroundImage2a; //background image
PImage backgroundImage2b; //background image
PImage backgroundImage2c; //background image
PImage backgroundImage3; //background image
PImage backgroundImage3a; //background image
PImage backgroundImage3b; //background image
PImage backgroundImage4; //background image
PImage backgroundImage4a; //background image
PImage backgroundImage4b; //background image
PImage backgroundImage5; //background image
PImage backgroundImage5a; //background image
PImage backgroundImage5b; //background image
PImage backgroundImage5c; //background image
PImage backgroundImage5d; //background image
PImage backgroundImage5e; //background image


void setup() { 

  //intro = new Movie(this, "KAMAS_intro.MOV");
  //outro = new Movie(this, "KAMAS_outro");
  //intro.play(); //play the movie once
  //outro.loop();

  //currentMovie = intro;

  kinect = new SimpleOpenNI(this); //create kinect object
  kinect.enableDepth(); //enable the depth image
  kinect.enableRGB(); //display color video feed of user rather than depth image
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.alternativeViewPointDepthToImage(); //turn on depth color alignment

  //load the background image

    size(640, 480); 
  backgroundImage1 = loadImage("KAMAS_1.jpg");
  backgroundImage2 = loadImage("KAMAS_2.jpg");
  backgroundImage2a = loadImage("KAMAS_2a.jpg");
  backgroundImage2b = loadImage("KAMAS_2b.jpg");
  backgroundImage2c = loadImage("KAMAS_2c.jpg");
  backgroundImage3 = loadImage("KAMAS_3.jpg");
  backgroundImage3a = loadImage("KAMAS_3a.jpg");
  backgroundImage3b = loadImage("KAMAS_3b.jpg");
  backgroundImage4 = loadImage("KAMAS_4.jpg");
  backgroundImage4a = loadImage("KAMAS_4a.jpg");
  backgroundImage4b = loadImage("KAMAS_4b.jpg");
  backgroundImage5 = loadImage("KAMAS_5.jpg");
  backgroundImage5a = loadImage("KAMAS_5a.jpg");
  backgroundImage5b = loadImage("KAMAS_5b.jpg");
  backgroundImage5c = loadImage("KAMAS_5c.jpg");
  backgroundImage5d = loadImage("KAMAS_5d.jpg");
  backgroundImage5e = loadImage("KAMAS_5e.jpg");


  //initialize joint location objects as vectors
  prevRightHandLocation = new PVector(0, 0, 0);
  prevLeftHandLocation = new PVector(0, 0, 0);
  prevRightKneeLocation = new PVector(0, 0, 0);
  prevLeftKneeLocation = new PVector(0, 0, 0);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read(); //plays the movie once
}

void draw() { 
  if (checkSection1 == true) {

    drawStep1();

    if (drawStep2== true) {
      drawStep2();
    }

    if (drawStep3 == true) {
      drawStep3();
    }

    if (drawStep4 == true) {
      drawStep4();
    }

    if (drawStep5 == true) {
      drawStep5();
    }
    //if (step6 == true) {
    //drawStep6();
    //}
  }//end check section 1
}//end draw loop

void mousePressed() {

  checkStep1();

  if (drawStep2 == true) {
    checkStep2();
  }
  if (drawStep3 == true) {
    checkStep3();
  }
  if (drawStep4 == true) {
    checkStep4();
  }
  if (drawStep5 == true) {
    checkStep5();
  }
  //if (drawStep6 == true) {
  //checkStep6();
  //}
}//end mousepressed

void keyPressed() {
  if (drawStep1 == true) {
    checkStep1();
  }
  if (drawStep2 == true) {
    checkStep2();
  }
  if (drawStep3 == true) {
    checkStep3();
  }
  if (drawStep4 == true) {
    checkStep4();
  }
  if (drawStep5 == true) {
    checkStep5();
  }
  //if (drawStep6 == true) {
  //checkStep6();
  //}
}//end keypressed

