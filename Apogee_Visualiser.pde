//James Doyle
class Apogee_Visualiser {
  
  //Declaring variables
  int apogee = -100;
  int perigee = -100;
  String length1 = "";
  Double diameter = null;

  String shape = "";
  String name = "";
  String State = "";
  String bus = "";
  PImage USFlagImg = loadImage("USA1.png");;
  PImage SUFlagImg = loadImage("SU.png");;

  PFont nameFont;
  
  boolean satelliteFound = false;
  
  public void draw() {
    //Drawing Earth
     fill(209,238,255);
     rect(table1X, table1Y, table1maxX + 30, table1maxY);
     getSatellite();
     noStroke();
     fill (34,207,34);
     ellipse(SCREENX-825, 400, 100, 100); 
     nameFont = loadFont("ArialNarrow-Bold-48.vlw");
     
     fill(0, 0);
     stroke(76,76,76);
     strokeWeight(8);
     //rect(table1X+780, table1Y, 200, 200);
     noStroke();
     //drawFrust(930, 130, 1);
     //image(USFlagImg, 930, 130);
    //Drawing satellite apogee, perigee, and name, if one has been entered by the user
    if (satelliteFound) {
      fill(0);
      textAlign(CENTER);
      textFont(nameFont);
      text(name, SCREENX-825, 150);
      text ("Apogee "+ apogee, SCREENX-825, 200);
      text ("Perigee "+ perigee, SCREENX-825, 250);
      fill (255,0,0);
      ellipse(SCREENX-825, 465 + perigee/100, 10, 10);
      fill (0,255,0);
      ellipse(SCREENX-825, 335 - apogee/100, 10, 10);
      
      stroke(0,255,0);
      strokeWeight(1);
      noFill();
      arc(float(SCREENX-825), float(400), float(2*(400-(335-(apogee/100)))), float(2*(400-(335-(apogee/100)))), 0.0, TWO_PI);
      stroke(255,0,0);
      strokeWeight(1);
      noFill();
      arc(float(SCREENX-825), float(400), float(2*(400-(335 - perigee/100))), float(2*(400-(335 - perigee/100))), 0.0, TWO_PI);
      
      if(shape.equalsIgnoreCase("cyl"))
      {
        drawCyllinder(910, 130, 1, length1, State, bus, diameter);
      }
      else if(shape.equalsIgnoreCase("frust"))
      {
        drawFrust(910, 130, 1, length1, State, diameter);
      }
      else if(shape.equalsIgnoreCase("sphere"))
      {
        drawSphere(910, 130, 1, length1, State, diameter); 
      }
      else if(shape.equalsIgnoreCase("cone"))
      {
        drawCone(910, 130, 1, length1, State, diameter);
      }
    }
  } 
  
  //Determining satellite to be displayed based on user input
  void getSatellite() {
    
    int satcat = 0;
    
    try {
      satcat = Integer.parseInt(collumn);
    }
    catch (NumberFormatException e) {
      satcat = -2137;
    }
    
    for (int i = 0; i < spaceObjects.size(); i++) {
    
       if (spaceObjects.get(i).name.equalsIgnoreCase(value)) {
        apogee = spaceObjects.get(i).apogee;
        perigee = spaceObjects.get(i).perigee;
        name = spaceObjects.get(i).name;
        shape = spaceObjects.get(i).shape;
        length1 = spaceObjects.get(i).lenght;
        State = spaceObjects.get(i).state;
        bus = spaceObjects.get(i).bus;
        diameter = spaceObjects.get(i).diameter;
        satelliteFound = true;
      }
      else if (!spaceObjects.get(i).satcat.equals("-") && Integer.parseInt(spaceObjects.get(i).satcat) == satcat) {
        apogee = spaceObjects.get(i).apogee;
        perigee = spaceObjects.get(i).perigee;
        name = spaceObjects.get(i).name;
        shape = spaceObjects.get(i).shape;
        length1 = spaceObjects.get(i).lenght;
        State = spaceObjects.get(i).state;
        bus = spaceObjects.get(i).bus;
        diameter = spaceObjects.get(i).diameter;
        satelliteFound = true;
      }    
    }
  }
  
  void drawCyllinder(int x, int y, int scale, String length1, String state, String bus, Double diameter)
  {
    float l = float(length1) * 8;
    float d = diameter.floatValue() * 8;

    fill(170);
    stroke(90);
    strokeWeight(2);
    ellipse(x, y+80+l, 80 + d, 40);
     
    noStroke();
    rect(x-40-(d/2), y, 80+d, 80+l);
    
    strokeWeight(2);
    stroke(90);
    ellipse(x, y, 80 + d, 30);   
    
    if(state.equalsIgnoreCase("us")) image(USFlagImg, x-21, y+((80)/2), width/30, height/24);
    if(state.equalsIgnoreCase("su")) image(SUFlagImg, x-21, y+((80)/2), width/30, height/24);
    fill(10);
    textSize(12);
    text(bus, x, y+((80)/2)+45);
  }
  
  void drawFrust(int x, int y, int scale, String length1, String state, Double diameter)
  {
    float l = float(length1) * 8;
    float d = diameter.floatValue() * 8;
    fill(170);  
    strokeWeight(2);
    stroke(90);
    ellipse(x, y+80+l, 120+d, 40);
     
    beginShape();
    vertex(x-60-(d/2),y+80+l);
    vertex(x-40-(d/2),y);
    
    vertex(x+40+(d/2),y);
    vertex(x+60+(d/2),y+80+l);
    // etc;
    endShape();

    strokeWeight(2);
    stroke(90);
    ellipse(x, y, 80+d, 30);   
    
    if(state.equalsIgnoreCase("us")) image(USFlagImg, x-22, y+((80)/2), width/30, height/24);
    if(state.equalsIgnoreCase("su")) image(SUFlagImg, x-22, y+((80)/2), width/30, height/24);
    
    fill(10);
    textSize(12);
    text(bus, x, y+((80)/2)+45);
  }
  
  void drawSphere(int x, int y, int scale, String length1, String state, Double diameter)
  {
    float l = float(length1) * 3;
    float d = diameter.floatValue() * 3;
    fill(170);
    stroke(90);
    strokeWeight(2);
    float center = y+35+(l/2);
    ellipse(x, center, 90+d, 90+l);
    
    //arc(x, center+10, 88+d, 20, 0, 2*HALF_PI);
    arc(x, center, 88+d, 20, 0, 2*HALF_PI);
    arc(x, y-5, 40, 8, 0, 2*HALF_PI);

    //ellipse(x, y, 40, 6);
    
    if(state.equalsIgnoreCase("us")) image(USFlagImg, x-22, y+((90+l)/4)-15, width/30, height/24);
    if(state.equalsIgnoreCase("su")) image(SUFlagImg, x-22, y+((90+l)/4)-15, width/30, height/24);
    
    fill(10);
    textSize(12);
    text(bus, x, y+((90+l)/4)+45);
  }
  
  void drawCone(int x, int y, int scale, String length1, String state, Double diameter)
  {
    float l = float(length1) * 8;
    float d = diameter.floatValue() * 8;
    fill(170);
    strokeWeight(2);
    stroke(90);
    ellipse(x, y+90+l, 98+d, 30);
     
    beginShape();
    vertex(x-50-(d/2),y+90+l);
    vertex(x,y);
    
    vertex(x+50+(d/2),y+90+l);
    // etc;
    endShape();
    //arc(x, y+15, 15, 5, 0, 2*HALF_PI);
    if(state.equalsIgnoreCase("us")) image(USFlagImg, x-22, y+((90+l)/2)+10, width/30, height/24);
    if(state.equalsIgnoreCase("su")) image(SUFlagImg, x-22, y+((90+l)/2)+10, width/30, height/24);
    
    fill(10);
    textSize(12);
    text(bus, x, y+((90+l)));
  }
}
