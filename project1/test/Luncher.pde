float luncher1x = 300;
float luncher1y = 410;
float luncher2x = 345;
float luncher2y = 410;
float tempY = 410;
Lines luncher = new Lines(luncher1x,luncher1y,luncher2x,luncher2y);
boolean isSpacePressed = false;
boolean isSpaceRelease = false;

float pressedStart = -1;
float pressedEnd = -1;
float springK = 100;

void draw_luncher(){
   stroke(178,178,178);   
   //noStroke();
   line(luncher.p1.x,luncher.p1.y,luncher.p2.x,luncher.p2.y);

}

void squzze(){
  if(isSpacePressed){
    if (luncher.p1.y<=430){
      luncher.p1.y+=1;
      luncher.p2.y+=1;
   }
  }

}

void release(Ball ball){
  //println(isSpaceRelease);
  //if(isSpaceRelease){
      //println("doaskdoaskodkaskoksaodkasoaskdoaks \n sadjskajdasjlksa");

    //println(ball.center.x);
    lunching(ball);
    luncher.p1.y = tempY;
    luncher.p2.y = tempY;
  //}
}

void lunchBack(){
  //if(isSpaceRelease){
    for(Ball b: ballList){
      if(b.center.x>300){
        lunching(b);
      }
    
    }
    luncher.p1.y = tempY;
    luncher.p2.y = tempY;
  //}

}


void lunching(Ball ball){
  println(ball.v.y);

  Float force = (luncher.p1.y-tempY)*springK;
  Vec2 newForce = new Vec2(0,force);
  //print(luncher.p1.y-tempY);
  ball.v.add(newForce);
  println(ball.v.y);
}


void ballLuncher(Ball b, Lines l){
  ballLine(b,l);
}
