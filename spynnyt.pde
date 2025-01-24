import g4p_controls.*; // Helps with graphical user interface
import peasy.*; // Allows camera control

PVector Omega; // In radians/sec; in the observer's frame
PVector omega; // In radians/sec; in the object's frame
PVector MOI; // Moment of inertia
PVector e1; // Unit vector along the x-axis of the object
PVector e2; // Unit vector along the y-axis of the object
PVector e3; // Unit vector along the z-axis of the object

ArrayList<Object> objects = new ArrayList<Object>();

PShape tennis_racket;

ZWindow zWindow = new ZWindow(); // This will be the window showing the object frame

boolean paused = false; // Pause/resume the simulation
float speed = 1; // Speed/slow down the simulation

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

  // Initializing zWindow
  String spath = "--sketch-path=" + zWindow.sketchPath();
  String loc = "--location=" + str(10) + "," + str(300);
  String className = zWindow.getClass().getName();
  String[] args = { spath, loc, className };

  PApplet.runSketch(args, zWindow);
  
  FTC(); // Check for a first time comer
  
  createGUI(); // Build G4P
  changeFont();
  
  loadData();
  showSelectedObjectValues();
  setValues();
}

void draw() {
  if (1==frameCount) {
    surface.setLocation(610, 0); // Move the main window to desired position
  }
  if (!paused) { // Move the simulation forward by one step
    omegaRungeKuttaStep();
    eRungeKuttaStep();
  }
  background(0);
  
  pushMatrix();
  // Align camera with x-axis
  scale(1, 1, -1); // Flip the Z axis to make the cordinate system right-handed
  rotateX(PI/2);
  rotateZ(-PI/2);
  
  // Add coord system to observer frame
  drawCoordSystem(this);
  drawHUD();
  
  // Draw the object
  PMatrix3D matrix = new PMatrix3D(
    e1.x, e2.x, e3.x, 0.0,
    e1.y, e2.y, e3.y, 0.0,
    e1.z, e2.z, e3.z, 0.0,
    0.0, 0.0, 0.0, 1.0);
  applyMatrix(matrix);
  object.drawObject(this);
  
  popMatrix();
}
