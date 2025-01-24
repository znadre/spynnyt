// Everything from G4P makes up the control window

synchronized public void controlWindow_draw(PApplet appc, GWinData data) {
  appc.background(230);
  if (FTC) {
    drawFTC();
  }
  drawINVALID();
}

public void pause_resume_click(GButton source, GEvent event) {
  paused = !paused;
  if (paused) {
    source.setText("Resume");
  } else {
    source.setText("Pause");
  }
}

public void speed_slider_change(GSlider source, GEvent event) {
  speed = source.getValueF();
}

public void obj_droplist_click(GDropList source, GEvent event) {
  if (event == GEvent.SELECTED) {
    // Get the selected item
    int selected = source.getSelectedIndex();
    selectedObject = objects.get(selected);
  }
  showSelectedObjectValues();
  saveData();
}

public void Omega0x_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void Omega0y_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void Omega0z_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void MOIx_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void MOIy_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void MOIz_textfield_change(GTextField source, GEvent event) {
  saveData();
}

public void setValues_click(GButton source, GEvent event) {
  setValues();
  saveData();
}

public void resetValues_click(GButton source, GEvent event) {
  resetValues();
  saveData();
}

public void nextFTC_click(GButton source, GEvent event) {
  stageFTC++; // Move the next button to different positions during the tutorial
  if (stageFTC == 1) {
    source.moveTo(300,50);
  } else if (stageFTC == 2) {
    source.moveTo(430,100);
  } else if (stageFTC == 3) {
    source.moveTo(530,15);
  } else if (stageFTC == 4) {
    source.moveTo(230,100);
  } else if (stageFTC == 5) {
    source.moveTo(430,100);
  } else if (stageFTC == 6) {
    source.moveTo(430,100);
    source.setText("End");
  } else {
    source.setVisible(false);
  }
}



// Create all the GUI controls
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Observer Frame");
  controlWindow = GWindow.getWindow(this, "Control Window", 0, 0, 600, 200, JAVA2D);
  controlWindow.noLoop();
  controlWindow.setActionOnClose(G4P.KEEP_OPEN);
  controlWindow.addDrawHandler(this, "controlWindow_draw");
  pause_resume = new GButton(controlWindow, 370, 130, 80, 40);
  pause_resume.setTextAlign(GAlign.CENTER, GAlign.BOTTOM);
  pause_resume.setText("Pause");
  pause_resume.addEventHandler(this, "pause_resume_click");
  speed_slider = new GSlider(controlWindow, 40, 110, 300, 80, 10.0);
  speed_slider.setShowValue(true);
  speed_slider.setShowLimits(true);
  speed_slider.setLimits(1.0, 0.0, 3.0);
  speed_slider.setNbrTicks(4);
  speed_slider.setShowTicks(true);
  speed_slider.setNumberFormat(G4P.DECIMAL, 2);
  speed_slider.setOpaque(false);
  speed_slider.addEventHandler(this, "speed_slider_change");
  obj_droplist = new GDropList(controlWindow, 210, 20, 130, 100, 3, 10);
  obj_droplist.setItems(loadStrings("object_list.txt"), 0);
  obj_droplist.addEventHandler(this, "obj_droplist_click");
  Omega0x_textfield = new GTextField(controlWindow, 60, 20, 120, 20, G4P.SCROLLBARS_NONE);
  Omega0x_textfield.setOpaque(true);
  Omega0x_textfield.addEventHandler(this, "Omega0x_textfield_change");
  Omega0y_textfield = new GTextField(controlWindow, 60, 50, 120, 20, G4P.SCROLLBARS_NONE);
  Omega0y_textfield.setOpaque(true);
  Omega0y_textfield.addEventHandler(this, "Omega0y_textfield_change");
  Omega0z_textfield = new GTextField(controlWindow, 60, 80, 120, 20, G4P.SCROLLBARS_NONE);
  Omega0z_textfield.setOpaque(true);
  Omega0z_textfield.addEventHandler(this, "Omega0z_textfield_change");
  MOIx_textfield = new GTextField(controlWindow, 390, 20, 120, 20, G4P.SCROLLBARS_NONE);
  MOIx_textfield.setOpaque(true);
  MOIx_textfield.addEventHandler(this, "MOIx_textfield_change");
  MOIy_textfield = new GTextField(controlWindow, 390, 50, 120, 20, G4P.SCROLLBARS_NONE);
  MOIy_textfield.setOpaque(true);
  MOIy_textfield.addEventHandler(this, "MOIy_textfield_change");
  MOIz_textfield = new GTextField(controlWindow, 390, 80, 120, 20, G4P.SCROLLBARS_NONE);
  MOIz_textfield.setOpaque(true);
  MOIz_textfield.addEventHandler(this, "MOIz_textfield_change");
  Omega0x_label = new GLabel(controlWindow, 23, 20, 40, 30);
  Omega0x_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Omega0x_label.setText("Ωx");
  Omega0x_label.setOpaque(false);
  Omega0y_label = new GLabel(controlWindow, 23, 50, 40, 30);
  Omega0y_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Omega0y_label.setText("Ωy");
  Omega0y_label.setOpaque(false);
  Omega0z_label = new GLabel(controlWindow, 23, 80, 40, 30);
  Omega0z_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Omega0z_label.setText("Ωz");
  Omega0z_label.setOpaque(false);
  OmegaRange_label = new GLabel(controlWindow, 3, 100, 80, 30);
  OmegaRange_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  OmegaRange_label.setText("-10 ~ 10");
  OmegaRange_label.setOpaque(false);
  Ix_label = new GLabel(controlWindow, 355, 20, 40, 30);
  Ix_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Ix_label.setText("Ix");
  Ix_label.setOpaque(false);
  Iy_label = new GLabel(controlWindow, 355, 50, 40, 30);
  Iy_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Iy_label.setText("Iy");
  Iy_label.setOpaque(false);
  Iz_label = new GLabel(controlWindow, 355, 80, 40, 30);
  Iz_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Iz_label.setText("Iz");
  Iz_label.setOpaque(false);
  IRange_label = new GLabel(controlWindow, 335, 100, 80, 30);
  IRange_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  IRange_label.setText("1 ~ 100");
  IRange_label.setOpaque(false);
  setValues = new GButton(controlWindow, 525, 50, 60, 40);
  setValues.setTextAlign(GAlign.CENTER, GAlign.BOTTOM);
  setValues.setText("Run");
  setValues.addEventHandler(this, "setValues_click");
  resetValues = new GButton(controlWindow, 480, 115, 80, 70);
  resetValues.setTextAlign(GAlign.CENTER, GAlign.BOTTOM);
  resetValues.setText("Reset Values");
  resetValues.addEventHandler(this, "resetValues_click");
  nextFTC = new GButton(controlWindow, 150, 100, 50, 30);
  nextFTC.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  nextFTC.setText("Next");
  nextFTC.addEventHandler(this, "nextFTC_click");
  nextFTC.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  if (!FTC) { // No FTC tutorial, no "next" button
    nextFTC.setVisible(false);
  }
  controlWindow.loop();
}

// Variable declarations 
GWindow controlWindow;
GButton pause_resume; 
GSlider speed_slider; 
GDropList obj_droplist; 
GTextField Omega0x_textfield; 
GTextField Omega0y_textfield; 
GTextField Omega0z_textfield; 
GTextField MOIx_textfield; 
GTextField MOIy_textfield; 
GTextField MOIz_textfield; 
GLabel Omega0x_label; 
GLabel Omega0y_label; 
GLabel Omega0z_label;
GLabel OmegaRange_label;
GLabel Ix_label; 
GLabel Iy_label; 
GLabel Iz_label; 
GLabel IRange_label;
GButton setValues; 
GButton resetValues; 
GButton nextFTC; 
