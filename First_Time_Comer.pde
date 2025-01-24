// Interface that leads a first time comer to use the program
boolean FTC = false;
int stageFTC = 0;

void drawFTC() {
  controlWindow.noFill();
  controlWindow.strokeWeight(3);
  controlWindow.rectMode(CORNERS);
  if (stageFTC == 0) {
    controlWindow.rect(10, 10, 195, 122);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Set the starting values for the object's angular velocity", 215, 60, 340, 300);
  } else if (stageFTC == 1) {
    controlWindow.rect(200, 10, 345, 55);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Set the object you want to showcase", 215, 85, 340, 300);
  } else if (stageFTC == 2) {
    controlWindow.rect(350, 10, 520, 122);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Set the starting values for the object's moment of inertia", 215, 60, 340, 300);
  } else if (stageFTC == 3) {
    controlWindow.rect(515, 40, 592, 99);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Run the simulation!", 230, 60, 340, 300);
  } else if (stageFTC == 4) {
    controlWindow.rect(25, 122, 350, 179);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Change the animation speed", 215, 60, 337, 299);
  } else if (stageFTC == 5) {
    controlWindow.rect(360, 120, 459, 177);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Pause or resume the animation", 215, 60, 337, 299);
  } else if (stageFTC == 6) {
    controlWindow.rect(475, 110, 565, 190);
    controlWindow.textAlign(LEFT, TOP);
    controlWindow.fill(0);
    controlWindow.textSize(16);
    controlWindow.text("Reset all values to the default values", 215, 60, 337, 299);
  }
}
