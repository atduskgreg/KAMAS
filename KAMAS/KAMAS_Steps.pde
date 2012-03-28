boolean step1 = false;
boolean step2 = false;
boolean step3 = false;

ArrayList aimsAnswersList = new ArrayList();

Movie intro;
Movie outro;
Movie currentMovie;

int[] userMap; //map user points to create user subtraction
PImage backgroundImage; //background image

PVector prevRightHandLocation;
PVector prevLeftHandLocation;
PVector prevRightKneeLocation;
PVector prevLeftKneeLocation;

boolean clickOK = false;

int r = 255;
int g = 255;
int b = 255;

float finalScore = 0;

float testTime = 10000;
float timeLeft = 0;
float startTime = 0;

//no calibration
boolean autoCalib=true;

void step1() {
  //load the background image
  backgroundImage = loadImage("KAMAS_1.jpg");
  image(backgroundImage, 0, 0, width, height);
  //if the user has clicked over the Continue button area, move to the next step
  if (mousePressed == true && mouseX > 380 && mouseY > 300) {
    step1 = true; //user has completed step1
  }
}

void step2() {
  //load the background image
  backgroundImage = loadImage("KAMAS_2.jpg");
  image(backgroundImage, 0, 0, width, height);

  String[] aimsAnswers = new String[aimsAnswersList.size()];
  for (int i = 0; i < aimsAnswersList.size(); i++) {
    aimsAnswersList.get(i);
    //WHY IS IT STOPPING HERE????
    println("step2 be runnin");

    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        println("A");
        //load the background image
        backgroundImage = loadImage("KAMAS_2a.jpg");
        image(backgroundImage, 0, 0, width, height);
        //add 'a' to the string for step2
        aimsAnswers[i] = "step2" + 'a';
        clickOK = true;
      }

      else if (key == 'b' || key == 'B') {
        //load the background image
        backgroundImage = loadImage("KAMAS_2b.jpg");
        image(backgroundImage, 0, 0, width, height);
        //add 'b' to the string for step2
        aimsAnswers[i] = "step2" + 'b';
        clickOK = true;
      }

      else if (key == 'c' || key == 'C') {
        //load the background image
        backgroundImage = loadImage("KAMAS_2c.jpg");
        image(backgroundImage, 0, 0, width, height);
        //add 'c' to the string for step2
        aimsAnswers[i] = "step2" + 'c';
        clickOK = true;
      }
    }//keypressed
  }//for loop
  if (clickOK == true) {
    step2 = true;
  }
  saveStrings("testResults" + ".txt", aimsAnswers);
}//step2

void step3() {
  clickOK = false;
  //load the background image
  backgroundImage = loadImage("KAMAS_3.jpg");
  image(backgroundImage, 0, 0, width, height);
}  

void step4() {
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
        //if (testRunning == false) {
        scale(2);
        fill(0, 130, 70); //green
        text("CALIBRATED! ");
        println("YUP CALIBRATED SHOWED");
        //testRunning = true; //don't display "Calibrated" on the screen anymore
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
//}


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

