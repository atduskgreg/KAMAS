
boolean drawStep1 = false;
boolean drawStep2 = false;
boolean drawStep3 = false;
boolean drawStep4 = false;
boolean drawStep5 = false;
boolean drawStep6 = false;

boolean checkSection1 = true;
boolean checkSection2 = false;
boolean checkSection3 = false;

Date d = new Date(); //for saving the csv file

//ArrayList aimsAnswersList = new ArrayList(); //all answers are loaded into here

Movie step6intro;
Movie step7intro;
Movie step8intro;
Movie step9intro;
Movie currentMovie;

int[] userMap; //map user points to create user subtraction

PVector prevRightHandLocation;
PVector prevLeftHandLocation;
PVector prevRightKneeLocation;
PVector prevLeftKneeLocation;

boolean clickOK = false;

float finalScore = 0;
float previousFinalScore = 0;

float testTime = 10000;
float timeLeft = 0;
float startTime = 0;

//no calibration
boolean autoCalib=true;

ArrayList answers; //arraylist
int answerCounter = -1;


//attract
void drawStep1() {
  image(backgroundImage1, 0, 0, width, height);
}

//execute
void checkStep1() {
  //if the user has clicked over the Continue button area, move to the next step
  if (mouseX > 380 && mouseY > 300) {
    drawStep2 = true; //user has completed step1
  }
}
//DENTURES? Y/N - attract
void drawStep2() {
  image(backgroundImage2, 0, 0, width, height);

  if (key == 'a' || key == 'A') {
    image(backgroundImage2a, 0, 0, width, height);
  }
  else if (key == 'b' || key == 'B') {
    image(backgroundImage2b, 0, 0, width, height);
  }
  else if (key == 'c' || key == 'C') {
    image(backgroundImage2c, 0, 0, width, height);
  }
}

//execute
void checkStep2() {
  if (key == 'a' || key == 'A') {
    if (mouseX > 380 && mouseY > 300) {
      drawStep3 = true; //step 3 has further denture questions
    }
  }
  else if (key == 'b' || key == 'B') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      //drawStep3 == true;
      answers.add("");
      answerCounter++; //advance this and extra time since step 3 is getting skipped
      drawStep4 = true;
    }
  }
  else if (key == 'c' || key == 'C') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      //drawStep3 == true;
      answers.add("");
      answerCounter++; //advance this and extra time since step 3 is getting skipped
      drawStep4 = true;
    }
  }
}//end check step 2

//DENTURE FOLLOW UP - attract
void drawStep3() {
  image(backgroundImage3, 0, 0, width, height);
  if (key == 'a' || key == 'A') {
    image(backgroundImage3a, 0, 0, width, height);
  }
  else if ( key == 'b' || key == 'B') {
    image(backgroundImage3b, 0, 0, width, height);
  }
}  

//execute
void checkStep3() {
  if (key == 'a' || key == 'A') {
    if (mouseX > 380 && mouseY > 300) {
      drawStep4 = true;
    }
  }
  else if ( key == 'b' || key == 'B') {
    if (mouseX > 380 && mouseY > 300) {
      drawStep4 = true;
    }
  }
}//end check step 3

//TEETH - attract 
void drawStep4() {
  image(backgroundImage4, 0, 0, width, height);
  if (key == 'a' || key == 'A') {
    image(backgroundImage4a, 0, 0, width, height);
  }
  else if ( key == 'b' || key == 'B') {
    image(backgroundImage4b, 0, 0, width, height);
  }
}//end step 4

//execute
void checkStep4() {
  if (key == 'a' || key == 'A') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep5 = true;
    }
  }
  else if ( key == 'b' || key == 'B') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep5 = true;
    }
  }
}//end check step 4

//BODY MOVEMENT - attract
void drawStep5() {
  image(backgroundImage5, 0, 0, width, height);
  if (key == 'a' || key == 'A') {
    image(backgroundImage5a, 0, 0, width, height);
  }
  else if ( key == 'b' || key == 'B') {
    image(backgroundImage5b, 0, 0, width, height);
  }
  else if ( key == 'c' || key == 'C') {
    image(backgroundImage5c, 0, 0, width, height);
  }
  else if ( key == 'd' || key == 'D') {
    image(backgroundImage5d, 0, 0, width, height);
  }
  else if ( key == 'e' || key == 'E') {
    image(backgroundImage5e, 0, 0, width, height);
  }
}//end step 5

void checkStep5() {
  if (key == 'a' || key == 'A') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep6 = true;
    }
  }
  else if ( key == 'b' || key == 'B') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep6 = true;
    }
  }

  else if ( key == 'c' || key == 'C') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep6 = true;
    }
  }

  else if ( key == 'd' || key == 'D') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep6 = true;
    }
  }

  else if ( key == 'e' || key == 'E') {
    if (mouseX > 380 && mouseY > 300) {
      //skip step 3 since it pertains to wearing dentures and the patient doesn't have any in their mouth
      drawStep6 = true;

      println("END");
    }
  }
}//end check step 5 

//************************questions 1-3 answer logger*************************

void checkSection1() {

  if (key == 'a' || key == 'A' || key == 'b' || key == 'B' || key == 'c' || key == 'C' || key == 'd' || key == 'D' || key == 'e' || key == 'E') {
      answers.add("" + key);
      answerCounter++; //add to the answer counter
//      if (answers.size() > 0) {
//      String q1 = (String)answers.get(answerCounter);
      println("answer counter" + answerCounter);
      println(answers + "key" + key);
//      }
      //if the answer counter has reached max, then load step 6 (step 4 in AIMS)
      if (answers.size() == 4) {
        println(answers.size());
        println("answer counter should be 4" + answerCounter);
        checkSection1 = false; 
        checkSection2 = true;

        //String q1 = (String)answers.get(0);
        String q2 = (String)answers.get(0);
        String q3 = (String)answers.get(1);
        String q4 = (String)answers.get(2);
        String q5 = (String)answers.get(3);

        String[] csv = new String[1];
        csv[0] = q2 + "," + q3 + "," + q4 + "," + q5;

        println(d.toString());
        saveStrings("Test" + d + ".txt", csv); //save all answers into a text file
        println("ANSWERS SAVED!");
      }
    
  }//key pressed
}//end check section 1

//questions 4-12
void checkSection2() {
  /*if (finalScore != previousFinalScore) { //if the value of the final score is different, that means a new step has been completed
   answers.add = (finalScore); //the answer is the finalScore from each test
   answerCounter++; //add to the answer counter
   
   //if the answer counter has reached max, then load the finish/submit screen
   if (answerCounter == 22) { //steps 4-12 including repeat steps
   checkSection1 = false; 
   checkSection2 = false; 
   checkSection3 = true;
   }
   }*/
}//end of check section 2

//save answers
void checkSection3() {
  //saveStrings("Test" + date + ".txt", aimsAnswers); //save all answers into a text file
  //println("ANSWERS SAVED!");
}

//MOTION TRACKING - execute step 4 of AIMS - hands on knees
void drawStep6() {
  background(255);
  kinect.update(); 
  //PImage rgbImage = kinect.rgbImage();
  //if (millis() > 4000 && millis() < 53000) { //length of the intro
  //image(step6intro, 0, 0, width, height);
  //}
  //else {
  //image(rgbImage, 0, 0, width, height);
  //set up the kinect part
  //scale(2);
  //image(depthImage, 0, 0);
  //image(rgbImage, 0, 0);
  //image(kinect.depthImage(), 0, 0);

  IntVector userList = new IntVector(); 
  kinect.getUsers(userList);

  if (userList.size() > 0) { 
    int userId = userList.get(0);

    if (kinect.isTrackingSkeleton(userId)) { 

      fill(0, 130, 70); //green
      text("CALIBRATED! ");
      println("YUP CALIBRATED SHOWED");
    }

    //      //display the user's image
    //      //prepare the color pixels
    //      rgbImage.loadPixels();
    //      loadPixels();
    //      userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
    //      for (int i = 0; i < userMap.length; i++) {
    //        //if the pixel is part of the user
    //        if (userMap[i] !=0) {
    //          //set the sketch pixel to the color pixel
    //          pixels[i] = rgbImage.pixels[i];
    //        }
    //      }//end of pixel for loop
    //      updatePixels();

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
      finalScore = previousFinalScore; //reset the final score for the next step
      //}
    } // end TrackingSkeleton
  } // end userDataAvaialable
  finalScore = 0;
} //end draw step 6

//MOTION TRACKING - execute step 5 of AIMS - hands hanging unsupported
void drawStep7() {
  kinect.update(); 
  PImage rgbImage = kinect.rgbImage();
  if (millis() > 4000 && millis() < 53000) { //length of the intro
    image(step7intro, 0, 0, width, height);
  }
  else {
    image(rgbImage, 0, 0, width, height);
    //set up the kinect part
    //scale(2);
    //image(depthImage, 0, 0);
    //image(rgbImage, 0, 0);
    //image(kinect.depthImage(), 0, 0);

    IntVector userList = new IntVector(); 
    kinect.getUsers(userList);

    if (userList.size() > 0) { 
      int userId = userList.get(0);

      if (kinect.isTrackingSkeleton(userId)) { 
        //if (testRunning == false) {
        //scale(2);
        fill(0, 130, 70); //green
        text("CALIBRATED! ");
        println("YUP CALIBRATED SHOWED");
        //testRunning = true; //don't display "Calibrated" on the screen anymore
      }

      //      //display the user's image
      //      //prepare the color pixels
      //      rgbImage.loadPixels();
      //      loadPixels();
      //      userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
      //      for (int i = 0; i < userMap.length; i++) {
      //        //if the pixel is part of the user
      //        if (userMap[i] !=0) {
      //          //set the sketch pixel to the color pixel
      //          pixels[i] = rgbImage.pixels[i];
      //        }
      //      }//end of pixel for loop
      //      updatePixels();

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
        finalScore = previousFinalScore; //reset the final score for the next step
      }
    } // end TrackingSkeleton
  } // end userDataAvaialable
} //end draw step 7

//face tracking with tongue in mouth
void drawStep8() {
  if (millis() > 4000 && millis() < 53000) { //length of the intro
    image(step8intro, 0, 0, width, height);
  }


  else if (found) {
    stroke(0);
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    noFill();
    // ellipse(0,0, 3,3);
    ellipse(-20, eyeLeftHeight * -9, 20, 7);
    ellipse(20, eyeRightHeight * -9, 20, 7);
    ellipse(0, 20, mouthWidth* 3, mouthHeight * 3);
    ellipse(-5, nostrilHeight * -1, 7, 3);
    ellipse(5, nostrilHeight * -1, 7, 3);
    rectMode(CENTER);
    fill(0);
    rect(-20, leftEyebrowHeight * -5, 25, 5);
    rect(20, rightEyebrowHeight * -5, 25, 5);
  }
} //end draw step 8

void drawSkeleton(int userId) { 
  //  stroke(0); 
  //  strokeWeight(2);
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT); 
  //  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);
  //
  //  noStroke();

  fill(255, 0, 0); 
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

//FACE TRACKING STUFF

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyebrowLeftReceived(float h) {
  println("eyebrow left: " + h);
  leftEyebrowHeight = h;
}

public void eyebrowRightReceived(float h) {
  println("eyebrow right: " + h);
  rightEyebrowHeight = h;
}

public void eyeLeftReceived(float h) {
  println("eye left: " + h);
  eyeLeftHeight = h;
}

public void eyeRightReceived(float h) {
  println("eye right: " + h);
  eyeRightHeight = h;
}

public void jawReceived(float h) {
  println("jaw: " + h);
}

public void nostrilsReceived(float h) {
  println("nostrils: " + h);
  nostrilHeight = h;
}

public void found(int i) {
  println("found: " + i); // 1 == found, 0 == not found
  found = i == 1;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition = new PVector(x, y);
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    println("UNPLUGGED: " + theOscMessage);
  }
}

