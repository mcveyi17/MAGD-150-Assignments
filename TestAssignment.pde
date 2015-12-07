int pressed = 0;
int pressedState = 0;

void setup()
{
  size(800, 800);
}

void draw()
{
  if (pressedState == 0)
    background(255, 0, 0);
    else if (pressedState == 1)
      background(255, 255, 0);
      else if (pressedState == 2)
      background(0, 255, 0);
      else if (pressedState == 3)
      background(0, 255, 255);
      else if (pressedState == 4)
      background(0, 0, 255);
      else
      background(255, 0, 255);
  textSize(32);
  text("Hello World!", mouseX, mouseY);
  text("Hello World!", mouseY, mouseX);
  text("Hello World!", width-mouseX, height-mouseY);
  text("Hello World!", height-mouseY, width-mouseX);
  pressed++;
  println(pressed);
  pressedState = pressed % 6;
  
}

void keyPressed()
{
 pressed++;
 pressedState = pressed % 6;
 println(pressed);
}
