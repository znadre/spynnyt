void loadData() {
  String[] userControlData = loadStrings("data/control_data.txt");

  // Not first time comer
  if (!FTC) {
    // Determine variables: object, selectedObject
    String[] objectsUsed = userControlData[0].split("\t");
    object = objects.get(int(objectsUsed[0]));
    selectedObject = objects.get(int(objectsUsed[1]));
    
    // Determine all the associated Omega0 and MOI values for each object
    for (int i = 1; i < userControlData.length; i++ ) {
      String[] objectData = userControlData[i].split("\t");
      objects.get(i-1).userOmega0 = new PVector(float(objectData[0]), float(objectData[1]), float(objectData[2]));
      objects.get(i-1).userMOI = new PVector(float(objectData[3]), float(objectData[4]), float(objectData[5]));
    }
    
    // Select the selectedObject in the droplist
    obj_droplist.setSelected(objects.indexOf(selectedObject));
  }
}

void saveData() {
  String[] userControlData = new String[objects.size()+1];
  
  // Determine variables: object, selectedObject
  userControlData[0] = str(objects.indexOf(object)) + "\t" + str(objects.indexOf(selectedObject));
  
  // Determine all the associated Omega0 and MOI values for each object
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
