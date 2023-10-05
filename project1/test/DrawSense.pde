PImage theme1_table;  // Declare a variable to store the background image
ArrayList<Shape> obs1;

//sense1 color
color startColor;
color targetColor;
float lerping = 0.01;
float lerpingDirection = 1.0;
int circleLight1 = 79;
int circleLight2 = 47;
PImage texture;

void loadSense(PImage backgroundImage){
  image(backgroundImage, 0, 0, 350, 500);
}


void draw_obs1(ArrayList<Shape> obs){
   for(Shape i : obs){
     if (i.id==0){
       //pushMatrix();
       Circle cur = (Circle)i;
       fill(cur.c1,cur.c2,179);  
       circle(cur.center.x, cur.center.y, cur.radius*2); 
       cur.c1 = 79;
       cur.c2 = 47;
       //popMatrix();
       
     }else if (i.id==1){
       pushMatrix();
       Lines cur = (Lines)i;
       stroke(lerpColor(startColor, targetColor, lerping));   
       //noStroke();    
       line(cur.p1.x,cur.p1.y,cur.p2.x,cur.p2.y);
       popMatrix();
     
     }else{
       Box cur = (Box)i;
       fill(254,188,46);  
       noStroke();       
       rect(cur.center.x, cur.center.y, cur.width, cur.height); 
     }
     
   }
  
}
