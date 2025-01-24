boolean drawInvalid = false;
float frameCountWhenTheUserClickedOnTheRunButtonAndTheValuesAreInvalid;

void drawINVALID() { // Draws INVALID VALUE(S) on the control window
  if (drawInvalid) {
    if (controlWindow.frameCount - frameCountWhenTheUserClickedOnTheRunButtonAndTheValuesAreInvalid < frameRate*0.5) { // Draw INVALID VALUE(S) within 0.5 sec
      controlWindow.pushMatrix();
      controlWindow.translate(270, 90);
      controlWindow.rotate(-PI/8);
      
      controlWindow.rectMode(CORNERS);
      controlWindow.fill(#00ff00);
      controlWindow.noStroke();
      controlWindow.rect(-60, 40, 60, -40);
      
      controlWindow.textAlign(CENTER, CENTER);
      controlWindow.textSize(26);
      controlWindow.fill(#ff0000);
      controlWindow.text("INVALID", 0, -13);
      controlWindow.text("VALUE(S)", 0, 13);
      
      controlWindow.popMatrix();
    } else {
      drawInvalid = false;
    }
  }
}

boolean validValues() { // Inputted values have to be floats
  boolean check1 = abs(float(Omega0x_textfield.getText())) <= 100;
  boolean check2 = abs(float(Omega0y_textfield.getText())) <= 100;
  boolean check3 = abs(float(Omega0z_textfield.getText())) <= 100;
  boolean check4 = float(MOIx_textfield.getText()) >= 1 && float(MOIx_textfield.getText()) <= 100;
  boolean check5 = float(MOIy_textfield.getText()) >= 1 && float(MOIy_textfield.getText()) <= 100;
  boolean check6 = float(MOIz_textfield.getText()) >= 1 && float(MOIz_textfield.getText()) <= 100;
  
  if (check1 && check2 && check3 && check4 && check5 && check6) {
    return true;
  }
  return false;
}
