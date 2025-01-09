float mouseXPrev, mouseYPrev;
float angle; // For panning calculation
float eyeDist = 500 / tan(PI/6);
float dt;
PVector eyePos = new PVector(eyeDist/sqrt(2), eyeDist/sqrt(2), 0);
PVector upwardsAxis = new PVector(0, 0, 1);

PVector Omega; // In radians/sec; in the observer's frame
PVector omega; // In radians/sec; in the object's frame
PVector MOI;
PVector e1;
PVector e2;
PVector e3;

Object THandle = new Object("T-handle", 1, new PVector(0.01, 10, 0.01), new PVector(11, 12, 35));
Object IPhone = new Object("IPhone 12 Pro Max", 2, new PVector(0.1, 10, 0.1), new PVector(pow(78.1, 2), pow(160.8, 2), pow(78.1, 2)+pow(160.8, 2)));
Object object = THandle;

// Launch the second window

void setup() {
  size(1000, 1000, P3D);
  
  Omega = object.Omega0.copy();
  omega = Omega.copy();
  MOI = object.MOI.copy();
  e1 = object.e1.copy();
  e2 = object.e2.copy();
  e3 = object.e3.copy();
}

void draw() {
  omegaRungeKuttaStep();
  eRungeKuttaStep();
  background(0);
  
  camera(eyePos.x, eyePos.y, eyePos.z, 0, 0, 0, upwardsAxis.x, upwardsAxis.y, upwardsAxis.z);
  
  pushMatrix();
  scale(1, 1, -1);
  drawOther();
  applyMatrix(
    e1.x, e2.x, e3.x, 0.0,
    e1.y, e2.y, e3.y, 0.0,
    e1.z, e2.z, e3.z, 0.0,
    0.0, 0.0, 0.0, 1.0);
  object.drawObject(this);
  popMatrix();
}
