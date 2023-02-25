class TextWidget extends Widget {
int maxlen;
TextWidget(int x, int y, int width, int height,
String label, color widgetColor, PFont font, int event, int
maxlen){
   super(x,y,width,height,label,widgetColor,font,event, false);
this.x=x; this.y=y; this.width = width; this.height= height;
this.label=label; this.event=event;
this.widgetColor=widgetColor; this.widgetFont=font;
labelColor=color(0); this.maxlen=maxlen;
}
void append(char s){
if(s==BACKSPACE){
if(!label.equals(""))
label=label.substring(0,label.length()-1);
}
else if (label.length() <maxlen)
label=label+str(s);
}
int getEvent(int mX, int mY){
if(mX>x && mX < x+width && mY >y && mY <y+height){

clearSearch();
return event;
}
return -1;
}

//James Doyle: Clear text widgets of placeholder text when you start typing.
void clearSearch() {
 
  if (label.equals("Search (value)") || label.equals("Column or index") || label.equals("Upper value") || label.equals("Enter SatCat") || label.equals("Enter Satellite Name") || label.equals("Start Year") || label.equals("End Year")) {
    label = "";
    }
  }
}
