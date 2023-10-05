Before running scripts, make sure run.pde collisiondetection.pde and vec2.pde are in same fold.
Change the String directoryPath variable in run.pde line 19 in your task path.

1. short description of the approach you took to finding collisions.

In the CollisionDetection library, there are 2 utility function and 6 collision detection function.
For the utility function, 
	int whichShape(int id): it will return what shape of object for current id.
	boolean checkCollision(int id1, int id2, Shape item1,Shape item2): it will return whether two objects are collided or not.

For the collision detection function,
	boolean circleCircle(Shape item1,Shape item2)
	boolean circleLines(Shape item1,Shape item2)
	boolean circleBoxes(Shape item1,Shape item2)
	boolean lineLines(Shape item1,Shape item2)
	boolean boxesBoxes(Shape item1,Shape item2)
	boolean lineBoxes(Shape item1,Shape item2)


2. brief note of any optimizations you used

To optimization the algorithm, I create an abstract class shape and circle, line, box class to extent shape class.
When I read data from txt file, I transfer data from string to correspond shape class which could save lot of time
When comparing them.