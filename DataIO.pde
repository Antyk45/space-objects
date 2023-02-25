//Antoni Zapedowski //<>// //<>// //<>//
class DataIO { //<>// //<>// //<>// //<>//
  DataIO() {
  }
  public boolean isNull = false;
  //Read in the data from the file
  public void readData() {
    Table table = loadTable("gcat.tsv", "header");
    for (TableRow row : table.rows()) {
      String jcat = row.getString("#JCAT");
      String satcat = row.getString("Satcat");
      String piece = row.getString("Piece");
      String type = row.getString("Type");
      String name = row.getString("Name");
      String plname = row.getString("PLName");
      String lDate = row.getString("LDate");
      String paernt = row.getString("Parent");
      String sDate = row.getString("SDate");
      String primary = row.getString("Primary");
      String dDate = row.getString("DDate");
      String status = row.getString("Status");
      String dest = row.getString("Dest");
      String owner = row.getString("Owner");
      String state = row.getString("State");
      String manufac = row.getString("Manufacturer");
      String bus = row.getString("Bus");
      String motor = row.getString("Motor");
      int mass = row.getInt("Mass");
      String massFlag = row.getString("MassFlag");
      int dryMass = row.getInt("DryMass");
      String dryFlag = row.getString("DryFlag");
      int totMass = row.getInt("TotMass");
      String totFlag = row.getString("TotFlag");
      String lenght = row.getString("Length");
      String lFlag = row.getString("LFlag");
      double diameter = row.getDouble("Diameter");
      String dFlag = row.getString("DFlag");
      String span = row.getString("Span");
      String spanFlag = row.getString("SpanFlag");
      String shape = row.getString("Shape");
      String oDate = row.getString("ODate");
      int perigee = row.getInt("Perigee");
      String pf = row.getString("PF");
      int apogee = row.getInt("Apogee");
      String af = row.getString("AF");
      String inc = row.getString("Inc");
      String ifa = row.getString("IF");
      String opOrbit = row.getString("OpOrbit");
      String qQual = row.getString("OQUAL");
      String altNames = row.getString("AltNames");
      LocalDate launchDate;
      int decommissionedYear;

      //split the string into day, month, year separetly
      String[] lDateARR = lDate.split(" ");
      if (lDateARR.length == 1) {
        launchDate = null;
        isNull = true;
      } else {
        //if not null make sure that days are in a certain constant format
        lDateARR[1] = " "+convert(lDateARR[1]) +" ";
        if (lDateARR.length == 4) {
          lDateARR[3] = convertDays(lDateARR[3]);
        } else {
          lDateARR[2] = convertDays(lDateARR[2]);
        }
        String tempDate = "";
        if (lDateARR.length == 4) {
          for (int i = 0; i < lDateARR.length; i++) {
            if (i != 2) {
              tempDate += lDateARR[i];
            }
          }
        } else {
          for (int i = 0; i < lDateARR.length; i++) {
            tempDate += lDateARR[i];
          }
        }
        // format of the days (year-month-day)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu MM dd");
        try {
          launchDate = LocalDate.parse(tempDate, formatter);
        }
        catch(DateTimeParseException a) {
          launchDate = LocalDate.parse("2010 06 30", formatter);
        }
      }



      String[] dDateARR = dDate.split(" ");
      if (dDateARR.length < 3) {
        decommissionedYear = -1;
      } else {
        decommissionedYear = Integer.parseInt(dDateARR[0]);
      }
      Space_Object temp = new Space_Object(jcat, satcat, piece, type, name, plname, lDate, paernt, sDate, primary, dDate, status, dest, owner, state, manufac, bus, motor, mass, massFlag, dryMass, dryFlag, totMass, totFlag, lenght, lFlag, diameter, dFlag, span, spanFlag, shape, oDate, perigee, pf, apogee, af, inc, ifa, opOrbit, qQual, altNames, launchDate, decommissionedYear, isNull);
      spaceObjects.add(temp);
    }
  }

  //convert name of months to num
  public String convert(String monthS) {
    if (monthS.equals("Jan")) return "01";
    if (monthS.equals("Feb")) return "02";
    if (monthS.equals("Mar")) return "03";
    if (monthS.equals("Apr")) return "04";
    if (monthS.equals("May")) return "05";
    if (monthS.equals("Jun")) return "06";
    if (monthS.equals("Jul")) return "07";
    if (monthS.equals("Aug")) return "08";
    if (monthS.equals("Sep")) return "09";
    if (monthS.equals("Oct")) return "10";
    if (monthS.equals("Nov")) return "11";
    else return "12";
  }

  //convert one digit days to ahve two digit (e.g 4 -> 04)
  public String convertDays(String temp) {
    if (temp.equals("")) {
      return 0+"";
    }
    int temp1;
    if (temp.contains("?"))  temp1 = Integer.parseInt(temp.substring(0, temp.length() - 1));
    else  temp1 =  Integer.parseInt(temp);
    if (temp1< 10) {
      String tempS = "0" +temp;
      return tempS;
    } else {
      return temp;
    }
  }
}
