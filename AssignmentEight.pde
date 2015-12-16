boolean keys[];
int gameState;

Ball gameBall;
Paddle leftPaddle;
Paddle rightPaddle;

PImage arrow;
boolean selectPlayer;

int numPlayers;

Timer gameTimer;

void setup()
{
 size(1200, 720);
 background(255);
 keys = new boolean [4]; //keys w, s, up, down
 gameState = 0; //0 = start screen, 1 = game, 2 = end (end screen removed)
 leftPaddle = new Paddle(Paddle.paddleDistance, (this.height - Paddle.paddleHeight) / 2);
 rightPaddle = new Paddle(1200 - (Paddle.paddleDistance + Paddle.paddleWidth), (this.height - Paddle.paddleHeight) / 2);
 gameBall = new Ball(20, width / 2, height / 2, 5, 5);
 arrow = loadImage("Arrow.png");
 selectPlayer = true; //arrow on player 1 if true, or 2 if false
 frameRate(60);
 gameTimer = new Timer(5000);
}

void draw()
{
  background(255);
  if (gameState == 0) //start
  {
    updateStart();
  }
  if (gameState == 1) //game
  {
    updateGame();
  }
}

void updateStart()
{
  fill(0);
  textSize(50);
  text("Pong", 525, 200);
  textSize(25);
  text("Players:", 535, 400);

  text("1", 500, 450);
  text("2", 640, 450);
  if (selectPlayer)
  image(arrow, 480, 430, 20, 20);
  else
  image(arrow, 620, 430, 20, 20);
  
  text("W and S to move P1", 150, 400);
  text("Up and Down to move P2", 800, 400);
  text("Esc to exit at any time", 450, 550);
  text("Left and Right to navigate menu", 380, 600);
}

void updateGame()
{    
  if (keys[0])
  {
    leftPaddle.moveUp();
  }
  if (keys[1])
  {
    leftPaddle.moveDown();
  }
  
  if (numPlayers == 1)
  {
    rightPaddle.auto();
  }
  if (numPlayers == 2)
  {
    if (keys[2])
    {
      rightPaddle.moveUp();
    }
    if (keys[3])
    {
      rightPaddle.moveDown(); 
    }
  }
    
  leftPaddle.display();
  rightPaddle.display();
  
  gameBall.update();
  gameBall.display();
}

void keyPressed()
{
  if (keyCode == ESC)
  {
    this.exit();
  }
  
  if (gameState == 0)
  {
    if (keyCode == ENTER)
    {
      if (selectPlayer)
      numPlayers = 1;
      else
      numPlayers = 2;
      gameState = 1;
      gameTimer.timerStart();
    }
    
    if (keyCode == LEFT)
    {
      selectPlayer = true;
    }
    
    if (keyCode == RIGHT)
    {
      selectPlayer = false;
    }
    
  }
  if (gameState == 1)
  {
   if (key == 'w')
   keys[0] = true;
   if (key == 's')
   keys[1] = true;
   if (keyCode == UP)
   keys[2] = true;
   if (keyCode == DOWN)
   keys[3] = true;  
  }
}

void keyReleased()
{
  if (key == 'w')
  keys[0] = false;
  if (key == 's')
  keys[1] = false;
  if (keyCode == UP)
  keys[2] = false;
  if (keyCode == DOWN)
  keys[3] = false;
}


class Ball
{
 private int radius, xPos, yPos, xSpeed, ySpeed, defaultSpeedX, defaultSpeedY;
  
  Ball(int rad, int x, int y, int xSpe, int ySpe)
  {
    radius = rad;
    xPos = x;
    yPos = y;
    defaultSpeedX = xSpe;
    defaultSpeedY = ySpe;
    xSpeed = xSpe;
    ySpeed = ySpe;
  }

  void update()
  {
    if (xPos + 2 * radius >= width || xPos + radius <= 0)
    {
      if (xPos + 2 * radius >= width)
      {
        xSpeed = defaultSpeedX * -1;
      }
      else
      xSpeed = defaultSpeedX;
      ySpeed = defaultSpeedY;
      xPos = (width + radius) / 2;
      yPos = (height + radius) / 2;
    }
  
    if (yPos + radius >= height || yPos - radius <= 0)
    ySpeed *= -1;
    
  
    if (xPos <= Paddle.paddleDistance + Paddle.paddleWidth)
    {
     if (yPos > leftPaddle.getY() - radius && yPos < leftPaddle.getY() + Paddle.paddleHeight)
     {
      xPos = Paddle.paddleDistance + Paddle.paddleWidth;
      xSpeed *= -1; 
     }
    }
    
    if (xPos >= width - Paddle.paddleDistance - Paddle.paddleWidth - radius)
    {
     if (yPos > rightPaddle.getY() - radius && yPos < rightPaddle.getY() + Paddle.paddleHeight)
     {
       xPos = width - Paddle.paddleDistance - Paddle.paddleWidth - radius ;
       xSpeed *= -1;
     }
    }
  
    if (gameTimer.isFinished())
    {
      if (xSpeed > 0)
      xSpeed++;
      else
      xSpeed--;
      if (ySpeed > 0)
      ySpeed++;
      else
      ySpeed--;
      gameTimer.timerStart();
    }
    
    //text(millis(), 0, 50); //display the time played during testing
  
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
  void display()
  {
    fill(0);
    noStroke();
    rect(xPos, yPos, radius, radius);
  }
  
  int getY()
  {
    return yPos;
  }
  
  int getRad()
  {
    return radius;
  }
}


class Paddle
{
  private int xPos, yPos;
  static final int paddleWidth = 25;
  static final int paddleHeight = 100;
  static final int paddleDistance = 50;
  static final int paddleSpeed = 10;
  
  Paddle(int x, int y)
  {
   xPos = x;
   yPos = y;
  }
  
  void display()
  {
   fill(0);
   noStroke();
   rect(xPos, yPos, paddleWidth, paddleHeight); 
  }
  
  void moveUp()
  {
    yPos -= paddleSpeed; 
    if (yPos < 0)
    yPos = 0; 
  }
  
  void moveDown()
  {
    yPos += paddleSpeed;
    if (yPos > height - paddleHeight)
    yPos = height - paddleHeight;
  }
  
  void auto()
  {
    if (yPos + paddleHeight / 2 > gameBall.getY())
    {
      moveUp();
    }
    if (yPos + paddleHeight / 2 < gameBall.getY())
    {
      moveDown();
    }
  }
  
  public int getX()
  {
    return xPos; 
  }
  
  public int getY()
  {
    return yPos;
  }
}



class Timer{
  float startTime, stopTime; // two variables to keep track of the time that the timer starts and length of time for the timer.
  
  //constructor. This sets the amount of the time to lapse before it sets the boolean below to true. 
  // an example use would be 
  // Timer myTimer = new Timer(2000);    <---- that sets the timer to 2 seconds.
  Timer(float _stopTime){
    stopTime = _stopTime;
  }
  
  // you can call this anyway (inside the Setup which would start almost immediately or inside the draw loop, which would make 
  // it restart ever cycle.
  void timerStart(){
    startTime = millis();
  }
  
  // place this in your draw() loop to cheen the time has lapse.
  // an example block of code might be:
  //   if (myTimer.isFinished(){
  //      text("EXPLOSION!", 100, 100);
  //    }
  boolean isFinished(){
    float passedTime = millis() - startTime;
    if(passedTime > stopTime) {
      return true;
    } else {
      return false;
    }
  }
}
