Object THandle = new Object("T-handle", 1, new PVector(0.01, 10, 0.01), new PVector(11, 12, 35));
Object IPhone = new Object("IPhone 12 Pro Max", 2, new PVector(0.1, 10, 0.1), new PVector(pow(78.1, 2), pow(160.8, 2), pow(78.1, 2)+pow(160.8, 2)));

ZWindow secondWindow = new ZWindow(THandle);
ZWindow thirdWindow = new ZWindow(IPhone);

// Second window class

// Launch the second window

void setup() {
  size(1000, 1000, P3D);

  String spath = "--sketch-path=" + secondWindow.sketchPath();
  String loc = "--location=" + str(100) + "," + str(100);
  String className = secondWindow.getClass().getName();
  String[] args = { spath, loc, className };
  PApplet.runSketch(args, secondWindow);
  
  //spath = "--sketch-path=" + thirdWindow.sketchPath();
  //loc = "--location=" + str(500) + "," + str(100);
  //className = thirdWindow.getClass().getName();
  //String[] args1 = { spath, loc, className };
  //PApplet.runSketch(args1, thirdWindow);
  
  //loc = "--location=" + str(100) + "," + str(500);
  //PApplet.runSketch(args, thirdWindow);
}

void draw() {
  
}
