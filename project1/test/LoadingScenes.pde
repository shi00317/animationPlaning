import processing.sound.*;
String myString = "Please select theme ... \n\n theme1 type 1\n\n or \n\n theme2 type 2";
String select = "0";
boolean isPaused = true;
SoundFile file;
Vec2 acc = new Vec2(0,400);
ArrayList<Ball> ballList = new ArrayList<Ball>();
LinkedList<Ball> remainBall = new LinkedList<Ball>();
void setup() {
  size(500, 550,P3D); 
  strokeWeight(4);
  selectInput("Select a file to process:", "fileSelected");
  theme1_table = loadImage("img/theme1.jpg");
  file = new SoundFile(this,"sound/ding.wav");
  startColor = color(255, 0, 0); 
  targetColor = color(0, 0, 255);
  ballList.add(ball1);
  remainBall.push(ball3);
  remainBall.push(ball2);
  firework();

}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    obs1 = loadObs(selection.getAbsolutePath());
    println("User selected " + selection.getAbsolutePath());
    
    isPaused = false;
  }
}


void draw() {
  
  if (!isPaused){
    specular(120, 120, 180);  
    ambientLight(90,90,90);  
    lightSpecular(255,255,255); shininess(20); 
    directionalLight(200, 200, 200, -1, 1, -1);
    update(1.0/frameRate);
    background(0);
    loadSense(theme1_table);
    draw_score();
    draw_obs1(obs1);
    draw_luncher();
    draw_flipper();
    //for(Ball i:ballList){
      draw_ball(ballList);
    //}
    if(playFire){
      play();
    }
  }
   
}


void update(float dt){
  //if (flipperMoving) {
  //  flipperAngle += flipperRotationSpeed;
  //  flipperAngle = constrain(flipperAngle, 0, PI / 4);
  //} else {
  //  // If not moving, return the flipper to its original position
  //  if (flipperAngle > 0) {
  //    flipperAngle -= flipperRotationSpeed;
  //  }
  //}
  if (score>500){
    playFire = true;
    
  }
  lerping += 0.01 * lerpingDirection;
  if (lerping > 1.0 || lerping < 0.0) {
    lerpingDirection *= -1;
  }
  if(playFire){
    fireworkPhysic(fireworkList, dt);

  }
  ballPhysic(ballList,dt);
  if (pressZ){
    update_physicsL(dt);

  }
  if (pressM){
    update_physicsR(dt);

  }

}

boolean pressZ = false;
boolean pressM = false;

void keyPressed() {
  if (key == '1') {
    select="1";
  } else if (key == '2') {
    select="2";
  }else if (key=='r'){
    select="0";
  }
  if (key == 'z') {
    pressZ = true;
  }
  if (key == 'm') {
   pressM = true;
  }
  if (key == ' ') {
    isSpacePressed = true;
    //isSpaceRelease = false;
  }
}

void keyReleased() {
  if (key == 'z') {
    pressZ = false;
    backL();
  }
  if (key == 'm') {
    pressM = false;
    backR();
  }
  if (key == ' ') {
      lunchBack();
      isSpacePressed = false;
//      isSpaceRelease = true;
  }
}
