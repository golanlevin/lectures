// This is a rudimentary Proce55ing port of Paul Haeberli's
// legendary and monumentally influential program "Dynadraw",
// which is described at: http://www.sgi.com/grafica/dyna/index.html
// Originally created in June 1989 by Paul Haeberli
// Ported to Proce55ing January 2004 by Golan Levin.
// Ported to Processing 3.0.1 January 2016 by Golan Levin.

// Paul wrote:
/*
Here's a really fun and useful hack.
The program Dynadraw implements a dynamic drawing technique that applies
a simple filter to mouse positions. Here the brush is modeled as a physical
object with mass, velocity and friction. The mouse pulls on the brush with
a synthetic rubber band. By changing the amount of friction and mass, various
kinds of strokes can be made. This kind of dynamic filtering makes it easy
to create smooth, consistent calligraphic strokes.
*/

float px, py;              // current position of spring
float vx, vy;              // current velocity
float ppx, ppy;            // our previous position
float k = 0.06;            // bounciness, stiffness of spring
float damping = 0.88;     // friction
float ductus = 0.5;        // this constant relates stroke width to speed
float max_th = 15.0;       // maximum stroke thickness
float mass = 1;            // mass of simulated pen

// slider params
int sliderh = 25;
float max_K_val = 0.2;
float min_K_val = 0.01;
float max_D_val = 0.999;
float min_D_val = 0.250;
boolean editing_K = false;
boolean editing_D = false;


//----------------------------------------------------------------
void setup(){
  size(600, 512, OPENGL);
  background(255);
  stroke(0);
  fill(0);
  smooth();  

  ppy = py = height/2;
  ppx = px = width/2;
  vx = vy = 0;
}

//----------------------------------------------------------------
void draw(){

  updateTrace();
  updateSliders();

  drawCredit();
  drawTrace();
  drawSliders();

  ppx = px;                 // Update the previous positions so lines
  ppy = py;                 // can be drawn next time through the loop.
}

//----------------------------------------------------------------
void updateTrace(){
  float dy = py - mouseY;   // Compute displacement from the cursor
  float dx = px - mouseX;
  float fx = -k * dx;       // Hooke's law, Force = - k * displacement
  float fy = -k * dy;
  float ay = fy / mass;     // Acceleration, computed from F = ma
  float ax = fx / mass;
  vx = vx + ax;             // Integrate once to get the next
  vy = vy + ay;             // velocity from the acceleration
  vx = vx * damping;        // Apply damping, which is a force
  vy = vy * damping;        // negatively proportional to velocity
  px = px + vx;             // Integrate a second time to get the
  py = py + vy;             // next position from the velocity
}

//----------------------------------------------------------------
void drawTrace(){

  if(mousePressed){
    float vh = sqrt(vx*vx + vy*vy);                    // Compute the (Pythagorean) velocity,
    float th = max_th - min(vh*ductus, max_th);        // which we use (scaled, clamped and
    th = max(1.0, th);                                 // inverted) in computing...
    strokeWeight(th*1.0);                              // ... the stroke weight
    stroke(0);
    strokeCap(ROUND); 
    line (ppx, ppy, px,  py);

    if (th > 1.0){                           // Draw a little ball at the joint
      noStroke();
      fill(0);
      ellipse (px, py, th*1.0, th*1.0);
    }
  }
}

//----------------------------------------------------------------
void mousePressed() {

  float tol = 40;
  float K_x = (float)width*(k - min_K_val)/(max_K_val - min_K_val);
  float D_x = (float)width*(damping - min_D_val)/(max_D_val - min_D_val);
  if ((abs(mouseX - K_x) < tol) && (mouseY > 0) && (mouseY < sliderh)){
    editing_K = true;
    editing_D = false;
  } else if ((abs(mouseX - D_x) < tol) && (mouseY > sliderh) && (mouseY < sliderh*2)){
    editing_D = true;
    editing_K = false;
  } else {
    editing_K = false;
    editing_D = false;
    background (255);
  }
}

//----------------------------------------------------------------
void mouseReleased(){
  editing_K = false;
  editing_D = false;
}

//----------------------------------------------------------------
void updateSliders(){
  if (editing_K){
    float new_K = (float)mouseX/(float)width * (max_K_val - min_K_val) + min_K_val;
    new_K = max(min_K_val, min(max_K_val, new_K));
    k = new_K;
  } else if (editing_D){
    float new_D = (float)mouseX/(float)width * (max_D_val - min_D_val) + min_D_val;
    new_D = max(min_D_val, min(max_D_val, new_D));
    damping = new_D;
  }
  drawSliders();
}

//----------------------------------------------------------------
void drawSliders(){
  stroke(0);
  fill(200);
  strokeWeight(1);
  rect(0, 0, width-1, sliderh*2);
  line(0,sliderh, width-1,sliderh);

  float K_x = (float)width*(k - min_K_val)/(max_K_val - min_K_val);
  float D_x = (float)width*(damping - min_D_val)/(max_D_val - min_D_val);
  line (K_x, 0, K_x, sliderh);
  line (D_x, sliderh, D_x, sliderh*2);

  fill(110);
  textAlign(RIGHT);
  text("STIFFNESS", K_x-5, sliderh-8);
  text("DAMPING", D_x-5, sliderh*2-8);

  textAlign(LEFT);
  text((""+k), K_x+5, sliderh-8);
  text((""+damping), D_x+5, sliderh*2-8);
}

//----------------------------------------------------------------
void drawCredit(){
  fill(255);
  stroke(200);
  rect(-1,height-sliderh,width+1, sliderh);
  fill(200);
  textAlign(LEFT);
  text("Dynadraw / Paul Haeberli, 1989", 5, height-7);
}

//----------------------------------------------------------------
// Notes about this port of Haeberli's Dynadraw.
// This was an extremely quick port that I executed from memory. I didn't actually
// look at Paul's code online; rather, I just ported the main concept. There are
// lots of ways that this port could have been improved (such as the implementation of
// Paul's original chiseled drawing nib). I wanted to keep the code simple, but
// naturally I welcome any and all to make improvements as necessary.