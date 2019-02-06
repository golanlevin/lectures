// Floccus (Processing Version) by Golan Levin (1999-2011)
// Compiled for Processing 0198, July 2011
// Compiled for Processing 3.0.1, Feb 2016
// http://flong.com/projects/floccus/
//
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// Contact: golan@flong.com
//
// You are free:
//    to Share â€” to copy, distribute and transmit the work
//    to Remix â€” to adapt the work
// Under the following conditions:
//    Attribution â€” You MUST attribute the work in the manner specified by Golan Levin
//    (but not in any way that suggests that Levin endorses you or your use of the work).
//    Noncommercial â€” You may not use this work for commercial purposes.
//    Share Alike â€” If you alter, transform, or build upon this work, you may distribute 
//    the resulting work only under the same or similar license to this one. 

//---------------------------------------------------------------------------
boolean theMouseDrag = false;
float   theMouseX, theMouseY;
float   thePMouseX, thePMouseY;
static  float GRAVITY = 35.0f;

Stroke   strokeArray[];
int   nStrokes;
int  maxNStrokes;
int   currentStrokeID;

float   bt[];
float   bt2[];
float   bt3[];
float   onemt[];
float   onemt2[];
float   onemt3[];
float   bto2[];
float   bt2o[];
final   int nBezSegments = 6;
final   int nBezPoints = nBezSegments+1;
final   float SPLINE_BIAS = 1.0f/4.0f;
float   minBezDist = 16;

color   bgColor;
final int UNSIGN = 0xFF;
final int MASK_BLU = 0x000000FF;
final int MASK_GRN = 0x0000FF00;
final int MASK_RED = 0x00FF0000;
final int DIV = 6;
final int firstPixel = (UNSIGN&64)/DIV;
int   widthm1, heightm1;


//--------------------------------------------------------------------------------
// wanker stuff
boolean theFakeMouseDown = false;
int fakeMouseX;
int fakeMouseY;

long  lastInteractionTime       = -99999;
long  lastSplineTime     = -99999;
boolean  makingSpline    = true;
int   AURORA_LONELY_TIME        = 8000;
int   FLOCCUS_AUTOMATIC         = 0;
int   FLOCCUS_MANUAL            = 1;
int   mode                      = FLOCCUS_AUTOMATIC;

int   nSubsplinesPerOccasion    = 5;
int   curnSubsplinesPerOccasion = 5;
int   currentSubspline     = 0;
int   nSplineIterations         = 20;
int   curnSplineIterations      = 25;
long  waitBetweenSplines        = 2000;
int   currentSplineIteration    = 0;

Vec2f sploint[];  /* spline control points */

boolean begun = false;
boolean showInfo = false;
long begunTime;
// PImage ccLicenseImage;
// PFont fonty;

//--------------------------------------------------------------------------
void setup() {

  size(1024, 768, OPENGL);

  // ccLicenseImage = loadImage ("cc-license-by-nc-sa-88x31.png"); 
  // fonty = loadFont("Garamond-Italic-24.vlw");  
  //textMode(SCREEN);
  //textFont(fonty, 24); 


  widthm1  = width - 1;
  heightm1 = height -1;
  bgColor  = color (0, 0, 100);

  precomputeBezierArrays();
  initializeStrokes();

  sploint = new Vec2f[4];
  for (int i=0; i<4; i++) {
    float x = (float)Math.random()*(float)widthm1;
    float y = (float)Math.random()*(float)heightm1;
    sploint[i] = new Vec2f(x, y);
  }
}

//--------------------------------------------------------------------------
void precomputeBezierArrays() {
  bt    = new float[nBezPoints];
  bt2    = new float[nBezPoints];
  bt3    = new float[nBezPoints];
  onemt          = new float[nBezPoints];
  onemt2  = new float[nBezPoints];
  onemt3  = new float[nBezPoints];
  bto2          = new float[nBezPoints];
  bt2o          = new float[nBezPoints];

  for (int p=0; p<nBezPoints; p++) {
    bt[p]    = (float)p/(float)nBezSegments;
    bt2[p]    = bt[p] * bt[p];
    bt3[p]    = bt[p] * bt2[p];
    onemt[p]          = 1.0f  - bt[p];
    onemt2[p]          = onemt[p] * onemt[p];
    onemt3[p]          = onemt[p] * onemt2[p];
    bto2[p]    = 3f*bt[p] * onemt2[p];
    bt2o[p]    = 3f*bt2[p]* onemt[p];
  }
}



//--------------------------------------------------------------------------
void initializeStrokes() {
  nStrokes = 0;
  maxNStrokes = 6;
  currentStrokeID = -1;
  strokeArray = new Stroke[maxNStrokes];
  for (int i=0; i<maxNStrokes; i++) {
    strokeArray[i] = new Stroke();
  }
}

//--------------------------------------------------------------------------
void draw() {


  background(bgColor);
  nSplineIterations = 30;
  minBezDist = 10;


  handleAutomaticDisplay();

  if (mousePressed || theMouseDrag) {
    if ((theMouseX != 0) && (theMouseY != 0)) {
      for (int i=0; i<nStrokes; i++) {
        boolean special = (theMouseDrag && (i == currentStrokeID));
        strokeArray[i].impulseFromLoc (theMouseX, theMouseY, GRAVITY, special);
      }
    }
  }
  for (int i=0; i<nStrokes; i++) {
    strokeArray[i].move(true);
  }

  drawIntro();
  drawFades();
}


//---------------------------------------------
void drawIntro() {
  float py = height*(1-0.5);
  String creditStr = "Floccus by Golan Levin, 1999-2016";
  textAlign (CENTER); 
  if (!begun) {
    begunTime = millis();
    fill(255); 
    if (showInfo) {
      text(creditStr, width/2, height*0.96);
    } else {
      text(creditStr, width/2, py - 30); 
      text("Scribble to begin", width/2, py);
      // image(ccLicenseImage, width/2- (ccLicenseImage.width)/2, py+(ccLicenseImage.height));
    }
    noFill();
  } else {
    float dur = 2100;
    float dif = (float)(millis() - begunTime);
    if (dif < dur) {
      float c = 1.0 - dif/dur;
      fill(255, 255, 255, c*255); //c*255, c*255, c*155 + 100); 
      if (showInfo) {
        text(creditStr, width/2, height*0.96);
      } else {
        text(creditStr, width/2, py - 30); 
        text("Scribble to begin", width/2, py);

        tint(255, 255, 255, c*255); 
        // image(ccLicenseImage, width/2- (ccLicenseImage.width)/2, py+(ccLicenseImage.height));
      }
      noFill();
    }
  }
}



//----------------------------------------------------------
void drawFades() {

  noStroke();

  float wf = width*0.045;
  float hf = height*0.045;
  beginShape(QUADS);

  float blu0 = blue(bgColor);
  float blu1 = blue(bgColor)*0.45;
  float alp1 = 128;

  fill(0, 0, blu1, alp1);
  vertex(0, 0);
  vertex(0, height);
  fill(0, 0, blu0, 0);
  vertex(wf, height-hf);
  vertex(wf, hf);

  fill(0, 0, blu1, alp1);
  vertex(0, 0);
  vertex(width, 0);
  fill(0, 0, blu0, 0);
  vertex(width-wf, hf);
  vertex(wf, hf);

  fill(0, 0, blu1, alp1);
  vertex(width, 0);
  vertex(width, height);
  fill(0, 0, blu0, 0); 
  vertex(width-wf, height);
  vertex(width-wf, 0);

  fill(0, 0, blu1, alp1);
  vertex(0, height);
  vertex(width, height);
  fill(0, 0, blu0, 0);
  vertex(width-wf, height-hf);
  vertex(wf, height-hf);

  endShape();
}


//--------------------------------------------------------------------------
// interaction methods


void mousePressed() {
  begun = true;
  lastInteractionTime = millis();
  handleMousePressed(mouseX, mouseY);
}
void mouseReleased() {
  lastInteractionTime = millis();
  handleMouseReleased(mouseX, mouseY);
}
void mouseDragged() {
  begun = true;
  lastInteractionTime = millis();
  handleMouseDragged(mouseX, mouseY);
}
void mouseMoved() {
  lastInteractionTime = millis();
  handleMouseMoved(mouseX, mouseY);
}



void handleMousePressed (float x, float y) {
  thePMouseX = theMouseX;
  thePMouseY = theMouseY;
  theMouseX  = x;
  theMouseY  = y;
  theMouseDrag = false;

  // handle the incrementing of the currentStrokeID
  nStrokes = min((nStrokes + 1), maxNStrokes);
  currentStrokeID = (currentStrokeID+1)%maxNStrokes;
  if (currentStrokeID >= 0) {
    if ((theMouseX != 0) && (theMouseY != 0) && (thePMouseX != 0) && (thePMouseY != 0)) {
      strokeArray[currentStrokeID].clear();
      strokeArray[currentStrokeID].addPoint(theMouseX, theMouseY);
    }
  }
}

void handleMouseReleased (float x, float y) {
  thePMouseX = theMouseX;
  thePMouseY = theMouseY;
  theMouseX  = x;
  theMouseY  = y;
  theMouseDrag = false;
}

void handleMouseMoved(float x, float y) {
  thePMouseX = theMouseX;
  thePMouseY = theMouseY;
  theMouseX  = x;
  theMouseY  = y;
  theMouseDrag = false;
}

void handleMouseDragged(float x, float y) {
  thePMouseX = theMouseX;
  thePMouseY = theMouseY;
  theMouseX  = x;
  theMouseY  = y;
  theMouseDrag = true;
  if (currentStrokeID >= 0) {
    if ((abs(theMouseX - thePMouseX)+ abs(theMouseY-thePMouseY)) >= 1) {
      if ((theMouseX != 0) && (theMouseY != 0) && (thePMouseX != 0) && (thePMouseY != 0)) {
        strokeArray[currentStrokeID].addPoint(theMouseX, theMouseY);
      }
    }
  }
}

//----------------------------------------------------------------------------------
void keyPressed () {

  switch ((char)key) {
  default:
    begunTime = millis();
    showInfo = true;
    break;

  case '=': 
  case '+': 
    GRAVITY = min(100, GRAVITY+2);
    break;
  case '-': 
    GRAVITY = max(4, GRAVITY-2);
    break;


  case ' ':
    for (int i=0; i<nStrokes; i++) {
      strokeArray[i].clear();
    }
    break;
  }
}



//---------------------
class Vec2f {
  Vec2f(float xi, float yi) {
    x = xi; 
    y = yi;
  }
  float x;
  float y;
}

//---------------------
void handleAutomaticDisplay() {

  // switch modes if left lone for a while
  long now = millis();
  if ((now - lastInteractionTime) >= AURORA_LONELY_TIME) {
    mode = FLOCCUS_AUTOMATIC;
  } else {
    mode = FLOCCUS_MANUAL;
    makingSpline = false;
    theFakeMouseDown = false;
  }

  if (mode == FLOCCUS_AUTOMATIC) {
    if (makingSpline) {
      float t = (float) currentSplineIteration/ (float) curnSplineIterations;

      float x0 = sploint[0].x;
      float y0 = sploint[0].y;
      float x1 = sploint[1].x;
      float y1 = sploint[1].y;
      float x2 = sploint[2].x;
      float y2 = sploint[2].y;
      float x3 = sploint[3].x;
      float y3 = sploint[3].y;

      float bt        = t;
      float bt2        = bt * bt;
      float bt3        = bt * bt2;
      float onemt     = 1.0f  - bt;
      float onemt2    = onemt * onemt;
      float onemt3    = onemt * onemt2;
      float bto2      = 3.0f  * bt  * onemt2;
      float bt2o      = 3.0f  * bt2 * onemt;

      float sx = onemt3*x0 + bto2*x1 + bt2o*x2 + bt3*x3;
      float sy = onemt3*y0 + bto2*y1 + bt2o*y2 + bt3*y3;

      if (currentSplineIteration == 0) {
        theFakeMouseDown = true;
        fakeMouseX = (int)sx;
        fakeMouseY = (int)sy;
        handleMousePressed (fakeMouseX, fakeMouseY);
        currentSplineIteration++;
      } else if (currentSplineIteration < curnSplineIterations) {
        theFakeMouseDown = true;
        fakeMouseX = (int)(sx + 0.5);
        fakeMouseY = (int)(sy + 0.5);
        handleMouseDragged (fakeMouseX, fakeMouseY);
        currentSplineIteration++;
      } else if (currentSplineIteration >= curnSplineIterations) {

        curnSplineIterations = nSplineIterations + (int)random(30.0);

        if (currentSubspline >= (curnSubsplinesPerOccasion-1)) {
          theFakeMouseDown = false;
          makingSpline = false;
          handleMouseReleased (fakeMouseX, fakeMouseY);
          lastSplineTime = now;
          currentSubspline = 0;
        } else {
          theFakeMouseDown = true;
          fakeMouseX = (int)sx;
          fakeMouseY = (int)sy;
          handleMouseDragged (fakeMouseX, fakeMouseY);
          currentSplineIteration = 1;
          currentSubspline++;

          sploint[0].x = sploint[3].x;
          sploint[0].y = sploint[3].y;
          sploint[1].x = 2.0f*(sploint[3].x) - sploint[2].x;
          sploint[1].y = 2.0f*(sploint[3].y) - sploint[2].y;
          for (int i=2; i<4; i++) {
            sploint[i].x = (float)Math.random()*(float)widthm1;
            sploint[i].y = (float)Math.random()*(float)heightm1;
          }
        }
      }
    } else { // if not making a spline
      if (((now - lastSplineTime) > waitBetweenSplines) && (random(1.0) < 0.005)) {
        // time for new spline
        makingSpline = true;
        currentSplineIteration = 0;
        curnSubsplinesPerOccasion = nSubsplinesPerOccasion + (int)random(4.0);

        for (int i=0; i<4; i++) {
          sploint[i].x = (float)Math.random()*(float)widthm1;
          sploint[i].y = (float)Math.random()*(float)heightm1;
        }
      }
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public class Stroke {

  static final float MAX_SEG_LENGTH =  6.0f;
  static final float MAX_SEG_LENGTH_INV = 1.0f/MAX_SEG_LENGTH;
  static final float linearSpringConstant  = 0.0120f; //0.0125f;
  static final float angularSpringConstant = 0.0009f; //0.001f;
  static final int   MAX_NPOINTS = 1000;
  static final float damping = 0.95f; //0.91f;

  float xptsPos[]; // positions
  float yptsPos[];
  float xptsVel[]; // velocities
  float yptsVel[];
  float initDis[]; // initial distances between points
  float initAng[]; // initial angles between points

  int   nPoints;
  boolean  done_adding;

  public Stroke() {
    xptsPos = new float[MAX_NPOINTS];
    yptsPos = new float[MAX_NPOINTS];
    xptsVel = new float[MAX_NPOINTS];
    yptsVel = new float[MAX_NPOINTS];
    initDis = new float[MAX_NPOINTS];
    initAng = new float[MAX_NPOINTS];
    clear();
  }

  void clear() {
    nPoints = 0;
    done_adding = false;
  }

  ////////////////////////////////////////////////////
  // Add a point to the Stroke.
  void addPoint(float x, float y) {

    float DX, DY, DH;
    float dx, dy, dh;
    int   segsToPlace;

    if (nPoints==0) {
      done_adding = false;

      // deal with assigning values for the first point
      xptsPos[nPoints] = x;                  // assign positions
      yptsPos[nPoints] = y;
      xptsVel[nPoints] = 0.0f;      // assign velocities
      yptsVel[nPoints] = 0.0f;
      initDis[nPoints] = 0.0f;      // assign initial distance
      initAng[nPoints] = 0.0f;      // assign initial angle
      nPoints++;
    } else if (nPoints >= MAX_NPOINTS) {
      done_adding = true;
    } else if ((nPoints>0) && (nPoints < MAX_NPOINTS)) {
      done_adding = false;

      // use a linear interpolation method
      DX = x-xptsPos[nPoints-1];
      DY = y-yptsPos[nPoints-1];
      DH = (float) sqrt(DX*DX + DY*DY);

      // if the user deposits a very long segment,
      // break it up by placing short segments
      segsToPlace = (int)(DH * MAX_SEG_LENGTH_INV);
      float remainder = DH - (segsToPlace*MAX_SEG_LENGTH);
      float maxLen = MAX_SEG_LENGTH;
      float slopex = DX/DH;
      float slopey = DY/DH;
      float segLength;

      // hack for super-short segments so they get drawn at all
      if (segsToPlace == 0) { 
        segsToPlace = 1; 
        maxLen = 0;
      }
      // linear interpolation with intermediary points
      for (int i=0; i<segsToPlace; i++) {
        if (nPoints >= MAX_NPOINTS) {
          done_adding = true;
          break;
        } else {
          segLength = maxLen;
          if (i==0) {
            // causes the last point to be placed correctly
            segLength = maxLen+remainder;
          }

          // assign values of new elements
          // assign positions
          xptsPos[nPoints] = ((xptsPos[nPoints-1]) + (slopex*segLength));
          yptsPos[nPoints] = ((yptsPos[nPoints-1]) + (slopey*segLength));
          // assign velocities
          xptsVel[nPoints] = 0.0f;
          yptsVel[nPoints] = 0.0f;

          // assign rest lengths and angles
          dx = slopex*segLength;
          dy = slopey*segLength;
          dh = segLength;

          initDis[nPoints] = dh;

          if (nPoints >1) {
            float pdx = xptsPos[nPoints-1] - xptsPos[nPoints-2];
            float pdy = yptsPos[nPoints-1] - yptsPos[nPoints-2];
            float pdh = initDis[nPoints-1];
            float angle = findAngle(pdx, pdy, pdh, dx, dy, dh);
            initAng[nPoints-1] = angle;
          } else { 
            initAng[nPoints] = 0;
          }

          nPoints++;
        }
      }
    }

    // hack to eliminate 2-point lines,
    // which cause screwed-up sound conditions.
    // unexplained bug; 2-point lines cause sound to
    // clip if they are held pinned under a static mousedown
    if (nPoints == 2) addPoint(x+0.1f, y+0.1f);
  }

  ////////////////////////////////////////////
  float findAngle( float Ax, float Ay, float magA, float Bx, float By, float magB) {

    if ((abs(magA) < 0.00001) || (abs(magB) < 0.00001)) {
      return 0;
    } else {
      float dotProduct   = Ax*Bx + Ay*By;
      float crossProduct = Ax*By - Ay*Bx;
      float cosTheta = (dotProduct/magA)/magB;    // because dp = abcost
      float angle = (float)(Math.acos(cosTheta));

      if (Float.isNaN(angle)) {
        angle = 0;
      } else if (crossProduct < 0) {
        angle = 0-angle;
      }
      return (RAD_TO_DEG * angle); // the angle whose cosine is cosTheta
    }
  }

  //--------------------------------------------------------------------------
  void impulseFromLoc (float mx, float my, float G, boolean special) {

    float fx, fy;
    float dx, dy;
    float dh;
    int spts = (special && !done_adding) ? (nPoints - 16) : nPoints;
    int npts = spts-1;
    if (npts >= 0) {
      for (int i=0; i<npts; i++) {
        dx = mx-xptsPos[i];
        dy = my-yptsPos[i];
        dh = G/((dx*dx + dy*dy) + 0.1f);
        xptsVel[i] += dx*dh;
        yptsVel[i] += dy*dh;
      }
    }
  }

  //------------------------------------------------------------------
  void impulse(int i, float xacc, float yacc) {
    if (i<nPoints) {
      xptsVel[i]    += xacc;
      yptsVel[i]    += yacc;
      xptsVel[i+1]  += xacc;
      yptsVel[i+1]  += yacc;
    }
  }

  //------------------------------------------------------------------
  void move (boolean drawAlso) {
    // the stroke is modeled as a series of
    // linear and torsional springs and dampers.
    // this method updates this model.

    float dx, dy, dh;
    int nSegs = nPoints-1;

    if (nSegs > 1) {

      float xaccL, yaccL; // linear spring force
      float displacement;
      float pdx, pdy, pdh, angDisp;
      pdx=0; 
      pdy=0; 
      pdh = 0.00001f;

      float factor1, factor2;
      float xaccR1, yaccR1; // rotational spring force
      float xaccR2, yaccR2;
      int   i=0;
      int   j=1;
      float fa;

      for (i=0; i<nSegs; i++) {
        j = i+1;

        //--------------------------------------
        // compute linear spring forces
        // get the linear displacement
        dx = xptsPos[j] - xptsPos[i];
        dy = yptsPos[j] - yptsPos[i];
        dh = sqrt(dx*dx + dy*dy);
        if (abs(dh) < 0.00001) {
          dh = 0.00001f;
        }

        //-------------------------------
        // compute rotational spring forces
        // get the angular displacement
        fa = findAngle( pdx, pdy, pdh, dx, dy, dh);
        angDisp = (i>0) ? (fa - initAng[i]) : 0;

        // angular forces for point(i+1)
        factor1 = angDisp / dh * angularSpringConstant;  // dh goes from i to i+1
        xaccR1 = ( -dy)*factor1;  // i.e., (cy - y1)*factor1;
        yaccR1 = (  dx)*factor1;  // i.e., (x1 - cx)*factor1;

        // angular forces for point(i-1)
        factor2 = angDisp / pdh * angularSpringConstant; // pdh goes from i-1 to i
        xaccR2 = (-pdy)*factor2;  // i.e., (y2 - cy)*factor2;
        yaccR2 = ( pdx)*factor2;  // i.e., (cx - x2)*factor2;

        pdx = dx;
        pdy = dy;
        pdh = dh;

        //-------------------------------------------
        // integrate: add accelerations to velocities
        // using dumb Euler integration.
        // add linear and rotational spring forces
        displacement = ((dh - initDis[j])*linearSpringConstant)/dh;
        xptsVel[i] += ((xaccL = dx * displacement) + (xaccR1 + xaccR2));
        yptsVel[i] += ((yaccL = dy * displacement) + (yaccR1 + yaccR2));
        xptsVel[j] -= (xaccL + xaccR1);
        yptsVel[j] -= (yaccL + yaccR1);

        if (i>0) {
          xptsVel[i-1] -= xaccR2;
          yptsVel[i-1] -= yaccR2;
        }
      }

      if (drawAlso) {
        //---------------------------------------
        // UPDATE AND RENDER the model

        float x0f, x1f, x2f, x3f;
        float y0f, y1f, y2f, y3f;
        float sx0, sy0, sx1, sy1;
        int   h=-1;
        int   k=2;

        // update the model
        for (i=0; i<nPoints; i++) {
          xptsPos[i] += (xptsVel[i] *= damping);  // update the positions
          yptsPos[i] += (yptsVel[i] *= damping);  // & advance the pointers
        }

        noFill();
        smooth();
        stroke(255, 255, 255, 144);
        int npm2 = nPoints-2;

        float xph, xpk, yph, ypk;
        float xpkmx0f, ypkmy0f, x3fmxph, y3fmyph;


        for (i=1; i<npm2; i++) {
          j=i+1;

          x0f = xptsPos[i];
          x3f = xptsPos[j];
          y0f = yptsPos[i];
          y3f = yptsPos[j];
          if ((abs(x0f - x3f ) + abs(y0f - y3f)) > minBezDist) {

            h=i-1;
            k=i+2;

            xph = xptsPos[h];
            yph = yptsPos[h];
            xpk = xptsPos[k];
            ypk = yptsPos[k];

            sx0 = x0f;
            sy0 = y0f;

            xpkmx0f = (xpk - x0f)*SPLINE_BIAS;
            ypkmy0f = (ypk - y0f)*SPLINE_BIAS;
            x3fmxph = (x3f - xph)*SPLINE_BIAS;
            y3fmyph = (y3f - yph)*SPLINE_BIAS; 

            // Someday soon, replace the following for() loop with:
            // vertex(x0f, y0f);
            // bezierVertex (x0f+xpkmx0f, y0f+y3fmyph, x3f-xpkmx0f, y3f-ypkmy0f, x3f, y3f);

            for (int p=0; p<nBezPoints; p++) {

              line (
                sx0, 
                sy0, 
                (sx1 = (onemt3[p]*x0f + bto2[p]*(x0f + x3fmxph) + bt2o[p]*(x3f - xpkmx0f) + bt3[p]*x3f)), 
                (sy1 = (onemt3[p]*y0f + bto2[p]*(y0f + y3fmyph) + bt2o[p]*(y3f - ypkmy0f) + bt3[p]*y3f)));
              sx0 = sx1;
              sy0 = sy1;
            }
          } else {
            line (x0f, y0f, x3f, y3f);
          }
        }
        noStroke();
      } 
      //
      else {
        //---------------------------------------
        // just update the model
        for (i=0; i<nPoints; i++) {
          xptsPos[i] += (xptsVel[i] *= damping);       // update the positions
          yptsPos[i] += (yptsVel[i] *= damping);       // & advance the pointers
        }
      }
    } else { // nSegs <= 1:
      if (nPoints > 0) {
        for (int i=0; i<nPoints; i++) {
          xptsPos[i] += (xptsVel[i] *= damping);
          yptsPos[i] += (yptsVel[i] *= damping);
        }
      }
    }
  }
}