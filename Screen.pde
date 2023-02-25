class Screen{
  ArrayList<Widget> buttons = new ArrayList<Widget>();
  int c1; int c2; int c3;
  ArrayList<TextWidget> textWidgets = new ArrayList<TextWidget>();

  Screen(int colour1, int colour2, int colour3){
  c1 = colour1;
  c2 = colour2;
  c3 = colour3;
}

  int getEvent(int mX, int mY) {
    for (int i = 0; i < buttons.size(); i++) {
      if (mX> buttons.get(i).x && mX < buttons.get(i).x+width && mY >buttons.get(i).y && mY <buttons.get(i).y +height) {
        return (i+1);
      }
    }
    return EVENT_NULL;
  }
  
  public void draw(){
    background(c1, c2, c3);
    for (int i = 0; i < buttons.size(); i++) {
      Widget aWidget = (Widget) buttons.get(i);
      aWidget.draw();
    }
    for (int i = 0; i < textWidgets.size(); i++) {
      TextWidget textWidget = (TextWidget) textWidgets.get(i);
      textWidget.draw();
    }
  }
  
  public void addWidget(Widget widget)
  {
      println(widget.label);
      buttons.add(widget);
  }
}
