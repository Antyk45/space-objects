class TableGUI //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
{
  int x;
  int maxX;
  int y;
  int maxY;
  int columns;
  int rows;
  int cellWidth;
  int cellHeight;
  int gap = 1;
  Widget[][] cells;
  ArrayList<Widget> headerWidgets = new ArrayList<Widget>();
  boolean tableLoaded = false;
  int startingObjectIndex;
  ArrayList<Space_Object> spaceObjects;
  boolean sortPressed = false;
  int counter = 0;
  String headerColumnDir = "";
  String[] columnHeaderArrow;
  int offset = 60;
  ArrayList<Space_Object> tempSpaceObjects;
  TableGUI(int x, int y, int maxX, int maxY, int columns, int rows, int cellWidth, int cellHeight, ArrayList<Space_Object> spaceObjects, int startingObjectIndex)
  {
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
    this.cellWidth = (maxX - x) / columns;
    this.cellHeight = (maxY - Y) / rows;
    //this.maxX = this.maxX + offset + (offset/2);
    this.columns = columns;
    this.rows = rows;
    //this.cellWidth = cellWidth;
    //this.cellHeight = cellHeight;
    this.spaceObjects = spaceObjects;
    this.startingObjectIndex = startingObjectIndex;
    this.tempSpaceObjects = new ArrayList<>(spaceObjects);

    columnHeaderArrow = new String[columns];
    clearHeaderIndicator(columnHeaderArrow, headerWidgets, 0);
    generate(spaceObjects);
  }

  void draw()
  {
    if (tableLoaded)
    {
      for (int i = 0; i < rows; i++)
      {
        for (int j = 0; j < columns; j++)
        {
          if (i==0) fill(100);
          stroke(10);
          cells[j][i].draw();
        }
      }
    }
  }


  void generate(ArrayList<Space_Object> spaceObjectsList)
  {
    //counter++;
    println("generate" + counter);
    int tempCellWidth = cellWidth;
    int tempx = x;
    int cellColour = 250;
    int headerEvent = 0;
    //headerWidgets.clear();
    Widget aWidget = new Widget(tempx, y, cellWidth, cellHeight, "", cellColour, stdFont, 1, false);
    cells = new Widget[columns][rows];
    for (int i = 0; i < rows; i++)
    {
      Space_Object currentObject;
      if (spaceObjectsList.size() == 1) {
        if (i>1) currentObject = new Space_Object();
        else currentObject = spaceObjectsList.get(0);
      } else {
        if (i <= spaceObjectsList.size()) {
          try {
            currentObject = spaceObjectsList.get(startingObjectIndex);
          }
          catch(Exception e) {
            currentObject = new Space_Object();
          }
          if (startingObjectIndex > 0) {
            try {
              currentObject = spaceObjectsList.get(startingObjectIndex-1);
            }
            catch(Exception e) {
              currentObject = new Space_Object();
            }
          }
        } else {
          currentObject = new Space_Object();
        }
      }
      String cellText = "";
      for (int j = 0; j < columns; j++)
      {
        if (i == 0)
        {
          cellColour = 125;
          switch(j)
          {
          case 0:
            cellText = "SatCat" + columnHeaderArrow[j];
            headerEvent = 1;
            break;
          case 1:
            cellText = "Name" + columnHeaderArrow[j];
            cellWidth += offset;
            headerEvent = 2;
            break;
          case 2:
            cellText = "Launch date" + columnHeaderArrow[j];
            headerEvent = 3;
            cellWidth += offset/2;
            break;
          case 3:
            cellText = "Status" + columnHeaderArrow[j];
            headerEvent = 4;
            break;
          case 4:
            cellText = "State" + columnHeaderArrow[j];
            headerEvent = 5;
            break;
          case 5:
            cellText = "Mass" + columnHeaderArrow[j];
            headerEvent = 6;
            break;
          case 6:
            cellText = "Apogee" + columnHeaderArrow[j];
            headerEvent = 7;
            break;
          case 7:
            cellText = "Perigee" + columnHeaderArrow[j];
            headerEvent = 8;
            break;
          case 8:
            cellText = "Diameter" + columnHeaderArrow[j];
            headerEvent = 9;
            break;
          default:
            cellText = "N/A";
            headerEvent = 0;
            break;
          }
          if (headerWidgets.size() == columns)
          {
            //println("t");
            aWidget = headerWidgets.get(j);
            aWidget.label = cellText;
          } else
          {
            aWidget = new Widget(tempx, y, cellWidth, cellHeight, cellText, cellColour, stdFont, headerEvent, false);
            headerWidgets.add(aWidget);
            println(headerWidgets.size());
            println(columns);
          }
        } else
        {
          cellColour = 250;
          switch(j)
          {
          case 0:
            cellText = currentObject.satcat;
            break;
          case 1:
            cellText = currentObject.name;
            cellWidth += offset;
            break;
          case 2:
            if (currentObject.launchDate == null) {
              cellText = "";
            } else {
              cellText = currentObject.launchDate.toString();
            }
            cellWidth += offset/2;
            break;
          case 3:
            cellText = currentObject.status;
            break;
          case 4:
            cellText = currentObject.state;
            break;
          case 5:
            if (currentObject.mass != -2137)
              // if a value is equal to 2137 than its a dummy object which we don't want to display
              cellText = Integer.toString(currentObject.mass);
            break;
          case 6:
            if (currentObject.apogee != -2137)
              cellText = Integer.toString(currentObject.apogee);
            break;
          case 7:
            if (currentObject.perigee != -2137)
              cellText = Integer.toString(currentObject.perigee);
            break;
          case 8:
            if (currentObject.diameter != -2137)
              cellText = Double.toString(currentObject.diameter);
            break;
          default:
            cellText = "N/A";
            break;
          }
          aWidget = new Widget(tempx, y, cellWidth, cellHeight, cellText, cellColour, stdFont, 0, false);
        }


        cells[j][i] = aWidget;
        tempx += cellWidth + gap;
        cellWidth = tempCellWidth;
      }
      startingObjectIndex++;
      y += cellHeight + gap;
      tempx = x;
    }
    //println("loaded");
    tableLoaded = true;
  }

  void mousePress(int mX, int mY)
  {
    for (int i = 0; i<headerWidgets.size(); i++)
    {
      Widget aWidget = (Widget) headerWidgets.get(i);
      event = aWidget.getEvent(mX, mY);
      switch(event) {
      case 1:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1] = "";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                try {
                  return (Integer.valueOf(o1.satcat) == Integer.valueOf(o2.satcat))?0:(Integer.valueOf(o1.satcat) < Integer.valueOf(o2.satcat)? 1 : -1);
                }
                catch(NumberFormatException a) {
                }
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                try {
                  return (Integer.valueOf(o1.satcat) == Integer.valueOf(o2.satcat))?0:(Integer.valueOf(o1.satcat) < Integer.valueOf(o2.satcat)? -1 : 1);
                }
                catch(NumberFormatException b) {
                }
              }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        }
        break;
      case 2:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0) {
          println("yo");
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1]="";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              if (o2.name != null && o1.name != null)
              {
                if (aWidget.currentlySorted == 1)
                {
                  columnHeaderArrow[event-1]= " ▼";
                  return -1*o1.name.compareTo(o2.name);
                } else if (aWidget.currentlySorted == 2) {
                  columnHeaderArrow[event-1]= " ▲";
                  return o1.name.compareTo(o2.name);
                }
              }
              return (o1.name == o2.name)?0:(o1.name==null? 1 : -1);
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          println("sort: "+aWidget.currentlySorted);
          sortPressed = true;
        }
        println("You pressed a button");
        break;

      case 3:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1); //<>//
        if (aWidget.currentlySorted == 0)
        {
          println("yo");
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1]="";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              if (o2.launchDate != null && o1.launchDate != null)
              {
                if (aWidget.currentlySorted == 1)
                {
                  columnHeaderArrow[event-1]= " ▼";
                  return -1*o1.launchDate.compareTo(o2.launchDate);
                } else if (aWidget.currentlySorted == 2) {
                  columnHeaderArrow[event-1]= " ▲";
                  return o1.launchDate.compareTo(o2.launchDate);
                }
              }
              return (o1.launchDate == o2.launchDate)?0:(o1.launchDate==null? 1 : -1);
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          println("sort: "+aWidget.currentlySorted);
          sortPressed = true;
        }
        break;
      case 4:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          println("yo");
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1]="";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (o2.status != null && o1.status != null)
              {
                if (aWidget.currentlySorted == 1)
                {
                  columnHeaderArrow[event-1]= " ▼";
                  return -1*o1.status.compareTo(o2.status);
                } else if (aWidget.currentlySorted == 2) {
                  columnHeaderArrow[event-1]= " ▲";
                  return o1.status.compareTo(o2.status);
                }
              }
              return (o1.status == o2.status)?0:(o1.status==null? 1 : -1);
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          println("sort: "+aWidget.currentlySorted);
          sortPressed = true;
        }
        break; //<>//
      case 5:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          println("yo");
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1]="";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              if (o2.state != null && o1.state != null)
              {
                if (aWidget.currentlySorted == 1)
                {
                  columnHeaderArrow[event-1]= " ▼";
                  return -1*o1.state.compareTo(o2.state);
                } else if (aWidget.currentlySorted == 2) {
                  columnHeaderArrow[event-1]= " ▲";
                  return o1.state.compareTo(o2.state);
                }
              }
              return (o1.state == o2.state)?0:(o1.state==null? 1 : -1);
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          println("sort: "+aWidget.currentlySorted);
          sortPressed = true;
        }
        break;
      case 6:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          aWidget.currentlySorted = 1; //<>//
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1] = "";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                return (o1.mass == o2.mass)?0:(o1.mass < o2.mass? 1 : -1);
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                return (o1.mass == o2.mass)?0:(o1.mass < o2.mass? -1 : 1);
              }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        }
        break;
      case 8:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1] = "";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                return (o1.perigee == o2.perigee)?0:(o1.perigee < o2.perigee? 1 : -1);
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                return (o1.perigee == o2.perigee)?0:(o1.perigee < o2.perigee? -1 : 1);
              }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        }
        break;
      case 7:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1] = "";
        } else
        {
          Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                return (o1.apogee == o2.apogee)?0:(o1.apogee < o2.apogee? 1 : -1);
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                return (o1.apogee == o2.apogee)?0:(o1.apogee < o2.apogee? -1 : 1);
              }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        }
        break;

      case 9:
        clearHeaderIndicator(columnHeaderArrow, headerWidgets, event-1);
        if (aWidget.currentlySorted == 0)
        {
          aWidget.currentlySorted = 1;
          sortPressed = true;
          tempSpaceObjects = new ArrayList<>(spaceObjects);
          columnHeaderArrow[event-1] = "";
        } else
        {
        try{
            Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                try{
                return (o1.diameter == o2.diameter)?0:(o1.diameter < o2.diameter? 1 : -1);
                }
                catch(NumberFormatException a){}
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                try{
                return (o1.diameter == o2.diameter)?0:(o1.diameter < o2.diameter? -1 : 1);
                }
                catch(NumberFormatException b){}
            }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        }
      catch(IllegalArgumentException c){
        Collections.sort(tempSpaceObjects, new Comparator<Space_Object>()
          {
            public int compare(Space_Object o1, Space_Object o2)
            {
              //println("Date: " + o1.launchDate.compareTo(o2.launchDate) + ": " + o1.satcat);
              if (aWidget.currentlySorted == 1)
              {
                columnHeaderArrow[event-1]= " ▼";
                try{
                return (o1.diameter == o2.diameter)?0:(o1.diameter < o2.diameter? 1 : -1);
                }
                catch(NumberFormatException a){}
              } else if (aWidget.currentlySorted == 2) {
                columnHeaderArrow[event-1]= " ▲";
                try{
                return (o1.diameter == o2.diameter)?0:(o1.diameter < o2.diameter? -1 : 1);
                }
                catch(NumberFormatException b){}
            }
              return -1;
            }
          }
          );
          if (aWidget.currentlySorted == 1) aWidget.currentlySorted = 2;
          else if (aWidget.currentlySorted == 2) aWidget.currentlySorted = 0;
          sortPressed = true;
        
      }  
      }
        
        break;
      }
    }
  }

  void clearHeaderIndicator(String[] indicators, ArrayList<Widget> headerWidgets, int column)
  {
    for (int i = 0; i < indicators.length; i++)
    {
      indicators[i] = "";
    }

    for (int i = 0; i < headerWidgets.size(); i++)
    {
      if (i != column)
      {
        headerWidgets.get(i).currentlySorted = 1;
      } else
      {
        println(headerWidgets.get(column).label);
      }
    }
  }
}
