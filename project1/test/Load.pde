import java.util.*;

//ArrayList<ArrayList<String>> items;
//ArrayList<Shape> items_Shape;

//ArrayList<Float> list_time = new ArrayList();
//ArrayList<Integer> list_num = new ArrayList();

int num_circle;
int num_box;
int num_line;


ArrayList<Shape> loadObs(String sensePath){
  File file = new File(sensePath);
  String[] lines = loadStrings(file.getAbsolutePath());
  ArrayList<ArrayList<String>> items = new ArrayList<>();
  
  num_circle = 0;
  num_box = 0;
  num_line = 0;
  
  for (String s : lines) {
    if (s.contains("Circles")){
      num_circle = Integer.parseInt(s.split(":")[1].trim());
    }else if (s.contains("Lines")){
      num_box = Integer.parseInt(s.split(":")[1].trim());
    }else if (s.contains("Boxes")){
      num_line = Integer.parseInt(s.split(":")[1].trim());
    }else if (s.charAt(0)!='#'){
      ArrayList<String> temp = new ArrayList<>(Arrays.asList(s.split(":")[1].split(" ")));
      items.add(temp);
    }
  }
  num_box+=num_circle;
  num_line+=num_box;
  ArrayList<Shape>  items_Shape = new ArrayList<>(); 
  println(items.size());
 for (int j = 0; j < items.size(); j++) {
    ArrayList<String> innerList = items.get(j);
    int cur_id = whichShape(j);
    Shape cur_shape;
    if (cur_id==0){
      cur_shape = new Circle(Float.parseFloat(innerList.get(1)),Float.parseFloat(innerList.get(2)),Float.parseFloat(innerList.get(3)));
    }else if(cur_id==1){
      cur_shape = new Lines(Float.parseFloat(innerList.get(1)),Float.parseFloat(innerList.get(2)),Float.parseFloat(innerList.get(3)),Float.parseFloat(innerList.get(4)));
    }else{
      cur_shape = new Box(Float.parseFloat(innerList.get(1)),Float.parseFloat(innerList.get(2)),Float.parseFloat(innerList.get(3)),Float.parseFloat(innerList.get(4)));
    }

    items_Shape.add(cur_shape);
  }
  return items_Shape;
}
