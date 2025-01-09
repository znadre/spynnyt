class ZWindow extends PApplet {
float mouseXPrev, mouseYPrev;
float angle; // For panning calculation
float eyeDist = 500 / tan(PI/6);
float dt;
PVector eyePos = new PVector(eyeDist/sqrt(2), eyeDist/sqrt(2), 0);
PVector upwardsAxis = new PVector(0, 0, -1);

Object object;
PVector Omega; // In radians/sec; in the observer's frame
PVector omega; // In radians/sec; in the object's frame
PVector MOI;
PVector e1;
PVector e2;
PVector e3;

ZWindow(Object obj) {
  object = obj;
  Omega = object.Omega0.copy();
  omega = Omega.copy();
  MOI = object.MOI.copy();
  e1 = object.e1.copy();
  e2 = object.e2.copy();
  e3 = object.e3.copy();
}

void settings() {
  size(500, 500, P3D); // Set size of the second window
}

void setup() {
  background(200);
  frameRate(50);
  //registerMethod("mouseEvent", this);
}

void draw() {
  omegaRungeKuttaStep();
  eRungeKuttaStep();
  background(0);
  drawOther();
  camera(eyePos.x, eyePos.y, eyePos.z, 0, 0, 0, upwardsAxis.x, upwardsAxis.y, upwardsAxis.z);
  pushMatrix();
  applyMatrix(e1.x, e2.x, e3.x, 0.0,
    e1.y, e2.y, e3.y, 0.0,
    e1.z, e2.z, e3.z, 0.0,
    0.0, 0.0, 0.0, 1.0);
  object.drawObject(this);
  popMatrix();
}

void mousePressed(){
  mouseXPrev = mouseX;
  mouseYPrev = mouseY;
}
void mouseDragged(){
  // Left-right panning
  angle = (mouseX-mouseXPrev)/width * PI;
  if (upwardsAxis.dot(new PVector(0, 0, 1)) > 0) {
    angle *= -1;
  }
  rotateVectorAroundAxis(eyePos, new PVector(0, 0, 1), angle);
  rotateVectorAroundAxis(upwardsAxis, new PVector(0, 0, 1), angle);

  // Up-down panning
  angle = (mouseY-mouseYPrev)/height * PI;
  PVector rotationAxis = upwardsAxis.copy().cross(eyePos);
  rotateVectorAroundAxis(eyePos, rotationAxis, angle);
  rotateVectorAroundAxis(upwardsAxis, rotationAxis, angle);

  mouseXPrev = mouseX;
  mouseYPrev = mouseY;
}
void mouseWheel (MouseEvent event) {
  eyeDist += 20*event.getCount();
  eyeDist = constrain(eyeDist, 200, 1000);
  eyePos.normalize().mult(eyeDist);
}
  
void rotateVectorAroundAxis(PVector vector, PVector axis, float angle) {
  axis.normalize();
  PVector parallelComp = axis.copy().mult(vector.dot(axis));
  PVector perpendicularComp = vector.copy().sub(parallelComp);
  // Rotate perpendicularComp
  PVector w = axis.copy().cross(perpendicularComp); // Auxiliary vector
  perpendicularComp.mult(cos(angle)).add(w.mult(sin(angle))); // Rotation
  vector.set(parallelComp.add(perpendicularComp));
}

void drawOther() {
  stroke(255);
  noFill();
  strokeWeight(2);
  box(500);
  line(0, 0, 0, 250, 0, 0);
  line(0, 0, 0, 0, 250, 0);
  line(0, 0, 0, 0, 0, 250);
  textSize(50);
  fill(255);
  text("x", 255, 0, 0);
  text("y", 0, 255, 0);
  text("z", 0, 0, 255);

  line(0, 0, 0, 250*e1.x, 250*e1.y, 250*e1.z);
  line(0, 0, 0, 250*e2.x, 250*e2.y, 250*e2.z);
  line(0, 0, 0, 250*e3.x, 250*e3.y, 250*e3.z);
}

// Runge-Kutta 4th Order Method
void omegaRungeKuttaStep() {
  dt = 1.0/frameRate;
  double[] k1 = omegaComputeDerivatives(omega.x, omega.y, omega.z);

  double[] k2 = omegaComputeDerivatives(
    omega.x + 0.5 * dt * k1[0],
    omega.y + 0.5 * dt * k1[1],
    omega.z + 0.5 * dt * k1[2]
    );

  double[] k3 = omegaComputeDerivatives(
    omega.x + 0.5 * dt * k2[0],
    omega.y + 0.5 * dt * k2[1],
    omega.z + 0.5 * dt * k2[2]
    );

  double[] k4 = omegaComputeDerivatives(
    omega.x + dt * k3[0],
    omega.y + dt * k3[1],
    omega.z + dt * k3[2]
    );

  omega.x += (dt / 6.0) * (k1[0] + 2 * k2[0] + 2 * k3[0] + k4[0]);
  omega.y += (dt / 6.0) * (k1[1] + 2 * k2[1] + 2 * k3[1] + k4[1]);
  omega.z += (dt / 6.0) * (k1[2] + 2 * k2[2] + 2 * k3[2] + k4[2]);
}

void eRungeKuttaStep() {
  dt = 1.0/frameRate;
  Omega = e1.copy().mult(omega.x).add(e2.copy().mult(omega.y).add(e3.copy().mult(omega.z)));

  PVector[] k1 = eComputeDerivatives(e1, e2, e3);

  PVector[] k2 = eComputeDerivatives(
    e1.copy().add(k1[0].copy().mult(0.5 * dt)),
    e2.copy().add(k1[1].copy().mult(0.5 * dt)),
    e3.copy().add(k1[2].copy().mult(0.5 * dt))
  );

  PVector[] k3 = eComputeDerivatives(
    e1.copy().add(k2[0].copy().mult(0.5 * dt)),
    e2.copy().add(k2[1].copy().mult(0.5 * dt)),
    e3.copy().add(k2[2].copy().mult(0.5 * dt))
  );

  PVector[] k4 = eComputeDerivatives(
    e1.copy().add(k3[0].copy().mult(dt)),
    e2.copy().add(k3[1].copy().mult(dt)),
    e3.copy().add(k3[2].copy().mult(dt))
  );

  e1.add((k1[0].add(k2[0].copy().mult(2)).add(k3[0].copy().mult(2)).add(k4[0])).mult(dt / 6.0));
  e2.add((k1[1].add(k2[1].copy().mult(2)).add(k3[1].copy().mult(2)).add(k4[1])).mult(dt / 6.0));
  e3.add((k1[2].add(k2[2].copy().mult(2)).add(k3[2].copy().mult(2)).add(k4[2])).mult(dt / 6.0));

  e1.normalize();
  e2.normalize();
  e3.normalize();
}

// Function to compute derivatives based on Euler equations

double[] omegaComputeDerivatives(double omega_x, double omega_y, double omega_z) {
  double d_omega_x = ((MOI.y - MOI.z) / MOI.x) * omega_y * omega_z;
  double d_omega_y = ((MOI.z - MOI.x) / MOI.y) * omega_z * omega_x;
  double d_omega_z = ((MOI.x - MOI.y) / MOI.z) * omega_x * omega_y;
  return new double[]{d_omega_x, d_omega_y, d_omega_z};
}

PVector[] eComputeDerivatives(PVector E1, PVector E2, PVector E3) {
  PVector d_E1 = Omega.copy().cross(E1);
  PVector d_E2 = Omega.copy().cross(E2);
  PVector d_E3 = Omega.copy().cross(E3);
  return new PVector[]{d_E1, d_E2, d_E3};
}
}
