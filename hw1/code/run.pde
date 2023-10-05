import java.util.*;

ArrayList<ArrayList<String>> items;
ArrayList<Shape> items_Shape;

ArrayList<Float> list_time = new ArrayList();
ArrayList<Integer> list_num = new ArrayList();

int num_circle;
int num_box;
int num_line;
PrintWriter output;


void setup() {
  size(800,600);

  // Specify the directory path where the files are located
  String directoryPath = "/Users/haoyishi/Documents/CSCI5611/hw/hw1/CollisionTasks"; 
  
  // Get a list of files in the directory
  File directory = new File(directoryPath);
  File[] files = directory.listFiles();
  //println(files);
  String final_out = "";
  for (File file : files) {
    final_out = "";
    if (file.isFile() && file.getName().startsWith("task") && file.getName().endsWith(".txt")) {
      String[] lines = loadStrings(file.getAbsolutePath());
      items = new ArrayList<>();
      
      int lastDotIndex = file.getName().lastIndexOf(".");
      String nameWithoutExtension = file.getName().substring(0, lastDotIndex);
      String extension = file.getName().substring(lastDotIndex);
            
      
      
      output = createWriter(nameWithoutExtension+"_solution"+extension); 
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
    
    
      items_Shape = new ArrayList<>(); 
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
      
      //int num_collision = 0;
      ArrayList<Integer> list_collision = new ArrayList<> ();
      long start = System.nanoTime();
      for(int i = 0;i<items_Shape.size();i++){
        Shape cur_shape = items_Shape.get(i);
        int cur_item = cur_shape.id;
        for (int j=i+1;j<items_Shape.size();j++){
          Shape compare_shape = items_Shape.get(j);
          int compare_item = compare_shape.id;
          boolean cur_check = checkCollision(cur_item,compare_item,cur_shape,compare_shape);
          if (cur_check){ 
            //num_collision++;
            if (!list_collision.contains(i)) list_collision.add(i);
            if (!list_collision.contains(j)) list_collision.add(j);
          }
          
        }
      }
      long end = System.nanoTime();
      float res = (end-start)/1000000.0;
      //print(res);
      
      //final_out+="File: "+file.getName()+"Duration: "+res+" ms"+"\n"+"Num Collisions: "+list_collision.size()+"\n"+list_collision.toString();
      final_out+="File: "+file.getName()+"Duration: "+res+" ms"+"\n"+"Num Collisions: "+list_collision.size()+"\n";
      Collections.sort(list_collision);
      for(int i:list_collision){
        final_out+=""+i+"\n";
      }
      list_time.add(res);
      list_num.add(list_collision.size());
      println(file.getName());
      }
    output.println(final_out);
    output.flush(); 
    output.close();
  }
  //print(list_num,list_time);

}
