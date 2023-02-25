//Liam Murphy
class Bar_Chart{
  //Declaring local variables used in the class
  float scale;
  ArrayList<Space_Object> spaceObjects;
  HashMap<String, Integer> countries = new HashMap<String, Integer>();
  boolean newCountry = true;
  int arrayListLength;
  float barHeightUS;
  float barHeightSU;
  float barHeightOther;
  PFont nameFont;
  
  //Constructor for the class
  Bar_Chart(ArrayList<Space_Object> spaceObjects, float scale){
    this.spaceObjects = spaceObjects;
    this.scale = scale;
    arrayListLength = spaceObjects.size();
    //Adding countries to hashmap
    countries.put("US", 0);
    countries.put("SU", 0);
    countries.put("Other", 0);
  }
  
  //Get the height of the individual bars
  void createBars(){
    for(int i = 0; i < arrayListLength; i++){
      //Increment value with key US in hashmap
      if(spaceObjects.get(i).state.equalsIgnoreCase("US")){
        int currentValue = countries.get("US");
        currentValue++;
        countries.replace("US", currentValue);
      }
      //Increment value with key SU in hashmap
      else if(spaceObjects.get(i).state.equalsIgnoreCase("SU")){
        int currentValue = countries.get("SU");
        currentValue++;
        countries.replace("SU", currentValue);
      }
      //Increment value with key other in hashmap
      else{
        int currentValue = countries.get("Other");
        currentValue++;
        countries.replace("Other", currentValue);
      }
    }
    
    //Calculate the height of the bars in the bar chart
    barHeightUS = countries.get("US") * scale * -1;
    barHeightSU = countries.get("SU") * scale * -1;
    barHeightOther = countries.get("Other") * scale * -1;
    
  }
  //Draw the bar chart
  void draw(){
    nameFont = loadFont("ArialNarrow-Bold-48.vlw");
    //Draw the bar chart
    noStroke();
    fill(250);
    rect(table1X, table1Y, table1maxX + 30, table1maxY);
    fill(0, 0, 180);
    rect(table1X + 100, 600, 100, barHeightUS);
    fill(180, 0, 0);
    rect(table1X + 300, 600, 100, barHeightSU);
    fill(0);
    rect(table1X + 500, 600, 100, barHeightOther);
    stroke(0);
    strokeWeight(2);
    line(table1X + 50, 600, 675, 600);
    line(table1X + 50, 600, table1X + 50, 110);
    noStroke();
    textSize(24);
    text("US", table1X + 130, 625);
    text("SU", table1X + 330, 625);
    text("Other", table1X + 520, 625);
    textSize(36);
    textFont(nameFont);
    stdFont=loadFont("LucidaSansUnicode-12.vlw");
    text("Number of satellites by country", 180, 150);
    textSize(36);
    text(countries.get("US"), table1X + 105, 600 + barHeightUS - 10);
    text(countries.get("SU"), table1X + 305, 600 + barHeightSU - 10);
    text(countries.get("Other"), table1X + 505, 600 + barHeightOther - 10);
  }
}
