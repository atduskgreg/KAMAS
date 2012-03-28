import fsm.*; //finite state machine library - to be implemented later on
import processing.net.*;
import SimpleOpenNI.*;  //middleware to execute skeleton tracking
SimpleOpenNI kinect; //declare kinect object 
import java.lang.Runtime;
import processing.video.*; //to run the intro video

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
  backgroundImage = loadImage("KAMAS_1.jpg");

  size(640, 480); 

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
  
  step1();
  if (step1 == true) {
    step2();

  }
  if (step2 == true) {
    step3();
  }

//  if (step3 == true) {
//    step4();
//  }
  
//  if (step4 == true) {
//    step5();
//  }

}
