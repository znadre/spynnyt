void drawOther() {
  int axisLength = 250;
  stroke(255);
  noFill();
  strokeWeight(2);
  box(2*axisLength);
  line(0, 0, 0, axisLength, 0, 0);
  line(0, 0, 0, 0, axisLength, 0);
  line(0, 0, 0, 0, 0, axisLength);

<<<<<<< Updated upstream
  line(0, 0, 0, axisLength*e1.x, axisLength*e1.y, axisLength*e1.z);
  line(0, 0, 0, axisLength*e2.x, axisLength*e2.y, axisLength*e2.z);
  line(0, 0, 0, axisLength*e3.x, axisLength*e3.y, axisLength*e3.z);
  
  //hint(DISABLE_DEPTH_TEST);
  //textSize(50);
  //fill(255);
  ////text("x", screenX(axisLength, 0, 0), screenY(axisLength, 0, 0));
  ////text("y", screenX(0, axisLength, 0), screenY(0, axisLength, 0));
  ////text("z", screenX(0, 0, axisLength), screenY(0, 0, axisLength));
  //text("wiener", 100,100);
  //hint(ENABLE_DEPTH_TEST);
  
  hud.beginDraw();
  hud.clear(); // Clear previous frame
  hud.fill(0, 0, 255);
  hud.ellipse(100, 100, 50, 50); // Draw ellipse at (100, 100)
  hud.endDraw();

  // Display the 2D shape on the screen
  image(hud, 0, 0);
=======
void drawHUD() {
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
  cam.endHUD();
}

void zdrawHUD() {
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
>>>>>>> Stashed changes
}

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
  } else {
    println("dummy");
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

boolean validValues() { // Inputted values have to be floats
  boolean check1 = !(float(Omega0x_textfield.getText()) != float(Omega0x_textfield.getText()));
  boolean check2 = !(float(Omega0y_textfield.getText()) != float(Omega0y_textfield.getText()));
  boolean check3 = !(float(Omega0z_textfield.getText()) != float(Omega0z_textfield.getText()));
  boolean check4 = !(float(MOIx_textfield.getText()) != float(MOIx_textfield.getText()));
  boolean check5 = !(float(MOIy_textfield.getText()) != float(MOIy_textfield.getText()));
  boolean check6 = !(float(MOIz_textfield.getText()) != float(MOIz_textfield.getText()));
  if (check1 && check2 &&  check3 &&  check4 &&  check5 &&  check6) {
    return true;
  }
  return false;
}
