// Begin the Vec2 Libraray
//Vector Library
//CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>


class Shape {
    int id;

    public Shape(int id) {
        this.id = id;
    }
}

class Circle extends Shape {
    Vec2 center;
    float radius;

    public Circle(float centerX, float centerY, float radius) {
        super(0); // Circle id is 0
        this.center = new Vec2(centerX, centerY);
        this.radius = radius;
    }
}

class Lines extends Shape {
    Vec2 p1;
    Vec2 p2;

    public Lines(float p1X, float p1Y, float p2X, float p2Y) {
        super(1); // Lines id is 1
        this.p1 = new Vec2(p1X, p1Y);
        this.p2 = new Vec2(p2X, p2Y);
    }
}

class Box extends Shape {
    Vec2 center;
    float width;
    float height;

    public Box(float centerX, float centerY, float width, float height) {
        super(2); // Box id is 2
        this.center = new Vec2(centerX, centerY);
        this.width = width;
        this.height = height;
    }
}




public class Vec2 {
  public float x, y;
  
  public Vec2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public String toString(){
    return "(" + x+ "," + y +")";
  }
  
  public float length(){
    return sqrt(x*x+y*y);
  }
  
  public Vec2 plus(Vec2 rhs){
    return new Vec2(x+rhs.x, y+rhs.y);
  }
  
  public void add(Vec2 rhs){
    x += rhs.x;
    y += rhs.y;
  }
  
  public Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x, y-rhs.y);
  }
  
  public void subtract(Vec2 rhs){
    x -= rhs.x;
    y -= rhs.y;
  }
  
  public Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  public void mul(float rhs){
    x *= rhs;
    y *= rhs;
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y);
    x *= newL/magnitude;
    y *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y);
    x /= magnitude;
    y /= magnitude;
  }
  
  public Vec2 normalized(){
    float magnitude = sqrt(x*x + y*y);
    return new Vec2(x/magnitude, y/magnitude);
  }
  
  public float distanceTo(Vec2 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    return sqrt(dx*dx + dy*dy);
  }
  
  public float cross(Vec2 other) {
    return x * other.y - y * other.x;
  }
}


Vec2 interpolate(Vec2 a, Vec2 b, float t){
  return a.plus((b.minus(a)).times(t));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec2 a, Vec2 b){
  return a.x*b.x + a.y*b.y;
}

Vec2 projAB(Vec2 a, Vec2 b){
  return b.times(a.x*b.x + a.y*b.y);
}
