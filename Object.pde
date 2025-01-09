public class Object {
  // Variables
  String name;
  int label;
  PVector Omega0;
  PVector MOI;
  PVector e1 = new PVector(1, 0, 0);
  PVector e2 = new PVector(0, 1, 0);
  PVector e3 = new PVector(0, 0, 1);

  Object(String n, int l, PVector w, PVector m) {
    this.name = n;
    this.label = l;
    this.Omega0 = w;
    this.MOI = m;
  }

  void drawObject(PApplet app) {
    if (label == 1) {
      float a = 60;
      app.noStroke();
      app.fill(255);
      app.rectMode(CENTER);
      app.rect(0, -a/6, a*2, 15);
      app.rect(0, a/3, 15, a);
    } else if (label == 2) {
      float l = 160.8;
      float w = 78.1;
      float h = 7.4;
      app.noStroke();
      app.fill(255);
      app.box(l, w, h);
      app.rectMode(CENTER);
      app.translate(0, 0, h/2+1);
      app.fill(#73000c);
      app.rect(0, 0, l, w);
      app.translate(0, 0, -h-2);
      app.fill(#5dadeb);
      app.rect(0, 0, l, w);
    }
  }
}
