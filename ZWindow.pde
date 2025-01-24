class ZWindow extends PApplet { // The object's frame window
  void settings() {
    size(600, 600, P3D);
  }
  void setup() {
    zcam = new PeasyCam(this, 0, 0, 0, 750); // Create a new PeasyCam instance with a distance of 500 units
    zcam.setMinimumDistance(100); // Set minimum zoom distance
    zcam.setMaximumDistance(1000); // Set maximum zoom distance
    zcam.setSuppressRollRotationMode(); // Set the desired rotation mode
    surface.setTitle("Object Frame");
  }
  void draw() {
    background(0);

    pushMatrix();
    scale(1, 1, -1); // Flip the Z axis to make the cordinate system right-handed
    rotateX(PI/2+0.5); // Rotations to align the starting camera posiion with the X axis
    rotateZ(-PI/2);
    
    // Draw the object
    object.drawObject(this);
    
    PMatrix3D matrix = new PMatrix3D(
      e1.x, e2.x, e3.x, 0.0,
      e1.y, e2.y, e3.y, 0.0,
      e1.z, e2.z, e3.z, 0.0,
      0.0, 0.0, 0.0, 1.0);
    matrix.invert();
    applyMatrix(matrix);
    
    // Add coord system to object frame
    drawCoordSystem(this);
    zdrawHUD();
    popMatrix();
  }
}
