int take = 26;
String youAre = "";
PVector[] headPoints = new PVector[5000];
ArrayList<PVector> headList = new ArrayList();
ArrayList<PVector> neckList = new ArrayList();
ArrayList<PVector> leftShoulderList = new ArrayList();
ArrayList<PVector> leftElbowList = new ArrayList();
ArrayList<PVector> leftHandList = new ArrayList();
ArrayList<PVector> rightShoulderList = new ArrayList();
ArrayList<PVector> rightElbowList = new ArrayList();
ArrayList<PVector> rightHandList = new ArrayList();
ArrayList<PVector> torsoList = new ArrayList();
ArrayList<PVector> leftHipList = new ArrayList();
ArrayList<PVector> leftKneeList = new ArrayList();
ArrayList<PVector> leftFootList = new ArrayList();
ArrayList<PVector> rightHipList = new ArrayList();
ArrayList<PVector> rightKneeList = new ArrayList();
ArrayList<PVector> rightFootList = new ArrayList();
boolean record;
float rotation;

/*void keyPressed() {
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
*/
