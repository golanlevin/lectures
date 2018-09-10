// Simple p5.js Clock Template
// Golan Levin, 2016-2018

var prevSec;
var millisRolloverTime;

//--------------------------
function setup() {
  createCanvas(300, 300);
  millisRolloverTime = 0;
}

//--------------------------
function draw() {
  background(255, 200, 200); // My favorite pink

  // Fetch the current time
  var H = hour();
  var M = minute();
  var S = second();

  // Reckon the current millisecond, 
  // particularly if the second has rolled over.
  // Note that this is more correct than using millis()%1000;
  if (prevSec != S) {
    millisRolloverTime = millis();
  }
  prevSec = S;
  var mils = floor(millis() - millisRolloverTime);

  noStroke();
  fill('black');
  var currTimeString = "Time: " + (H%12) + ":" + nf(M,2) + ":" + nf(S,2) + ((H>12) ? "pm":"am");
  text(currTimeString, 10, 25);
  text("Hour: "   + H, 10, 40);
  text("Minute: " + M, 10, 55);
  text("Second: " + S, 10, 70);
  text("Millis: " + mils, 10, 85);

  var hourBarWidth   = map(H, 0, 23, 0, width);
  var minuteBarWidth = map(M, 0, 59, 0, width);
  var secondBarWidth = map(S, 0, 59, 0, width);

  // Make a bar which *smoothly* interpolates across 1 minute.
  // We calculate a version that goes from 0...60, 
  // but with a fractional remainder:
  var secondsWithFraction = S + (mils / 1000.0);
  var secondsWithNoFraction = S;
  var secondBarWidthChunky = map(secondsWithNoFraction, 0, 60, 0, width);
  var secondBarWidthSmooth = map(secondsWithFraction,   0, 60, 0, width);

  fill(40);
  rect(0, 100, hourBarWidth, 50);
  fill(80);
  rect(0, 150, minuteBarWidth, 50);
  fill(120);
  rect(0, 200, secondBarWidthChunky, 50);
  fill(160);
  rect(0, 250, secondBarWidthSmooth, 50);
}