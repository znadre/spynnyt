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
void mouseWheel(MouseEvent event) {
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
