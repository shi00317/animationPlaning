float ballX = 320; 
float ballY = 400; 
float ballSpeedX = 0;
float ballSpeedY = 0;   
float ballSize = 13;  
float mass = 10;
float cor = 0.8;
Ball ball1 = new Ball(ballX,ballY,ballSize,ballSpeedX,ballSpeedY,mass,1);
Ball ball2 = new Ball(ballX,ballY,ballSize,ballSpeedX,ballSpeedY,mass,2);
Ball ball3 = new Ball(ballX,ballY,ballSize,ballSpeedX,ballSpeedY,mass,3);

class Ball extends Circle{
  Vec2 v;
  float mass;
  int which;
  public Ball(float centererX, float centererY, float radius, float ballSpeedX, float ballSpeedY,float mass,int which){
   super( centererX,  centererY,  radius);
   this.v = new Vec2(ballSpeedX,ballSpeedY);
   this.mass = mass;
   this.c1 = random(30,140);
   this.which = which;
 }
}

void draw_ball(ArrayList<Ball> ballList){
  pushMatrix();
  //print(ballList.size());
  int needToAdd = 0;
  for(Ball ball:ballList){
    fill(254,188,ball.c1);
    noStroke();
    circle(ball.center.x,ball.center.y,ball.radius*2);
    //print(i);
    //i++;
    if(ball.center.x<300.0){
      needToAdd+=1;
    }
  }
  popMatrix();
  if (ballList.size()==needToAdd && !remainBall.isEmpty()){
    ballList.add(remainBall.pop());    
  }

}


void ballPhysic(ArrayList<Ball> ballList,float dt){
  for(Ball ball:ballList){
    for(Ball b:ballList){
      if(ball.which !=b.which){
        ballBall(ball,b);
      }
    }
    ball_line_collisionL(ball);
    ball_line_collisionR(ball);

    ballLuncher(ball,luncher);

    ball.v.add(acc.times(dt));
    ball.center.add(ball.v.times(dt)); 
    ball.center.add(acc.times(dt*dt));
    for (Shape i: obs1){
     if (i.id==0){
       ballCircle(ball,(Circle)i);
     }else if (i.id==1){
       ballLine(ball,(Lines)i);
     }     
    }
    squzze();
    //if(ball.center.x>300){
    //  release(ball);
    //}
    //lunchBack();
  }

}

void ballCircle(Ball b, Circle c){
  if (b.center.distanceTo(c.center) < (c.radius+b.radius)){
    file.play();
    score+=100;
    c.c1 = 198;
    c.c2 = 175;
    Vec2 norm = (b.center.minus(c.center)).normalized();
    b.center = c.center.plus(norm.times(c.radius+b.radius).times(1.01));
    Vec2 velocity = norm.times(dot(b.v,norm));
    b.v.subtract(velocity.times(1 + cor));
  }

}

void ballLine(Ball b, Lines l){
  Shape temp1 = b;
  Shape temp2 = l;
  if (circleLines(temp1,temp2)){
    Vec2 location;
    Vec2 dir = l.p2.minus(l.p1);
    Vec2 dirNorm = dir.normalized();
    Vec2 norm = new Vec2(-dirNorm.y, dirNorm.x);
    float target = dot(b.center.minus(l.p1), dirNorm);
    if (target < 0) {
      location = l.p1;
    } else if (target > dir.length()) {
      location = l.p2;
    } else {
      location = l.p1.plus(dirNorm.times(target));
    }
    Vec2 ballGoTo = b.center.minus(location).normalized();
    b.center = location.plus(ballGoTo.times(b.radius));
    Vec2 velocity = norm.times(dot(b.v, norm));
    b.v.subtract(velocity.times(1 + cor));
  }

}

void updateCenter(Ball ball1, Ball ball2, Vec2 norm){
    Vec2 norm1 = norm.times(ball1.radius + ball2.radius);    
    ball1.center = ball2.center.plus(norm1.times(1));
    ball2.center = ball1.center.plus(norm1.times(-1));

}
