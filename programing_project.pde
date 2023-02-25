import java.time.LocalDate; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.time.format.*;

DataIO data = new DataIO();
PFont stdFont;
public static ArrayList<Space_Object> spaceObjects;
int currentScreen;
final int EVENT_NULL = 0;
public static int event;
public static ArrayList<Screen> screens;
public static ArrayList<Widget> currentWidgets;
public static ArrayList<TextWidget> currentTextWidgets;
Bar_Chart barChart;
Apogee_Visualiser apogeeVisualiser;
boolean barChartDisplay = false;
boolean apogeeVisualDisplay = false;
boolean upperValuePresent = false;
boolean lineGraphDisplay = false;
boolean tableDisplay = true;
int table1X;
int table1Y;
int table1maxX;
int table1maxY;
TableGUI table1;
LineGraph lineGraph;

void setup() {
  stdFont=loadFont("LucidaSansUnicode-12.vlw");
  size(1280, 720);
  table1X = 50;
  table1Y = 80;
  table1maxX = 940;
  table1maxY = 550;
  addScreens();

  spaceObjects = new ArrayList();
  data.readData();


  barChart = new Bar_Chart(spaceObjects, 0.016);
  barChart.createBars();

  lineGraph = new LineGraph(spaceObjects, 500, 550, 0.1, 1957, 1970);
  lineGraph.createLineGraph();

  apogeeVisualiser = new Apogee_Visualiser();

  table1 = new TableGUI(table1X, table1Y, table1maxX, table1maxY, 9, 16, 100, 30, spaceObjects, 0);
}

void draw() {
  background(28, 25, 54);
  if (currentScreen == 0) {
    screens.get(0).draw();
  } else if (currentScreen == 1) {
    screens.get(1).draw();
  }
  if (barChartDisplay)
  {
    barChart.draw();
  } else if (apogeeVisualDisplay) {
    apogeeVisualiser.draw();
  } else if (lineGraphDisplay) {
    lineGraph.draw(stdFont);
  } else
  {
    table1.draw();
  }
  noahsAttemptAtMakingThingsLookNicer();
}

void mousePressed() {
  if (currentScreen == 0) {
    currentWidgets = screens.get(0).buttons;
  } else if (currentScreen == 1) {
    currentWidgets = screens.get(1).buttons;
  }
  int event;
  for (int i = 0; i<currentWidgets.size(); i++) {
    Widget aWidget = (Widget) currentWidgets.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    //println(event);
    switch(event) {
    case 1:
      println("You pressed a button");
      currentScreen = 1;
      break;
    case 2:
      println("You pressed a button");
      if (barChartDisplay) barChartDisplay = false;
      else if (!barChartDisplay) barChartDisplay = true;
      apogeeVisualDisplay = false;
      lineGraphDisplay = false;
      tableDisplay = false;
      addScreens();
      break;
    case 3:
      println("You pressed a button");
      if (!barChartDisplay && table1.startingObjectIndex < table1.spaceObjects.size()) {
        table1.startingObjectIndex -= 1;
        table1.y = table1Y;
        table1.generate(table1.tempSpaceObjects);
      }
      break;
    case 4:
      println("You pressed a button");
      currentScreen = 0;
      break;
    case 6:
      println("You pressed a button");
      if (!barChartDisplay) {
        if (table1.startingObjectIndex >= 31)
        {
          table1.startingObjectIndex -= 31;
          table1.y = table1Y;
          table1.generate(spaceObjects);
        }
      }
      break;
    case 8:
      println("You pressed a button");
      if (tableDisplay) tableDisplay = false;
      else tableDisplay = true;
      table1 = new TableGUI(table1X, table1Y, table1maxX, table1maxY, 9, 16, 100, 30, spaceObjects, 0);
      barChartDisplay = false;
      apogeeVisualDisplay = false;
      lineGraphDisplay = false;
      addScreens();

      break;
    case 7:
      println("You pressed a button");
      if (apogeeVisualDisplay) apogeeVisualDisplay = false;
      else apogeeVisualDisplay = true;
      barChartDisplay = false;
      lineGraphDisplay = false;
      tableDisplay = false;
      addScreens();
      break;

    case 9:
      println("You pressed a button");
      if (lineGraphDisplay) lineGraphDisplay = false;
      else lineGraphDisplay = true;
      barChartDisplay = false;
      apogeeVisualDisplay = false;
      tableDisplay = false;
      addScreens();
      break;

    case 10:
      for (int b = 0; b < 30; b++) {
        if (!barChartDisplay && table1.startingObjectIndex < table1.spaceObjects.size()) {
          table1.startingObjectIndex -= 1;
          table1.y = table1Y;
          table1.generate(table1.tempSpaceObjects);
        }
      }
      break;

    case 11:
      for (int a = 0; a < 30; a++) {
        if (!barChartDisplay) {
          if (table1.startingObjectIndex >= 31)
          {
            table1.startingObjectIndex -= 31;
            table1.y = table1Y;
            table1.generate(spaceObjects);
          }
        }
      }
      break;

    case 12:
      boolean shouldIterate1 = true;
      while (shouldIterate1) {
        if (!barChartDisplay) {
          if (table1.startingObjectIndex >= 31)
          {
            table1.startingObjectIndex -= 31;
            table1.y = table1Y;
            table1.generate(spaceObjects);
          } else {
            shouldIterate1 = false;
          }
        } else  shouldIterate1 = false;
      }
      break;
    case 13:
      boolean shouldIterate = true;
      while (shouldIterate) {
        if (!barChartDisplay && table1.startingObjectIndex < table1.spaceObjects.size()) {
          table1.startingObjectIndex -= 1;
          table1.y = table1Y;
          table1.generate(table1.tempSpaceObjects);
        } else {
          shouldIterate = false;
        }
      }
      break;
    }
  }
  table1.mousePress(mouseX, mouseY);
  if (table1.sortPressed)
  {
    table1.y = table1Y;
    table1.startingObjectIndex = 0;
    table1.generate(table1.tempSpaceObjects);
    table1.sortPressed = false;
  }
}

void keyPressed() {
  //Antoni Zapedowski
  //handle keyboard input
  if (key == ENTER) {
    value = screens.get(currentScreen).textWidgets.get(0).label;
    upperValueString = screens.get(currentScreen).textWidgets.get(2).label;
    collumn = screens.get(currentScreen).textWidgets.get(1).label;
    modifySpaceObjectsToBeDisplayed();
  } else if (keyCode != SHIFT)
    //make sure input is not shift as shift is also treaded as a character input
  {
    currentTextWidgets = screens.get(currentScreen).textWidgets;
    for (int i = 0; i< currentTextWidgets.size(); i++) {
      TextWidget textWidget = (TextWidget) currentTextWidgets.get(i);
      event = textWidget.getEvent(mouseX, mouseY);
      println(event);
      switch(event) {
      case 4:
        screens.get(0).textWidgets.get(0).append(key);
        break;
      case 5:
        screens.get(0).textWidgets.get(1).append(key);
        break;
      case 9:
        screens.get(0).textWidgets.get(2).append(key);
        break;
      }
    }
  }
}

//James Doyle: Gives outline to buttons, when mouse is over them.
void mouseMoved() {
  int event;
  ArrayList widgetList = screens.get(currentScreen).buttons;
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    if (event != -1) {
      aWidget.mouseOver = true;
    } else
      aWidget.mouseOver = false;
  }
}

void addScreens()
{
  currentScreen = 0;
  screens = new ArrayList();

  Screen screen1 = new Screen(102, 123, 104);
  Screen screen2 = new Screen(28, 25, 54);
  screens.add(screen1);
  screens.add(screen2);

  TextWidget searchBar = new TextWidget(table1X+150, 36, 350, 30, "Search (value)", 225, stdFont, 4, 50);
  searchBarC = new TextWidget(table1X-7, 36, 150, 30, "Column or index", 225, stdFont, 5, 50);
  valueRange = new TextWidget(table1X+507, 36, 150, 30, "Upper value", 225, stdFont, 9, 50);

  screen1.textWidgets.add(searchBar);
  screen1.textWidgets.add(searchBarC);
  screen1.textWidgets.add(valueRange);

  //Widget nextScreenBtn = new Widget(SCREENX, 450, 190, 30, "Next Screen", 100, stdFont, 1, false);
  Widget nextPageBtn = new Widget(SCREENX-149, table1Y+495, 93, 60, "         >", 225, stdFont, 3, true);
  Widget previousPageBtn = new Widget(SCREENX-246, table1Y+495, 93, 60, "         <", 225, stdFont, 6, true);
  Widget barChartButton    = new Widget(SCREENX-246, table1Y+70, 190, 70, "Bar Chart", 225, stdFont, 2, true);
  Widget apogeeBtn         = new Widget(SCREENX-246, table1Y+140, 190, 70, "Apogee Visual", 225, stdFont, 7, true);
  Widget defaultTableBtn   = new Widget(SCREENX-246, table1Y, 190, 70, "Data Table", 225, stdFont, 8, true);
  Widget lineGraphBtn      = new Widget(SCREENX-246, table1Y+210, 190, 70, "Line Graph", 225, stdFont, 9, true);
  Widget nextPageBtn1 = new Widget(SCREENX-149, table1Y+430, 93, 60, "         >>", 225, stdFont, 10, true);
  Widget previousPageBtn1 = new Widget(SCREENX-246, table1Y+430, 93, 60, "         <<", 225, stdFont, 11, true);
  Widget start = new Widget(SCREENX-246, table1Y+365, 93, 60, "   Beginning", 225, stdFont, 12, true);
  Widget end = new Widget(SCREENX-149, table1Y+365, 93, 60, "         End", 225, stdFont, 13, true);

  screen1.addWidget(barChartButton);
  screen1.addWidget(nextPageBtn);
  screen1.addWidget(previousPageBtn);
  screen1.addWidget(apogeeBtn);
  screen1.addWidget(defaultTableBtn);
  screen1.addWidget(lineGraphBtn);
  screen1.addWidget(previousPageBtn1);
  screen1.addWidget(nextPageBtn1);
  screen1.addWidget(start);
  screen1.addWidget(end);


  // delete unnecessary elements from the screen
  if (apogeeVisualDisplay || barChartDisplay || lineGraphDisplay) {
    if (apogeeVisualDisplay) {
      searchBar.label = "Enter Satellite Name";
      searchBar.draw();

      searchBarC.label = "Enter SatCat";
      searchBarC.draw();
    } else if (barChartDisplay) {
      searchBar.y = 800;
      searchBar.draw();
      searchBarC.y = 800;
      searchBarC.draw();
    } else if (lineGraphDisplay) {
      searchBar.label = "End Year";
      searchBar.draw();
      searchBarC.y = 800;
      searchBarC.draw();
      valueRange.y = 800;
      valueRange.draw();
    }
    valueRange.y = 800;
    valueRange.draw();

    nextPageBtn.y = 800;
    nextPageBtn.draw();

    previousPageBtn.y = 800;
    previousPageBtn.draw();

    nextPageBtn1.y = 800;
    nextPageBtn1.draw();

    previousPageBtn1.y = 800;
    previousPageBtn1.draw();

    start.y = 800;
    start.draw();

    end.y = 800;
    end.draw();
  }



  Widget backBtn = new Widget(SCREENX-280, 450, 90, 30, "Back", 100, stdFont, 4, false);

  screen2.addWidget(backBtn);

  currentWidgets = screens.get(0).buttons;
}



void modifySpaceObjectsToBeDisplayed() {
  // by Antoni && (Ability to search a range of values for satcat, mass, apogee, and perigee added by James Doyle)
  if (!apogeeVisualDisplay && !lineGraphDisplay) {
    if (collumn.equals("") || value.equals("")) {
      table1 = new TableGUI(table1X, table1Y, table1maxX, table1maxY, 9, 16, 100, 30, spaceObjects, 0);
    } else {
      ArrayList<Space_Object> newTableObjects = new ArrayList();
      int index;
      int upperValue = 0;
      LocalDate upperValueD = null;
      // try converting upper value into int
      try {
        index = Integer.parseInt(collumn);
      }
      catch (NumberFormatException e) {
        index = -2137;
      }
      try {
        // try converting uppper value into local date
        upperValue = Integer.parseInt(upperValueString);
        upperValuePresent = true;
      }
      catch (NumberFormatException e) {
        upperValuePresent = false;
        try {
          if (index == 2 || collumn.toLowerCase().equals("launch date")) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");
            upperValueD = LocalDate.parse(upperValueString, formatter);
          }
        }
        catch(NumberFormatException a) {
          upperValueD = null;
        }
      }
      println(index + "index");
      for (int i = 0; i < spaceObjects.size(); i++) {
        if (i < 10) {
          println(spaceObjects.get(i).name);
          if (i == 9) println(value.toLowerCase() + " value");
        }
        //depending what collumn is the data from program will handle it differently
        try {
          if ((index == 1 || collumn.toLowerCase().equals("name")) && spaceObjects.get(i).name.toLowerCase().equals(value.toLowerCase())) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if (spaceObjects.get(i).launchDate != null && (index == 2 || collumn.toLowerCase().equals("launch date"))) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");

            LocalDate temp = LocalDate.parse(value, formatter);
            // println(i);
            if (temp.isEqual(spaceObjects.get(i).launchDate)) newTableObjects.add(spaceObjects.get(i));
            else if (!upperValueString.equals("")
              && spaceObjects.get(i).launchDate != null
              && upperValueD != null
              && spaceObjects.get(i).launchDate.isAfter(temp)
              && (spaceObjects.get(i).launchDate.isBefore(upperValueD) || spaceObjects.get(i).launchDate.isEqual(upperValueD))) {
              newTableObjects.add(spaceObjects.get(i));
            }
          }
          //when input is a string it doesn't matter wheter its statrts with capital letter etc (its not case sensitive)
          if ((index == 3 || collumn.toLowerCase().equals("status")) && spaceObjects.get(i).status.toLowerCase().equals(value.toLowerCase())) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if ((index == 4 || collumn.toLowerCase().equals("state")) && spaceObjects.get(i).state.toLowerCase().equals(value.toLowerCase())) {
            newTableObjects.add(spaceObjects.get(i));
          }

          if ((index == 0 || collumn.toLowerCase().equals("satcat")) && spaceObjects.get(i).satcat.toLowerCase().equals(value.toLowerCase())) {
            newTableObjects.add(spaceObjects.get(i));
          } else if ( !spaceObjects.get(i).satcat.equals("-") &&(index == 0
            || collumn.toLowerCase().equals("satcat"))
            && Integer.parseInt(spaceObjects.get(i).satcat) >= Integer.parseInt(value)
            && Integer.parseInt(spaceObjects.get(i).satcat) <= upperValue) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if ((index == 5 || collumn.toLowerCase().equals("mass") )&& Integer.toString(spaceObjects.get(i).mass).equals(value)) {
            newTableObjects.add(spaceObjects.get(i));
            println(spaceObjects.get(i).status + "status");
          } else if ((index == 5 || collumn.toLowerCase().equals("mass")) && spaceObjects.get(i).mass >= Integer.parseInt(value) && spaceObjects.get(i).mass <= upperValue) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if ((index == 6 || collumn.toLowerCase().equals("apogee")) && spaceObjects.get(i).apogee == Integer.parseInt(value)) {
            newTableObjects.add(spaceObjects.get(i));
          } else if ((index == 6 || collumn.toLowerCase().equals("apogee")) && spaceObjects.get(i).apogee >= Integer.parseInt(value) && spaceObjects.get(i).apogee <= upperValue) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if ((index == 7 || collumn.toLowerCase().equals("perigee")) && spaceObjects.get(i).perigee == Integer.parseInt(value)) {
            newTableObjects.add(spaceObjects.get(i));
          } else if ((index == 7 || collumn.toLowerCase().equals("perigee")) && spaceObjects.get(i).perigee >= Integer.parseInt(value) && spaceObjects.get(i).perigee <= upperValue) {
            newTableObjects.add(spaceObjects.get(i));
          }
          if ((index == 8 || collumn.toLowerCase().equals("diameter")) && spaceObjects.get(i).diameter == Double.parseDouble(value)) {
            newTableObjects.add(spaceObjects.get(i));
          } else if ((index == 8 || collumn.toLowerCase().equals("diameter")) && spaceObjects.get(i).diameter >= Double.parseDouble(screens.get(currentScreen).textWidgets.get(0).label) && spaceObjects.get(i).diameter <=  Double.parseDouble(upperValueString)) {
            newTableObjects.add(spaceObjects.get(i));
          }
        }
        catch(NumberFormatException e) {
          println("No Data? :(");
        }
      }


      if (newTableObjects.size() > 0) {
        //modify the current displayed table with selectioned data
        println("There is data " + newTableObjects.size());
        table1 = new TableGUI(table1X, table1Y, table1maxX, table1maxY, 9, 16, 100, 30, newTableObjects, 0);
      } else {
        println("No Data? :(");
      }
    }
  }
  if (lineGraphDisplay) {
    screens.get(currentScreen).textWidgets.get(0).label = "End Year";
    if (searchBarC != null) screens.get(currentScreen).textWidgets.get(1).label = "Start Year";
  } else if (!apogeeVisualDisplay) {
    screens.get(currentScreen).textWidgets.get(0).label = "Search (value)";
    if (searchBarC != null) screens.get(currentScreen).textWidgets.get(1).label = "Column or index";
  } else if (apogeeVisualDisplay) {
    screens.get(currentScreen).textWidgets.get(0).label = "Enter Satellite Name";
    if (searchBarC != null) screens.get(currentScreen).textWidgets.get(1).label = "Enter SatCat";
  }

  if (valueRange != null) screens.get(currentScreen).textWidgets.get(2).label = "upper value";
}

void mouseWheel(MouseEvent event) {
  // Antoni Zapedowski

  int event1 = event.getCount();
  //when we scroll down and it has not reached the end change currently displayed content of the table (just like "next button")
  if (event1 > 0 && !barChartDisplay && table1.startingObjectIndex < table1.spaceObjects.size() && !barChartDisplay) {
    table1.startingObjectIndex -= 1;
    table1.y = table1Y;
    table1.generate(table1.tempSpaceObjects);
  }
  //when we scroll up we change content of displayed table (just like "previous button")
  else if (event1 < 0 && !barChartDisplay) {
    if (table1.startingObjectIndex >= 31)
    {
      table1.startingObjectIndex -= 31;
      table1.y = table1Y;
      table1.generate(table1.tempSpaceObjects);
    }
  }
}

void noahsAttemptAtMakingThingsLookNicer()
{
  int gap = 4;
  //outline for data display
  fill(0, 0);
  stroke(76, 76, 76);
  strokeWeight(8);
  rect(table1X-gap, table1Y-gap, table1maxX + table1.offset - 20 + gap, table1maxY + gap + 6);

  rect(table1maxX + table1.offset + 20 + gap, table1Y-gap, 200, table1maxY+ gap + 6);
}
