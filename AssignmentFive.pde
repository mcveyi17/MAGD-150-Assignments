boolean gameState = false;
int xPos = 160;
int yPos = 490;
int rValue = 0;
int gValue = 0;
int bValue = 0;

boolean xIncreasing = true;

void setup()
{
  size(800, 600);
  frameRate(1000);
}

void draw()
{
  if (gameState)
  {
    background(230, 130, 30);
    textSize(32);
    stroke(0);
    fill(0);
    text("HAPPY HALLOWEEN!", 100, 100);
    
    //pumpkin
    stroke(0);
    fill(rValue, gValue, bValue);
    ellipse(xPos + 40, yPos + 10, 100, 100);
    noStroke();
    fill(0);
    triangle(xPos, yPos, xPos + 30, yPos, xPos + 15, yPos - 15);
    triangle(xPos + 50, yPos, xPos + 80, yPos, xPos + 65, yPos - 15);
    beginShape();
    vertex(xPos, yPos + 10);
    vertex(xPos + 10, yPos + 30);
    vertex(xPos + 25, yPos + 22);
    vertex(xPos + 40, yPos + 30);
    vertex(xPos + 55, yPos + 22);
    vertex(xPos + 70, yPos + 30);
    vertex(xPos + 80, yPos + 10);
    vertex(xPos + 60, yPos + 20);
    vertex(xPos + 40, yPos + 15);
    vertex(xPos + 20, yPos + 20);
    endShape(CLOSE);
    update();
  }
  else
  {
    background(0, 0, 40);
    
    //fence
    fill(0);
    noStroke();
    for (int i = 0; i < 20; i++)
    {
     rect(10 + 40 * i, height - 200, 10, 140); 
     triangle(40 * i + 5, height - 200, 40 * i + 25, height - 200, 40 * i + 15, height - 230);
    }
    rect(0, height - 190, width, 10);
    
    //gravestone
    fill(150, 150, 150);
    noStroke();
    arc(600, 450, 100, 100, PI, 2*PI);
    rect(550, 450, 100, 90);
  
    //moon
    fill(250);
    noStroke();
    ellipse(400, 60, 60, 60);
    fill(0, 0, 40);
    ellipse(372, 50, 70, 70);
    
    //pumpkin
    fill(230, 130, 30);
    noStroke();
    ellipse(200, 500, 100, 100);
    fill(0, 50, 0);
    rect(192, 430, 16, 25);  
    fill(0);
    triangle(160, 490, 190, 490, 175, 475);
    triangle(210, 490, 240, 490, 225, 475);
    beginShape();
    vertex(160, 500);
    vertex(170, 520);
    vertex(185, 512);
    vertex(200, 520);
    vertex(215, 512);
    vertex(230, 520);
    vertex(240, 500);
    vertex(220, 510);
    vertex(200, 505);
    vertex(180, 510);
    endShape(CLOSE);
    
    //ground
    fill(60, 40, 10);
    noStroke();
    rect(0, height - 60, width, 60);
  }
}

void keyPressed()
{
 gameState = !gameState; 
}

void update()
{
 if (xIncreasing)
 xPos++;
 else
 xPos--;
 if (xPos == 500 || xPos == 100)
 xIncreasing = !xIncreasing;
 rValue = (int)random(255);
 gValue = (int)random(255);
 bValue = (int)random(255);
}
