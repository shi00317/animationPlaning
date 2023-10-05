int score = 0;
int scoreBoardX = 360;
int scoreBoardY = 50;
boolean playFire = false;
ArrayList<Ball> fireworkList = new ArrayList();

void draw_score(){
  fill(0, 0, 0);  
  noStroke();       
  rect(scoreBoardX, scoreBoardY, 120, 70); 
  
  textSize(15);    
  fill(255);        
  text("Current Score: "+score, scoreBoardX+2, scoreBoardY+30); 
  
}

void firework(){
  for (int i=0;i<100;i++){
    Ball a = new Ball(125.0, 260.0,2.0,random(30,90),random(-400,-350),5,0);
    Ball b = new Ball(225.0, 260.0,2.0,random(30,90),random(-400,-350),5,0);
    a.c1 = random(0,255);
    a.c2 = random(0,255);
    b.c1 = random(0,255);
    b.c2 = random(0,255);
    
    fireworkList.add(a);
    fireworkList.add(b);
  }
  
}

void play(){
  pushMatrix();
  
  for(Ball i : fireworkList){
    fill(i.c1,i.c2,46);
    noStroke();
    circle(i.center.x,i.center.y,i.radius*2);
  }
  popMatrix();
}

void fireworkPhysic(ArrayList<Ball> fireworkList,float dt){
  for(Ball ball1:fireworkList){
    ball1.v.add(acc.times(dt));
    ball1.center.add(ball1.v.times(dt)); 
    ball1.center.add(acc.times(dt*dt));
  } 

}
