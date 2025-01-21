class ZWindow extends PApplet {
  //float eyeDist = 750;
  //PVector eyePos = new PVector(eyeDist/sqrt(2), eyeDist/sqrt(2), 0);
  //PVector upwardsAxis = new PVector(0, 0, 1);
  
  void settings() {
    size(600, 600, P3D);
  }
  void setup() {
    zcam = new PeasyCam(this, 0, 0, 0, 750); // Create a new PeasyCam instance with a distance of 500 units
    zcam.setMinimumDistance(100); // Set minimum zoom distance
    zcam.setMaximumDistance(1000); // Set maximum zoom distance
    zcam.setSuppressRollRotationMode();
    surface.setTitle("Object Frame");
  }
  void draw() {
    background(0);

    pushMatrix();
    scale(1, 1, -1); // Flip the Z axis to make the cordinate system right-handed
    rotateX(PI/2); // Rotations to align the starting camera posiion with the X axis
    rotateZ(-PI/2);
    
    object.drawObject(this);
    
    PMatrix3D matrix = new PMatrix3D(
      e1.x, e2.x, e3.x, 0.0,
      e1.y, e2.y, e3.y, 0.0,
      e1.z, e2.z, e3.z, 0.0,
      0.0, 0.0, 0.0, 1.0);
    matrix.invert();
    applyMatrix(matrix);
    
    drawCoordSystem(this);
    zdrawHUD();
    popMatrix();
  }
}
