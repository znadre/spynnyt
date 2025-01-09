void drawOther() {
  int axisLength = 250;
  stroke(255);
  noFill();
  strokeWeight(2);
  box(2*axisLength);
  line(0, 0, 0, axisLength, 0, 0);
  line(0, 0, 0, 0, axisLength, 0);
  line(0, 0, 0, 0, 0, axisLength);

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
}
