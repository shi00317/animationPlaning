float l1x = 85;
float l1y = 475;
float l2x = 160;
float l2y = 490;
Lines left = new Lines(l1x,l1y,l2x,l2y);

float r1x = 260;
float r1y = 475;
float r2x = 190;
float r2y = 490;
Lines right = new Lines(r1x,r1y,r2x,r2y);
float speedF = 10;

float flipperR = sqrt((190 - 260)^2 + (475- 490)^2);
float thetaL = atan2(490 - 475, 190 - 260);
float thetaR = atan2(490 - 475, 160 - 85);

void draw_flipper(){
   pushMatrix();
   stroke(178,178,178);
   Vec2 tipL = getTipL();
   line(left.p1.x,left.p1.y,tipL.x,tipL.y);
   Vec2 tipR = getTipR(); 
   line(right.p1.x,right.p1.y,tipR.x,tipR.y);
   popMatrix();
}

float max_angle = -0.30;
float angle = 0.30;
float line_length = 70;
float angular_velocity = -5.0;

Vec2 getTipL(){
  // Compute tip as a function of angle and line_length
  Vec2 tip = new Vec2(0,0);
  tip.x = left.p1.x + line_length*cos(angle);
  tip.y = left.p1.y + line_length*sin(angle);
  return tip;
}

Vec2 getTipR(){
  // Compute tip as a function of angle and line_length
  Vec2 tip = new Vec2(0,0);
  tip.x = right.p1.x + line_length*cos(angleR);
  tip.y = right.p1.y + line_length*sin(angleR);
  return tip;
}

void update_physicsL(float dt){
  // Update line segment
  if (angle>max_angle){
    angle += angular_velocity*dt;
  }
}

float max_angleR = 3.4;
float angleR = 2.85;
float angular_velocityR = 5.0;

void update_physicsR(float dt){
  // Update line segment
  if (angleR<max_angleR){
    println(angleR);
    angleR += angular_velocityR*dt;
  }
}


void backL(){
  //left.p2.x = 160;
  //left.p2.y = 490;
  angle = 0.3;


}

void backR(){
  angleR = 2.85;


}

void ball_line_collisionL(Ball ball) {
  float restitution = 0.8;

  // Find the closest point on the line segment
  Vec2 tip = getTipL();
  Vec2 dir = tip.minus(left.p1);
  Vec2 dir_norm = dir.normalized();
  float proj = dot(ball.center.minus(left.p1), dir_norm);
  Vec2 closest;
  if (proj < 0) {
    closest = left.p1;
  } else if (proj > dir.length()) {
    closest = tip;
  } else {
    closest = left.p1.plus(dir_norm.times(proj));
  }

  // Check if the ball is close enough to the line segment
  dir = ball.center.minus(closest);
  float dist = dir.length();
  if (dist > ball.radius) {
    return;
  }
  dir.mul(1.0/dist); // Normalize dir

  // Move the ball outside the line segment
  ball.center = closest.plus(dir.times(ball.radius));

  // Velocity of the flipper at the point of contact
  Vec2 radius = closest.minus(left.p1);
  Vec2 surfaceVel = new Vec2(0,0);
  if (radius.length() > 0) {
    surfaceVel = (new Vec2(-radius.y, radius.x)).normalized().times(angular_velocity * radius.length());
  }

  // Calculate the new ball velocity
  float v_ball = dot(ball.v,dir);
  float v_flip = dot(surfaceVel,dir);
  float m1 = 1;
  float m2 = 10; // Give the flipper a big mass compared to the ball [TODO: Should be infinite ... you should update it!]

  // Conservation of momentum
  float new_v = (m1 * v_ball + m2 * v_flip - m2 * (v_ball - v_flip) * restitution) / (m1 + m2);

  ball.v.add(dir.times(new_v - v_ball));
}


void ball_line_collisionR(Ball ball) {
  float restitution = 0.8;

  // Find the closest point on the line segment
  Vec2 tip = getTipR();
  Vec2 dir = tip.minus(right.p1);
  Vec2 dir_norm = dir.normalized();
  float proj = dot(ball.center.minus(right.p1), dir_norm);
  Vec2 closest;
  if (proj < 0) {
    closest = right.p1;
  } else if (proj > dir.length()) {
    closest = tip;
  } else {
    closest = right.p1.plus(dir_norm.times(proj));
  }

  // Check if the ball is close enough to the line segment
  dir = ball.center.minus(closest);
  float dist = dir.length();
  if (dist > ball.radius) {
    return;
  }
  dir.mul(1.0/dist); // Normalize dir

  // Move the ball outside the line segment
  ball.center = closest.plus(dir.times(ball.radius));

  // Velocity of the flipper at the point of contact
  Vec2 radius = closest.minus(right.p1);
  Vec2 surfaceVel = new Vec2(0,0);
  if (radius.length() > 0) {
    surfaceVel = (new Vec2(-radius.y, radius.x)).normalized().times(-angular_velocity * radius.length());
  }

  // Calculate the new ball velocity
  float v_ball = dot(ball.v,dir);
  float v_flip = dot(surfaceVel,dir);
  float m1 = 1;
  float m2 = 2; 

  // Conservation of momentum
  float new_v = (m1 * v_ball + m2 * v_flip - m2 * (v_ball - v_flip) * restitution) / (m1 + m2);

  ball.v.add(dir.times(new_v - v_ball));
}
