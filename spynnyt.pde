import g4p_controls.*;
import peasy.*;

PVector Omega; // In radians/sec; in the observer's frame
PVector omega; // In radians/sec; in the object's frame
PVector MOI;
PVector e1;
PVector e2;
PVector e3;

ArrayList<Object> objects = new ArrayList<Object>();

PShape tennis_racket;
ZWindow zWindow = new ZWindow();

boolean paused = false;
float speed = 1;

PeasyCam cam;
PeasyCam zcam;

// These variables have data needed to be saved
Object THandle = new Object("T-handle", 0, new PVector(0.01, 5, 0.01), new PVector(11, 12, 35));
Object IPhone = new Object("IPhone 12 Pro Max", 1, new PVector(0.1, 5, 0.1), new PVector(round(pow(78.1, 2)/350), round(pow(160.8, 2)/350), round((pow(78.1, 2)+pow(160.8, 2))/350)));
Object frisbee = new Object("Frisbee", 2, new PVector(0.1, 5, 0.1), new PVector(1, 1, 2));
Object racket = new Object("Tennis Racket", 3, new PVector(0.1, 5, 0.1), new PVector(2, 30, 32));
Object object = THandle; // This is the object being displayed
Object selectedObject = THandle; // This is the object "on deck", selected in the control window

void setup() {
  size(855, 855, P3D);

  tennis_racket = loadShape("tennis_racket.obj");

  cam = new PeasyCam(this, 0, 0, 0, 750); // Create a new PeasyCam instance with a distance of 500 units
  cam.setMinimumDistance(100); // Set minimum zoom distance
  cam.setMaximumDistance(1000); // Set maximum zoom distance
  cam.setSuppressRollRotationMode(); // Set the desired rotation mode

  String spath = "--sketch-path=" + zWindow.sketchPath();
  String loc = "--location=" + str(10) + "," + str(300);
  String className = zWindow.getClass().getName();
  String[] args = { spath, loc, className };

  PApplet.runSketch(args, zWindow);

  FTC();
  createGUI();
  changeFont();
  
  loadData();
  showSelectedObjectValues();
  setValues();
}

void draw() {
  if (1==frameCount) {
    surface.setLocation(610, 0);
  }
  if (!paused) {
    omegaRungeKuttaStep();
    eRungeKuttaStep();
  }
  background(0);

  pushMatrix();
  scale(1, 1, -1);
  rotateX(PI/2);
  rotateZ(-PI/2);

  drawCoordSystem(this);
  drawHUD();

  PMatrix3D matrix = new PMatrix3D(
    e1.x, e2.x, e3.x, 0.0,
    e1.y, e2.y, e3.y, 0.0,
    e1.z, e2.z, e3.z, 0.0,
    0.0, 0.0, 0.0, 1.0);
  applyMatrix(matrix);
  object.drawObject(this);
  popMatrix();
}

void FTC() {
  String[] userControlData = loadStrings("data/control_data.txt");
  
  if (userControlData.length == 0) {
    FTC = true;
  }
}

void loadData() {
  String[] userControlData = loadStrings("data/control_data.txt");

  // Not first time comer
  if (!FTC) {
    String[] objectsUsed = userControlData[0].split("\t"); // Determines variables: object, selectedObject
    object = objects.get(int(objectsUsed[0]));
    selectedObject = objects.get(int(objectsUsed[1]));

    for (int i = 1; i < userControlData.length; i++ ) {
      String[] objectData = userControlData[i].split("\t");
      objects.get(i-1).userOmega0 = new PVector(float(objectData[0]), float(objectData[1]), float(objectData[2]));
      objects.get(i-1).userMOI = new PVector(float(objectData[3]), float(objectData[4]), float(objectData[5]));
    }

    obj_droplist.setSelected(objects.indexOf(selectedObject));
  }
}

void saveData() {
  String[] userControlData = new String[objects.size()+1];
  userControlData[0] = str(objects.indexOf(object)) + "\t" + str(objects.indexOf(selectedObject));

  for (int i = 1; i < userControlData.length; i++) {
    Object savedObject = objects.get(i-1);
    userControlData[i] =
      str(savedObject.userOmega0.x) + "\t" +
      str(savedObject.userOmega0.y) + "\t" +
      str(savedObject.userOmega0.z) + "\t" +
      str(savedObject.userMOI.x) + "\t" +
      str(savedObject.userMOI.y) + "\t" +
      str(savedObject.userMOI.z);
  }

  saveStrings("data/control_data.txt", userControlData);
}
