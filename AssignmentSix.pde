int posX, posY; //positions to be randomized
boolean temp = true;
boolean gameState = true;

int pizzaX = 500, pizzaY = 300; //position and size of pizza
int pizzaDiameter = 200;

int moveX = 1, moveY = 1; //X and Y speed of the pizza

void setup()
{
  size(800, 600);
  background(150, 255, 250);
  frameRate(1000);
}

void draw()
{
  if (temp)
  if (gameState)
  {
    background(150, 255, 250); 
    for (int i = 0; i < 5; i++)
    {
      displayRandomPineapple();
    }
    temp = false;
  }
  else
  {
    background(150);
    displayPizza();
  }
  
  pizzaMove();
}

void displayRandomPineapple()
{
  randomize();
  stroke(0);
  strokeWeight(1);
  fill(0, 255, 0);
  triangle(posX, posY - 150, posX + 20, posY - 60, posX - 20, posY - 60);
  triangle(posX - 35, posY - 35, posX - 45, posY - 120, posX, posY - 75);
  triangle(posX + 35, posY - 35, posX + 45, posY - 120, posX, posY - 75);
  fill(220, 150, 0);
  ellipse(posX, posY, 100, 150);
  line(posX - 45, posY - 35, posX + 45, posY + 35);
  line(posX - 45, posY + 35, posX + 45, posY - 35);
}

void displayPizza()
{
  noStroke();
  fill(100, 70, 30);
  arc(pizzaX, pizzaY, pizzaDiameter, pizzaDiameter, PI+QUARTER_PI, PI+HALF_PI);
  fill(200, 170, 10);
  arc(pizzaX, pizzaY, pizzaDiameter - 25, pizzaDiameter - 25, PI+QUARTER_PI, PI+HALF_PI);
  fill(200, 0, 0);
  ellipse(pizzaX - 20, pizzaY - 35, 20, 20);
  ellipse(pizzaX - 15, pizzaY - 70, 25, 25);
}

void randomize() //randomize a position on the screen
{
  posX = round(random(width));
  posY = round(random(height));
}

void pizzaMove() //movement of the pizza
{
  if (pizzaX == width || pizzaX == 70)
  moveX *= -1;
  
  if (pizzaY == height || pizzaY - pizzaDiameter / 2 == 0)
  moveY *= -1;
  
  if (!gameState)
  {
   pizzaX += moveX;
   pizzaY += moveY;
  }
}

void keyPressed()
{
  gameState = !gameState;
  temp = true;
}
