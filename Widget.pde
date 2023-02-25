class Widget {
boolean mouseOver = false; 
int x, y, width, height;
String label; int event;
color widgetColor, labelColor;
PFont widgetFont;
boolean outline = false;
int currentlySorted = 1;
Widget(int x,int y, int width, int height, String label,
color widgetColor, PFont widgetFont, int event, boolean outline){
this.x=x; this.y=y; this.width = width; this.height= height;
this.label=label; this.event=event;
this.widgetColor=widgetColor; this.widgetFont=widgetFont;
labelColor= color(0);
this.outline = outline;
}
void draw(){
if (mouseOver == true) {
 stroke(0); 
 strokeWeight(5);
}
else if(outline)
{
  strokeWeight(5);
   stroke(76,76,76); 
}
else {
 noStroke(); 
}
fill(widgetColor);
textFont(widgetFont);
textAlign(LEFT);
rect(x,y,width,height);
fill(labelColor);
text(label, x+10, y+height/2+6);
}
int getEvent(int mX, int mY){
if(mX>x && mX < x+width && mY >y && mY <y+height){
return event;
}
return -1;
}
}
