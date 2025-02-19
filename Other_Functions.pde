float axisLength = 250;

// HUD functions
void drawCoordSystem(PApplet window) {
  window.stroke(255);
  // x, y, z axes
  window.line(0,0,0, axisLength,0,0);
  window.line(0,0,0, 0,axisLength,0);
  window.line(0,0,0, 0,0,axisLength);
  
  window.noFill();
  window.stroke(200);
  // A cube
  window.box(2*axisLength);
}

void drawHUD() { // Draws x, y, z axis labels and the frame rate on the obsever's frame window
  PVector xAxisLabel = new PVector(screenX(axisLength+10, 0, 0), screenY(axisLength+10, 0, 0));
  PVector yAxisLabel = new PVector(screenX(0, axisLength+10, 0), screenY(0, axisLength+10, 0));
  PVector zAxisLabel = new PVector(screenX(0, 0, axisLength+10), screenY(0, 0, axisLength+10));

  cam.beginHUD();
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("x", xAxisLabel.x, xAxisLabel.y);
  text("y", yAxisLabel.x, yAxisLabel.y);
  text("z", zAxisLabel.x, zAxisLabel.y);
  
  textAlign(LEFT, TOP);
  textSize(25);
  text("Frame Rate: " + str(int(frameRate)), 20, 15);
  cam.endHUD();
}

void zdrawHUD() { // Draws x, y, z axis labels on the object's frame window
  PVector xAxisLabel = new PVector(zWindow.screenX(axisLength+10, 0, 0), zWindow.screenY(axisLength+10, 0, 0));
  PVector yAxisLabel = new PVector(zWindow.screenX(0, axisLength+10, 0), zWindow.screenY(0, axisLength+10, 0));
  PVector zAxisLabel = new PVector(zWindow.screenX(0, 0, axisLength+10), zWindow.screenY(0, 0, axisLength+10));

  zcam.beginHUD();
  zWindow.fill(255);
  zWindow.textSize(50);
  zWindow.textAlign(CENTER);
  zWindow.text("x", xAxisLabel.x, xAxisLabel.y);
  zWindow.text("y", yAxisLabel.x, yAxisLabel.y);
  zWindow.text("z", zAxisLabel.x, zAxisLabel.y);
  zcam.endHUD();
}





// Set/reset values
void setValues() { // After the user inputs the desired values, this runs the corresponding simulation
  if (validValues()) {
    object = selectedObject;

    object.userOmega0 = new PVector(
      float(Omega0x_textfield.getText()),
      float(Omega0y_textfield.getText()),
      float(Omega0z_textfield.getText()));
    object.userMOI = new PVector(
      float(MOIx_textfield.getText()),
      float(MOIy_textfield.getText()),
      float(MOIz_textfield.getText()));

    Omega = object.userOmega0.copy();
    omega = Omega.copy();
    MOI = object.userMOI.copy();
    e1 = object.e1.copy();
    e2 = object.e2.copy();
    e3 = object.e3.copy();
  } else { // Invalid value(s)
    drawInvalid = true;
    frameCountWhenTheUserClickedOnTheRunButtonAndTheValuesAreInvalid = controlWindow.frameCount;
  }
}

void resetValues() { // Reset the user values into the default values
  selectedObject.userOmega0 = selectedObject.Omega0.copy();
  selectedObject.userMOI = selectedObject.MOI.copy();
  showSelectedObjectValues();
}

void showSelectedObjectValues() { // Update the textfields with the selected object's values
  Omega0x_textfield.setText(str(selectedObject.userOmega0.x));
  Omega0y_textfield.setText(str(selectedObject.userOmega0.y));
  Omega0z_textfield.setText(str(selectedObject.userOmega0.z));

  MOIx_textfield.setText(str(selectedObject.userMOI.x));
  MOIy_textfield.setText(str(selectedObject.userMOI.y));
  MOIz_textfield.setText(str(selectedObject.userMOI.z));
}
