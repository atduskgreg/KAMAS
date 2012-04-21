import fsm.*; //finite state machine library - to be implemented later on
import processing.net.*;
import SimpleOpenNI.*;  //middleware to execute skeleton tracking
SimpleOpenNI kinect; //declare kinect object 
import java.lang.Runtime;
import processing.video.*; //to run the intro video
import oscP5.*;

//face-tracking stuff
OscP5 oscP5;

PVector posePosition;
boolean found;
float eyeLeftHeight;
float eyeRightHeight;
float mouthHeight;
float mouthWidth;
float nostrilHeight;
float leftEyebrowHeight;
float rightEyebrowHeight;

float poseScale;

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
  frameRate(30);
  //step6intro = new Movie(this, "step6intro.MOV");
  //step7intro = new Movie(this, "step7intro.MOV");
  //step8intro = new Movie(this, "step8intro.MOV");
  //step9intro = new Movie(this, "step9intro.MOV");
  //intro.play(); //play the movie once
  //outro.loop();

  //currentMovie = step6intro;

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

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");
  
  answers = new ArrayList(); //create empty arraylist
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read(); //plays the movie once
}

void draw() { 
  if (checkSection1 == true) {
    //checkSection1();
    //println("section 1 checked");
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
  }//end check section 1
  if (checkSection2 == true) {
    if (drawStep6 == true) {
      drawStep6();
    }
  }//checkSection2()
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
  if (checkSection1 == true) {
    checkSection1();
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
  }//checkSection1()
}//end keypressed

