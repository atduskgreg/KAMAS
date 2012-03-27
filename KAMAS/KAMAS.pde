import fsm.*; //finite state machine library - to be implemented later on
import processing.net.*;
import SimpleOpenNI.*;  //middleware to execute skeleton tracking
SimpleOpenNI kinect; //declare kinect object 
import java.lang.Runtime;
import processing.video.*; //to run the intro video

Movie intro;
Movie outro;
Movie currentMovie;

int[] userMap; //map user points to create user subtraction
PImage backgroundImage; //background image

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

//no calibration
boolean autoCalib=true;

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
  //backgroundImage = loadImage("beach.jpg");

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
  if (millis() > 4000 && millis() < 53000) { //length of the intro
    image(intro, 0, 0, width, height);
  }
  else {
    image(backgroundImage, 0, 0, width, height);
    //set up the kinect part
    //scale(2);
    kinect.update(); 
    PImage rgbImage = kinect.rgbImage();
    //image(depthImage, 0, 0);
    //image(rgbImage, 0, 0);
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

        //display the user's image
        //prepare the color pixels
        rgbImage.loadPixels();
        loadPixels();
        userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
        for (int i = 0; i < userMap.length; i++) {
          //if the pixel is part of the user
          if (userMap[i] !=0) {
            //set the sketch pixel to the color pixel
            pixels[i] = rgbImage.pixels[i];
          }
        }//end of pixel for loop
        updatePixels();

        //millis() start after calibration has happened
        if (startTime == 0) {
          startTime = millis();
          //startTime = millis();
          println("START TIME" + startTime);
        }

        drawSkeleton(userId);
        println("drawing skeleton");

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
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, leftKneeLocation); 


        //figure out the distance between the current location and previous location 
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
          if (key == 't') {
            PrintWriter output;
            output = createWriter("finalScore" + millis() + ".txt"); 
            output.println(finalScore); // Write the coordinate to the file
            output.flush(); // Writes the remaining data to the file
            output.close(); // Finishes the file
          }
        }

        /*        else if (finalScore >= 36000 && finalScore <=80000) {
         fill(5, 200, 100);
         //scale(2);
         
         text("Great job!", 15, 50);
         text("Your final score is:" + "1", 15, 65);
         }
         
         else if (finalScore >= 36000 && finalScore <=80000) {
         fill(5, 200, 100);
         //scale(2);
         
         text("Great job!", 15, 50);
         text("Your final score is:" + "1", 15, 65);
         } */

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

// user-tracking callbacks!
void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");

  if (autoCalib)
    kinect.requestCalibrationSkeleton(userId, true);
  else    
    kinect.startPoseDetection("Psi", userId);
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}


void onEndCalibration(int userId, boolean successful) {
  if (successful) { 
    println("  User calibrated !!!");
    kinect.startTrackingSkeleton(userId);
  } 
  else { 
    println("  Failed to calibrate user !!!");
    kinect.startPoseDetection("Psi", userId);
  }
}
void onStartPose(String pose, int userId) { 
  println("Started pose for user"); 
  kinect.stopPoseDetection(userId); 
  kinect.requestCalibrationSkeleton(userId, true);
}

void keyPressed() {
  if (key == 'r') {
    record = true;
    println("RECORDING");
  } 
  else {
    record = false;
  }
  if (key == 's') {
    record = false; 
    println("RECORDING STOPPED");
  } 
  else {
    record = true;
  }
  // HEAD
  if (keyCode == 49) {
    String[] headPoints = new String[headList.size()];
    for (int i = 0; i < headList.size(); i++) {
      PVector thisVector = headList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      headPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("head_" + take + ".txt", headPoints);
    println("HEAD POINTS SAVED!");
  }
  if (keyCode == 50) {
    String[] neckPoints = new String[neckList.size()];
    for (int i = 0; i < neckList.size(); i++) {
      PVector thisVector = neckList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      neckPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("neck_" + take + ".txt", neckPoints);
    println("NECK POINTS SAVED!");
  }
  if (keyCode == 51) {
    String[] leftShoulderPoints = new String[leftShoulderList.size()];
    for (int i = 0; i < leftShoulderList.size(); i++) {
      PVector thisVector = leftShoulderList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftShoulderPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftShoulder_" + take + ".txt", leftShoulderPoints);
    println("LEFT SHOULDER POINTS SAVED!");
  }  
  if (keyCode == 52) {
    String[] leftElbowPoints = new String[leftElbowList.size()];
    for (int i = 0; i < leftElbowList.size(); i++) {
      PVector thisVector = leftElbowList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftElbowPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftElbow_" + take + ".txt", leftElbowPoints);
    println("LEFT ELBOW POINTS SAVED!");
  }
  if (keyCode == 53) {
    String[] leftHandPoints = new String[leftHandList.size()];
    for (int i = 0; i < leftHandList.size(); i++) {
      PVector thisVector = leftHandList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftHandPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftHand_" + take + ".txt", leftHandPoints);
    println("LEFT HAND POINTS SAVED!");
  }
  if (keyCode == 54) {
    String[] rightShoulderPoints = new String[rightShoulderList.size()];
    for (int i = 0; i < rightShoulderList.size(); i++) {
      PVector thisVector = rightShoulderList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightShoulderPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightShoulder_" + take + ".txt", rightShoulderPoints);
    println("RIGHT SHOULDER POINTS SAVED!");
  }
  if (keyCode == 55) {
    String[] rightElbowPoints = new String[rightElbowList.size()];
    for (int i = 0; i < rightElbowList.size(); i++) {
      PVector thisVector = rightElbowList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightElbowPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightElbow_" + take + ".txt", rightElbowPoints);
    println("RIGHT ELBOW POINTS SAVED!");
  }
  if (keyCode == 56) {
    String[] rightHandPoints = new String[rightHandList.size()];
    for (int i = 0; i < rightHandList.size(); i++) {
      PVector thisVector = rightHandList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightHandPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightHand_" + take + ".txt", rightHandPoints);
    println("RIGHT HAND POINTS SAVED!");
  }
  if (keyCode == 57) {
    String[] torsoPoints = new String[torsoList.size()];
    for (int i = 0; i < torsoList.size(); i++) {
      PVector thisVector = torsoList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      torsoPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("torso_" + take + ".txt", torsoPoints);
    println("TORSO POINTS SAVED!");
  }
  if (keyCode == 48) {
    String[] leftHipPoints = new String[leftHipList.size()];
    for (int i = 0; i < leftHipList.size(); i++) {
      PVector thisVector = leftHipList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftHipPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftHip_" + take + ".txt", leftHipPoints);
    println("LEFT HIP POINTS SAVED!");
  }
  if (key == 'y') {
    String[] leftKneePoints = new String[leftKneeList.size()];
    for (int i = 0; i < leftKneeList.size(); i++) {
      PVector thisVector = leftKneeList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftKneePoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftKnee_" + take + ".txt", leftKneePoints);
    println("LEFT KNEE POINTS SAVED!");
  }
  if (key == 'u') {
    String[] leftFootPoints = new String[leftFootList.size()];
    for (int i = 0; i < leftFootList.size(); i++) {
      PVector thisVector = leftFootList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      leftFootPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("leftFoot_" + take + ".txt", leftFootPoints);
    println("LEFT FOOT POINTS SAVED!");
  }
  if (key == 'i') {
    String[] rightHipPoints = new String[rightHipList.size()];
    for (int i = 0; i < rightHipList.size(); i++) {
      PVector thisVector = rightHipList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightHipPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightHip_" + take + ".txt", rightHipPoints);
    println("RIGHT HIP POINTS SAVED!");
  }
  if (key == 'o') {
    String[] rightKneePoints = new String[rightKneeList.size()];
    for (int i = 0; i < rightKneeList.size(); i++) {
      PVector thisVector = rightKneeList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightKneePoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightKnee_" + take + ".txt", rightKneePoints);
    println("RIGHT KNEE POINTS SAVED!");
  }
  if (key == 'p') {
    String[] rightFootPoints = new String[rightFootList.size()];
    for (int i = 0; i < rightFootList.size(); i++) {
      PVector thisVector = rightFootList.get(i);
      String x = ""+ thisVector.x;
      String y = ""+ thisVector.y;
      String z = ""+ thisVector.z;
      rightFootPoints[i] = x + "," + y + "," + z;
    } 
    saveStrings("rightFoot_" + take + ".txt", rightFootPoints);
    println("RIGHT FOOT POINTS SAVED!");
  }
}

