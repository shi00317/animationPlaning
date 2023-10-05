int whichShape(int id){
  //println(id);
  if (0<=id && id<num_circle) return 0;
  else if (id>=num_circle && id<num_box) return 1;
  else return 2;
}

boolean checkCollision(int id1, int id2, Shape item1,Shape item2){
  if (id1==0&&id2==0) return circleCircle(item1,item2);  //done
  if (id1==0&&id2==1) return circleLines(item1,item2);    //done
  if (id1==0&&id2==2) return circleBoxes(item1,item2);    //done
  
  if (id1==1&&id2==1) return lineLines(item1,item2);     //done
  if (id1==1&&id2==2) return lineBoxes(item1,item2);     //done
  
  if (id1==2&&id2==2) return boxesBoxes(item1,item2);   //slow
  return false;
}

boolean circleCircle(Shape item1,Shape item2){

  Circle c1 = (Circle)item1;
  Circle c2 = (Circle)item2;
  float distance = (c1.center).distanceTo(c2.center);
  if (distance<=c1.radius+c2.radius){
    //println(item1.toString(),item2.toString(),distance);
    return true;
  }
  return false;
}

boolean circleLines(Shape item1,Shape item2) {
  
  Circle c = (Circle)item1;
  Lines l = (Lines)item2;
  
  float dx = l.p2.x - l.p1.x;
  float dy = l.p2.y - l.p1.y;
  float t = ((c.center.x - l.p1.x) * dx + (c.center.y - l.p1.y) * dy) / (dx * dx + dy * dy);
  t = constrain(t, 0, 1);
  float closestX = l.p1.x + t * dx;
  float closestY = l.p1.y + t * dy;
  float distX = closestX - c.center.x;
  float distY = closestY - c.center.y;
  float distance = sqrt(distX * distX + distY * distY);
  return distance < c.radius;
}


boolean circleBoxes(Shape item1,Shape item2){
  

  Circle c = (Circle)item1;
  Box b = (Box)item2;
  

  // Calculate the closest point on the box to the circle
  float closestX = constrain(c.center.x, b.center.x - b.width/2, b.center.x + b.width/2);
  float closestY = constrain(c.center.y, b.center.y - b.height/2, b.center.y + b.height/2);

  // Calculate the distance between the circle center and the closest point
  float distance = c.center.distanceTo(new Vec2(closestX,closestY));

  // Collision occurs if the distance is less than or equal to the circle's radius
  return distance <= c.radius;

}


boolean sameSide(Lines l, Vec2 p1, Vec2 p2){

  float cp1 = l.p2.minus(l.p1).cross(p1.minus(l.p1));
  float cp2 = l.p2.minus(l.p1).cross(p2.minus(l.p1));
  return cp1*cp2 >= 0;
}

boolean lineLines(Shape item1,Shape item2){

  Lines l1 = (Lines)item1;  
  Lines l2 = (Lines)item2;
  
  if (sameSide(l1, l2.p1, l2.p2)) return false;
  if (sameSide(l2, l1.p1, l1.p2)) return false;
  return true;
}


boolean boxesBoxes(Shape item1,Shape item2) {
  
  Box b1 = (Box)item1; 
  Box b2 = (Box)item2; 

  float box1MinX = b1.center.x- b1.width/2;
  float box1MinY = b1.center.y- b1.height/2;
  float box1MaxX = b1.center.x + b1.width/2;
  float box1MaxY = b1.center.y + b1.height/2;

  float box2MinX = b2.center.x- b2.width/2;
  float box2MinY = b2.center.y- b2.height/2;
  float box2MaxX = b2.center.x + b2.width/2;
  float box2MaxY = b2.center.y + b2.height/2;

  // Check for collision using early exit
  if (box1MaxX < box2MinX || box1MinX > box2MaxX || box1MaxY < box2MinY || box1MinY > box2MaxY) {
    // Boxes do not overlap
    return false;
  } else {
    // Boxes overlap
    return true;
  }
}
boolean lineBoxes(Shape item1, Shape item2) {

  Lines l = (Lines)item1;
  Box b1 = (Box)item2; 

  float box1MinX = b1.center.x- b1.width/2;
  float box1MinY = b1.center.y- b1.height/2;
  float box1MaxX = b1.center.x + b1.width/2;
  float box1MaxY = b1.center.y + b1.height/2;
  
  Lines top = new Lines(box1MinX,box1MinY,box1MaxX,box1MinY);
  Lines bot = new Lines(box1MinX,box1MaxY,box1MaxX,box1MaxY);
  Lines left = new Lines(box1MinX,box1MinY,box1MinX,box1MaxY);
  Lines right = new Lines(box1MaxX,box1MinY,box1MaxX,box1MaxY);


  return lineLines(l,top) || lineLines(l,bot) || lineLines(l,left) || lineLines(l,right);
}
