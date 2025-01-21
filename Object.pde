public class Object {
  // Variables
  String name;
  int label;
  PVector Omega0;
  PVector MOI;
  PVector userOmega0;
  PVector userMOI;
  PVector e1 = new PVector(1, 0, 0);
  PVector e2 = new PVector(0, 1, 0);
  PVector e3 = new PVector(0, 0, 1);

  Object(String n, int l, PVector w, PVector m) {
    name = n;
    label = l;
    Omega0 = userOmega0 = w;
    MOI = userMOI = m;
    objects.add(this);
  }

  void drawObject(PApplet window) {
    if (label == 0) {
      float a = 60;
      window.noStroke();
      window.fill(255);
      window.rectMode(CENTER);
      window.rect(0, -a/6, a*2, 15);
      window.rect(0, a/3, 15, a);
    } else if (label == 1) {
      float l = 160.8;
      float w = 78.1;
      float h = 7.4;
      window.noStroke();
      window.fill(255);
      window.box(l, w, h);
      window.rectMode(CENTER);
      window.translate(0, 0, h/2+1);
      window.fill(#73000c);
      window.rect(0, 0, l, w);
      window.translate(0, 0, -h-2);
      window.fill(#5dadeb);
      window.rect(0, 0, l, w);
    } else if (label == 2) {
      window.noStroke();
      window.fill(200);
      window.circle(0, 0, 200);
    } else if (label == 3) {
      window.pushMatrix();
      window.scale(5); // Increase size
      window.translate(-5, 0, 0); // Align center of mass of racket
      window.rotateZ(-PI/2); // Align the handle with x axis

      window.shape(tennis_racket);
      window.popMatrix();
    }
  }
}
