import fsm.*;
import processing.net.*;
import SimpleOpenNI.*;  //middleware to execute skeleton tracking
SimpleOpenNI kinect;
import java.lang.Runtime;
import processing.video.*; //to run the intro video

Movie intro;
Movie outro;
Movie currentMovie;

PVector prevRightHandLocation;
PVector prevLeftHandLocation;
PVector prevRightKneeLocation;
PVector prevLeftKneeLocation;


int r = 255;
int g = 255;
int b = 255;

float finalScore = 0;

float testTime = 10000;
float timeLeft = 0;
float startTime = 0;

boolean testRunning = false;

void setup() { 
  intro = new Movie(this, "KAMAS_intro.MOV");
  //outro = new Movie(this, "KAMAS_outro");
  intro.play(); //play the movie once
  //outro.loop();

  //currentMovie = intro;

  kinect = new SimpleOpenNI(this); //create kinect object
  kinect.enableDepth(); //enable the depth image
  kinect.enableRGB(); //display color video feed of user rather than depth image
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  size(1280, 960); 


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
  if (millis() < 48000) { //length of the intro
    image(intro, 640, 480);
  }
  else {
    //set up the kinect part
    kinect.update(); 
    PImage rgbImage = kinect.rgbImage();
    //image(depthImage, 0, 0);
    image(rgbImage, 0, 0);
    //image(kinect.depthImage(), 0, 0);

    IntVector userList = new IntVector(); 
    kinect.getUsers(userList);

    if (userList.size() > 0) { 
      int userId = userList.get(0);

      if (kinect.isTrackingSkeleton(userId)) { 
        if (testRunning == false) {
          scale(2);
          fill(0, 130, 70); //green
          text("CALIBRATED! ");
          println("YUP CALIBRATED SHOWED");
          testRunning = true; //don't display "Calibrated" on the screen anymore
        }
        //millis() start after calibration has happened
        if (startTime == 0) {
          startTime = millis();
          //startTime = millis();
          println("START TIME" + startTime);
        }

        drawSkeleton(userId);

        // make a vector to store the right hand
        PVector rightHandLocation = new PVector();
        // put the position of the left hand into that vector
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, rightHandLocation); 
        // make a vector to store the right hand
        PVector leftHandLocation = new PVector();
        // put the position of the left hand into that vector
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, leftHandLocation); 
        // make a vector to store the right hand
        PVector rightKneeLocation = new PVector();
        // put the position of the left hand into that vector
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, rightKneeLocation); 
        // make a vector to store the right hand
        PVector leftKneeLocation = new PVector();
        // put the position of the left hand into that vector
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, leftKneeLocation); 


        //figure out the distance between the current location and previous location to calculate speed
        float currentScore = (rightHandLocation.dist(prevRightHandLocation) + leftHandLocation.dist(prevLeftHandLocation) + rightKneeLocation.dist(prevRightKneeLocation) + leftKneeLocation.dist(prevLeftKneeLocation));

        //float time = millis();

        //add the distance moved to itself 
        if ((millis() - startTime) < 10000) {
          finalScore += currentScore;
        }

        scale(3);
        fill(255, 50, 70);
        text("Total Score: " + finalScore, 10, 10);
        //  println("TOTAL SCORE:" + finalScore);
        //set the current location as the previous location (i.e. reset)
        prevRightHandLocation = rightHandLocation;
        prevLeftHandLocation = leftHandLocation;
        prevRightKneeLocation = rightKneeLocation;
        prevLeftKneeLocation = leftKneeLocation;

        timeLeft = testTime - (millis() - startTime);


        println("tl: " + timeLeft + " st: " + startTime + " m: " + millis());


        if ((millis() - startTime) < testTime) {
          fill(200, 30, 255);
          //scale(2);
          text("Time left:" + timeLeft, 0, 20);
          //text("elapsed:" + (millis() - startTime), 10, 30);
          fill(200, 30, 255);
          text("Current Score: " + finalScore, 90, 20);
        }
        else {
          fill(5, 200, 100);
          //scale(2);
          text("Great job!", 15, 50);
          text("Your final score is:" + finalScore, 15, 65);
        }
        //saveFrame("kinect####.png");
      } // end TrackingSkeleton
    } // end userDataAvaialable
  }
}





void drawSkeleton(int userId) { 
  stroke(0); 
  strokeWeight(2);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT); 
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);

  noStroke();

  fill(r, g, b); 
  drawJoint(userId, SimpleOpenNI.SKEL_HEAD); 
  drawJoint(userId, SimpleOpenNI.SKEL_NECK); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW); 
  drawJoint(userId, SimpleOpenNI.SKEL_NECK); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW); 
  drawJoint(userId, SimpleOpenNI.SKEL_TORSO); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT); 
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND); 
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
}

void drawJoint(int userId, int jointID) { 
  PVector joint = new PVector(); 
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint); 
  if (confidence < 0.5) {
    return;
  } 
  PVector convertedJoint = new PVector(); 
  kinect.convertRealWorldToProjective(joint, convertedJoint); 
  ellipse(convertedJoint.x, convertedJoint.y, 20, 20);
}

// user-tracking callbacks! void onNewUser(int userId) {
void onNewUser(int userID) {
  println("start pose detection"); 
  kinect.startPoseDetection("Psi", userID);
}

void onEndCalibration(int userId, boolean successful) { 
  if (successful) {
    println(" User calibrated !!!"); 
    kinect.startTrackingSkeleton(userId);
  } 
  else {
    println(" Failed to calibrate user !!!"); 
    kinect.startPoseDetection("Psi", userId);
  }
}
void onStartPose(String pose, int userId) { 
  println("Started pose for user"); 
  kinect.stopPoseDetection(userId); 
  kinect.requestCalibrationSkeleton(userId, true);
}

