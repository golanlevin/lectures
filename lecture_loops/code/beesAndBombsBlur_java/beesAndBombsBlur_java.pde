/*  Passable motion blur effect using frame blending.
 *  Basically move your 'draw()' into 'sample()', time runs from 0 to 1
 *  By Dave Whyte from http://beesandbombs.tumblr.com
 * 
 *  Modified by Golan Levin for Processing 3.4, September 2018
 */


int numFrames = 48;
int samplesPerFrame = 32;  // more is better but slower. 32 is enough probably        
float shutterAngle = 2.0;  // this should be between 0 and 1 realistically. exaggerated for effect here
float[][] accumulator;

float time;
PGraphics offscreen;

void setup() {
  size(500, 500);
  accumulator = new float[width*height][3];
  offscreen = createGraphics(500, 500);
}

void draw() {

  // Blank the accumulation buffer.
  int nPixels = width*height;
  for (int i=0; i<nPixels; i++) {
    accumulator[i][0] = 0;
    accumulator[i][1] = 0;
    accumulator[i][2] = 0;
  }

  // Render the scene multiple times, 
  // adding those pixels into the accumulation buffer
  for (int sa=0; sa<samplesPerFrame; sa++) {
    time = map(frameCount + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
    sample();
    
    offscreen.loadPixels();
    for (int i=0; i<nPixels; i++) {
      color offcol = offscreen.pixels[i];
      accumulator[i][0] += red(offcol);
      accumulator[i][1] += green(offcol);
      accumulator[i][2] += blue(offcol);
    }
  }

  // Calculate the motion-blurred frame, 
  // by taking the average of the accumulation buffer. 
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    float r = (accumulator[i][0]/samplesPerFrame);
    float g = (accumulator[i][1]/samplesPerFrame);
    float b = (accumulator[i][2]/samplesPerFrame);
    pixels[i] = color(r,g,b); 
  }
  updatePixels();

  // Export the generated frames and quit when done. 
  saveFrame("frames/frame_##.png");
  if (frameCount==numFrames) {
    exit();
  }
}

void sample() {
  // Leave this alone
  offscreen.beginDraw(); 
  
  // Put your per-frame drawing stuff here. 
  offscreen.background(0);
  offscreen.fill(255);
  offscreen.noStroke();
  offscreen.rectMode(CENTER);
  offscreen.pushMatrix();
  offscreen.translate(width/2, height/2);
  offscreen.rotate(HALF_PI*time);
  offscreen.rect(0, 0, 200, 200);
  offscreen.popMatrix();
  
  // Leave this alone
  offscreen.endDraw();
}
