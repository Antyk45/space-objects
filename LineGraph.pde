//Liam Murphy
class LineGraph{
  //Declare local variables
  ArrayList<Space_Object> spaceObjects;
  Space_Object currentObject;
  Integer startYear;
  Integer endYear;
  float xDifference;
  int numOfSpaceObjects;
  float xSizeOfLineGraph;
  float ySizeOfLineGraph;
  float scale;
  float intervalBetweenPoints;
  float amountOfYears;
  float yScale;
  Integer highestNumber = 0;
  Integer lowestNumber = 0;
  
  
  //Create hashmaps
  HashMap<Integer, Integer> satellitesByYear = new HashMap<Integer, Integer>();
  HashMap<Float, Float> coordinates = new HashMap<Float, Float>();
  PFont nameFont;
  
  //Constructor to initialise values
  LineGraph(ArrayList<Space_Object> spaceObjects, float xSize, float ySize, float scale, int startYear, int endYear){
      this.spaceObjects = spaceObjects;
      this.xSizeOfLineGraph = xSize;
      this.scale = scale;
      this.ySizeOfLineGraph = ySize;
      this.startYear = startYear;
      this.endYear = endYear;
      numOfSpaceObjects = spaceObjects.size();
  }
  
  // Get the coordinates of the points in the line graph
  void createLineGraph(){
    for(int year = startYear; year <= endYear; year++){
        //Add each year to the hashmap
        satellitesByYear.put(year, 0);
        int currentCount = 0;
        for(int i = 0; i < numOfSpaceObjects; i++){
          currentObject = spaceObjects.get(i);          
          if(!currentObject.isNullDate){
            //Increment currentCount if new satellite is launched
            if(year == currentObject.launchDate.getYear()){
              currentCount++;
            }
            //Decrement currentCount if satellite is decommissioned
            if(year == currentObject.decommissionedYear){
              currentCount--;
              
            }
          }
        }
        //Add currentCount to the hashMap using the year as the key including the count from the previous year
        if(year != startYear){
          satellitesByYear.replace(year, satellitesByYear.get(year - 1) + currentCount);
          
        }
        //Add currentCount to the hashMap using the year as the key
        else{
          satellitesByYear.replace(year, currentCount);
          highestNumber = currentCount;
          lowestNumber = currentCount;
        }  
        
    }  
    
    amountOfYears = satellitesByYear.size();
    intervalBetweenPoints = xSizeOfLineGraph / amountOfYears;
    yScale = 1 * scale;
    float counter = 1;
    //Load coordinate values into the coordinate hashMap using the X values as the key with the corresponding Y value also stored
    for(int i = startYear; i <= endYear; i++){
      if(satellitesByYear.get(i) > highestNumber) highestNumber = satellitesByYear.get(i);
      if(satellitesByYear.get(i) < lowestNumber) lowestNumber = satellitesByYear.get(i);
      coordinates.put(counter, ((float) (satellitesByYear.get(i))));
      counter++;
    }
    
  }
  
  //Draw the line graph
  void draw(PFont stdFont){
      getYears();
    nameFont = loadFont("ArialNarrow-Bold-48.vlw");
      fill(250);
      rect(table1X, table1Y, table1maxX + 30, table1maxY);
      fill(0);
    for(float i = 2; i < coordinates.size(); i++){
      stroke(2);
      strokeWeight(2);
      //Draw lines between the coordinates stored in the hashMap
      
      
        line(((i - 1) * xDifference) + 100, ySizeOfLineGraph - coordinates.get(i - 1) * scale, (i * xDifference) + 100, ySizeOfLineGraph - coordinates.get(i) * scale);
      
    }
      xDifference = 610.0 / amountOfYears;
      line(table1X+40, 555, 700, 555);
      line(table1X+40, 555, table1X+40, 250);
      textFont(stdFont);
      text("Max number", table1X + 60, (ySizeOfLineGraph - highestNumber * scale) - 20);
      text(highestNumber.toString(), table1X + 60, ySizeOfLineGraph - highestNumber * scale);
      textFont(nameFont);
      textSize(48);
      text("Number of satellites in orbit over time", 80, 150);
      textSize(12);
      text(startYear.toString(), table1X + 45, 570);
      text(endYear.toString(), 695, 570);
      noStroke();
      println(xDifference);
      stroke(0);
      strokeWeight(2);
      
  }
  
  void getYears(){
    startYear = 1957;
    endYear = 2022;
    
    
    try {
      endYear = Integer.parseInt(value);
      satellitesByYear.clear();
      coordinates.clear();
      createLineGraph();
    }
    catch (NumberFormatException e) {
      endYear = 2022;
    }
  
  
  }
}
