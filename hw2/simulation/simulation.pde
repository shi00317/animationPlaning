int numNodes = 20;
Vec2 nodeBase = new Vec2(15,5);

int sub_steps = 10;
int relaxation_steps = 10;
float link_length = 1.0;

Vec2 gravity = new Vec2(0, 10.0);
float scene_scale = width / 10.0f;

ArrayList<Node> nodes = new ArrayList();
Table table;
// Initialization
void setup(){
  size(1000, 1000);
  for(int i=0;i<numNodes;i++){
   nodes.add(new Node(new Vec2(nodeBase.x+i*link_length, nodeBase.y))); 
  }
  scene_scale = width / 50.0f;

  table = new Table();
  
  table.addColumn("time");
  table.addColumn("energy");
  table.addColumn("error");

}


boolean paused = false;

void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  }
}

float time = 0;
void draw() {
  float dt = 1.0 / 20;
  
  if (!paused) {
    for (int i = 0; i < sub_steps; i++) {
      time += dt / sub_steps;
      //print(dt / sub_steps);
      update(dt / sub_steps);
    }
  }

  float total_energy = total_energy();
  float total_error  = total_length_error();
  
  TableRow newRow = table.addRow();
  newRow.setFloat("time", time);
  newRow.setFloat("energy", total_energy);
  newRow.setFloat("error", total_error);
  
  println("t:", time, " energy:", total_energy,"error",total_error);
  if(time>30){
    String fileName = "sub_steps_"+sub_steps+"_relaxation_steps_"+relaxation_steps+".csv";
    saveTable(table, fileName);
    exit();
  }
  background(255);
  stroke(0);
  strokeWeight(2);

  // Draw Nodes (green with black outline)
  fill(0, 255, 0);
  stroke(0);
  strokeWeight(0.02 * scene_scale);
  for(int i=0;i<nodes.size();i++){
    //println();
    ellipse(nodes.get(i).pos.x * scene_scale, nodes.get(i).pos.y * scene_scale, 0.3 * scene_scale, 0.3 * scene_scale);

    //ellipse(nodes.get(i).pos.x* scene_scale, nodes.get(i).pos.y* scene_scale, 15, 15);
  }


  // Draw Links (black)
  stroke(0);
  strokeWeight(0.02 * scene_scale);
  for(int i=0;i<nodes.size()-1;i++){
    line(nodes.get(i).pos.x* scene_scale, nodes.get(i).pos.y* scene_scale , nodes.get(i+1).pos.x* scene_scale , nodes.get(i+1).pos.y* scene_scale );

  }
}

void update(float dt){
  // Semi-implicit Integration
  for(int i=1;i<nodes.size();i++){
    nodes.get(i).last_pos = nodes.get(i).pos;
    nodes.get(i).vel = nodes.get(i).vel.plus(gravity.times(dt));
    nodes.get(i).pos = nodes.get(i).pos.plus(nodes.get(i).vel.times(dt));  
  }
  
  // Constrain the distance between nodes to the link length

    for (int i = 0; i < relaxation_steps; i++) {
        for (int j=1;j<nodes.size();j++){
      Vec2 delta = nodes.get(j).pos.minus(nodes.get(j-1).pos);
      float delta_len = delta.length();
      float correction = delta_len - link_length;
      Vec2 delta_normalized = delta.normalized();
      nodes.get(j).pos = nodes.get(j).pos.minus(delta_normalized.times(correction / 2));
      nodes.get(j-1).pos = nodes.get(j-1).pos.plus(delta_normalized.times(correction / 2));  
      nodes.get(0).pos = nodeBase; // Fix the base node in place
    }
  }
  
  // Update the velocities (PBD)
  for(int i=0;i<nodes.size();i++){
    nodes.get(i).vel = nodes.get(i).pos.minus(nodes.get(i).last_pos).times(1 / dt);
  }

}

float total_energy(){
  // Compute the total energy (should be conserved)
  float kinetic_energy = 0;
  for(int i=0;i<nodes.size();i++){
    kinetic_energy += 0.5 * nodes.get(i).vel.lengthSqr(); // KE = (1/2) * m * v^2

  }

  float potential_energy = 0; // PE = m*g*h
  // potential_enegry = sum(gravity_magnitude * height) // TODO: compute this
  for(int i=0;i<nodes.size();i++){
    float h = (height-nodes.get(i).pos.y* scene_scale) / scene_scale;
    potential_energy += (h) * gravity.y;
    //print(height-nodes.get(i).pos.y+" ");
  }
  float total_energy = kinetic_energy + potential_energy;

  return total_energy;
}

float total_length_error() {
    float total_error = 0;
    for(int i=0; i<nodes.size()-1; i++) {
        float current_length = nodes.get(i).pos.distanceTo(nodes.get(i+1).pos);
        total_error += abs(current_length - link_length);
    }
    return total_error;
}
