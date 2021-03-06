/*
Ian McVey
I've made this game in a couple of other languages, and decided to use it for my final project
This is the best it has ever turned out to be
The theme is retro, based off of the original Atari game Pong
It starts off like Pong, but works a bit differently
*/

int rValueL, gValueL, bValueL;//color values for the left
int rValueR, gValueR, bValueR;//color values for the right
boolean rIncreasing, gIncreasing, bIncreasing; //control if colors are increasing or decreasing


boolean keys[]; //array to keep track of keys pressed
int gameState; //controls which of three states the game is in

Ball gameBall;
Paddle leftPaddle;
Paddle rightPaddle;

PImage warning;
PImage arrow; //arrow on selection screen
PImage gameOver; //text image on end screen
PImage insertCoin; 
boolean selectPlayer; //keep track of which player is selected

int numPlayers; //number of players, 1 or 2

Timer gameTimer;

Ball[] ballArr; //array to keep track of the balls
int ballCounter; //number of balls currently in play
int maxBall; //max number of balls in play
int maxScore; //score required to win
String winner; //the winning side, left or right

int leftScore, rightScore; //keep score

int rStart = 200, gStart = 100, bStart = 0;
boolean rStartIncreasing = true, gStartIncreasing = true, bStartIncreasing = true;


void setup()
{
 size(1200, 720);
 background(255);
 frameRate(60);
 
 rValueL = 200;
 gValueL = 50;
 bValueL = 0;
 rValueR = 255 - rValueL; //inverse of rValueL
 gValueR = 255 - gValueL; //inverse of gValueL
 bValueR = 255 - bValueL; //inverse of bValueL
 rIncreasing = true;
 gIncreasing = true;
 bIncreasing = true;
 
 keys = new boolean [4]; //keys w, s, up, down
 gameState = 0; //0 = start screen, 1 = game, 2 = end
 
 //instantiate paddles and give them starting positions
 leftPaddle = new Paddle(Paddle.paddleDistance, (this.height - Paddle.paddleHeight) / 2);
 rightPaddle = new Paddle(this.width - (Paddle.paddleDistance + Paddle.paddleWidth), (this.height - Paddle.paddleHeight) / 2);
 
 numPlayers = 1; //1 player default
 
 warning = loadImage("Warning.png"); //load images
 arrow = loadImage("Arrow.png");
 gameOver = loadImage("game_over.jpg");
 insertCoin = loadImage("insert_coin.png");
 
 selectPlayer = true; //arrow on player 1 if true, or 2 if false
 gameTimer = new Timer(5000); //set timer to 5 seconds
 maxBall = 1000; //set ball limit
 maxScore = 5000; //set score limit
 winner = ""; //placeholder
 
 ballArr = new Ball[maxBall]; //creates an array to hold maxBall amount of balls
 
 int ballRadius = 20; //side length of ball
 gameBall = new Ball(20, (width - ballRadius) / 2, (height - ballRadius) / 2, 5, 5); //start the game ball in the middle
 for (int i = 0; i < ballArr.length; i++) //fill the array with balls of random speeds, all positioned in the middle to start
 {    
   ballArr[i] = new Ball(ballRadius, (width - ballRadius) / 2, (height - ballRadius) / 2, (round(random(5)) + 2), (round(random(5)) + 2));
 }
 
 ballCounter = 1; //number of balls in play, starting with gameBall
 leftScore = 0;
 rightScore = 0;
}


void draw()
{
  if (gameState == 0) //start screen
  {
    background(255);
    updateStart();
  }
  if (gameState == 1) //game screen
  {
    //draw the background
    fill(rValueL, gValueL, bValueL);
    stroke(rValueR, gValueR, bValueR);
    rect(0, 0, width / 2 - 1, height);
    fill(rValueR, gValueR, bValueR);
    stroke(rValueL, gValueL, bValueL);
    rect(width / 2, 0, width / 2 - 1, height);
    
    //when either score hits 100, change the paddle color to slightly darker than the background
    if (leftScore > 100)
    {
      leftPaddle.setColor(rValueR - 30, gValueR - 30, bValueR - 30);
    }
    if (rightScore > 100)
    {
      rightPaddle.setColor(rValueL - 30, gValueL - 30, bValueL - 30);
    }
    
    //display scores
    fill(0);
    text(leftScore, 0, 30);
    text(rightScore, width / 2, 30);
    
    updateGame();
    //println(ballCounter); //during testing, print how many balls are in play
  }
  if (gameState == 2) //end screen
  {
    updateEnd();
  }
 
}


void updateStart()
{
  fill(0);
  textSize(200);
  text("LSD P  ng", 200, 200); //title
  textSize(25);
  text("Players:", 535, 400);
  
  //control increase/decrease in color value on the start screen
  if (rStart == 255 || rStart == 0)
  rStartIncreasing = !rStartIncreasing;
  
  if (gStart == 0 || gStart == 255)
  gStartIncreasing = !gStartIncreasing;
  
  if (bStart == 0 || bStart == 255)
  bStartIncreasing = !bStartIncreasing;
  
  if (rStartIncreasing)
  rStart++;
  else
  rStart--;
  
  if (gStartIncreasing)
  gStart++;
  else
  gStart--;
  
  if (bStartIncreasing)
  bStart++;
  else
  bStart--;
  
  //on title screen, draw the "O" in "Pong"
  fill(rStart, gStart, bStart);
  noStroke();
  ellipse(805, 145, 120, 120);
  fill(255);
  ellipse(805, 145, 90, 90);

  //show player selection
  fill(0);
  text("1", 500, 450);
  text("2", 640, 450);
  if (selectPlayer)
  image(arrow, 480, 430, 20, 20);
  else
  image(arrow, 620, 430, 20, 20);
  
  //explain the controls to the game
  text("W and S to move P1", 150, 400);
  text("Up and Down to move P2", 800, 400);
  text("Esc to exit at any time", 450, 550);
  text("Left and Right to navigate menu", 380, 600);
  text("Score " + maxScore + " points to win!", 450, 300);
  
  //display the warning on the title screen
  image(warning, width  - 250, height  - 150, 250, 125);
}


void updateGame()
{
  //keeps the colors inversed
  rValueR = 255 - rValueL;
  gValueR = 255 - gValueL;
  bValueR = 255 - bValueL;

  if (rValueL == 255 || rValueL == 0)
  rIncreasing = !rIncreasing;
  
  if (gValueL == 0 || gValueL == 255)
  gIncreasing = !gIncreasing;
  
  if (bValueL == 0 || bValueL == 255)
  bIncreasing = !bIncreasing;
  
  if (rIncreasing)
  rValueL++;
  else
  rValueL--;
  
  if (gIncreasing)
  gValueL++;
  else
  gValueL--;
  
  if (bIncreasing)
  bValueL++;
  else
  bValueL--;
  
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
  
  for (int i = 0; i < ballCounter - 1 && i < ballArr.length; i++) //update each ball currently in play
  {
    ballArr[i].update();
    ballArr[i].display();
  }
  
  if (leftScore >= maxScore || rightScore >= maxScore)
  {
    if (leftScore >= maxScore) //left wins
    winner = "Left";
    else //right wins
    winner = "Right";
    
    gameState = 2; //go to end screen
  }
}


void updateEnd()
{
  background(255);
  image(gameOver, width / 2 - 75, 20, 150, 150);
  image (insertCoin, width / 2 - 75, height - 200, 150, 75);
  //fill((rValueL + gValueL + bValueL) / 3);
  text(winner + " wins!", width / 2 - 75, 300);
  text("Press Enter to play again", width / 2 - 150, height / 2);
  text("or Esc to quit", width / 2 - 75, height / 2 + 50);
}


void keyPressed()
{
 if (keyCode == ESC) //exit at any point in the game
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
   selectPlayer = true;
   if (keyCode == RIGHT)
   selectPlayer = false;
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
 
 if (gameState == 2)
 {
   if (keyCode == ENTER)
   {
     ballCounter = 0;
     leftScore = 0;
     rightScore = 0;
     gameState = 0;
   }
 }
}

void keyReleased()
{
  if (gameState == 1)
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
}

void mousePressed() //spawn another ball during game
{
  if (gameState == 1 && ballCounter > 1)
  ballCounter--;
}


class Ball
{
  private int radius, xPos, yPos, xSpeed, ySpeed, defaultSpeedX, defaultSpeedY;
  private int rand;
  
  Ball(int rad, int x, int y, int xSpe, int ySpe)
  {
   int r1 = floor(random(2)); //randomize X direction
   int reverseX = 1;
   if (r1 % 2 == 0)
   reverseX *= -1;

   int r2 = floor(random(2)); //randomize Y direction
   int reverseY = 1;
   if (r2 % 2 == 0)
   reverseY *= -1;
    
    radius = rad; //side length of the ball
    xPos = x;
    yPos = y;
    xSpeed = xSpe * reverseX;
    ySpeed = ySpe * reverseY;
    defaultSpeedX = xSpe;
    defaultSpeedY = ySpe;
  }
  
  
  void update()
  {
    if (xPos + 2 * radius >= width || xPos + radius <= 0) //check if ball gets scores
    {
      if (xPos + 2 * radius >= width) //right goal
      {
        xSpeed = defaultSpeedX * -1; //send the ball left
        leftScore++;
      }
      else //left goal
      {
        xSpeed = defaultSpeedX; //send the ball right
        rightScore++;
      }
      xPos = (width - radius) / 2;
      yPos = (height - radius) / 2;
      
      if (ballCounter < maxBall) //add another ball everytime one is scored, unless it's at the limit
      ballCounter++;
      
      rand = floor(random(3));

      switch (rand) //randomize one of the six color values every time a ball is scored
      {
        case 0:
          rValueL = round(random(255));
          break;
        case 1:
          gValueL = round(random(255));
          break;
        case 2:
          bValueL = round(random(255));
          break;
      }
      
      if (rand % 2 == 0) //50/50 chance of ball moving up or down upon respawn
      ySpeed = defaultSpeedY;
      else
      ySpeed = defaultSpeedY * -1;
    }
  
    if (yPos + radius >= height || yPos <= 0) //bounce ball off the top and bottom of screen
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
        xPos = width - Paddle.paddleDistance - Paddle.paddleWidth - radius;
        xSpeed *= -1;
      }
    }
    
    if (gameTimer.isFinished()) //speed up the ball when the timer is finished
    {
      if (xSpeed > 0)
      xSpeed++;
      else
      xSpeed--;
      if (ySpeed > 0)
      ySpeed++;
      else
      ySpeed--;
      gameTimer.timerStart(); //restart the timer
    }
    
    //text(millis(), 0, 50); //test the amount of time passed
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
  
  void display()
  {
    //color the ball the inverse of the side it'ss on
    if (xPos > width / 2)
    fill(rValueL, gValueL, bValueL);
    else
    fill(rValueR, gValueR, bValueR);
    
    noStroke();
    rect(xPos, yPos, radius, radius);
  }
  
  
  public int getY()
  {
    return yPos;
  }
  
  
  public int getRad()
  {
    return radius;
  }
  
  
} //end ball class


class Paddle
{
  private int xPos, yPos, paddleR, paddleG, paddleB;
  static final int paddleWidth = 25;
  static final int paddleHeight = 100;
  static final int paddleDistance = 50;
  static final int paddleSpeed = 10;
  
  Paddle(int x, int y)
  {
   xPos = x;
   yPos = y;
   paddleR = 0;
   paddleG = 0;
   paddleB = 0;
  }
  
  
  void display()
  {
   fill(paddleR, paddleG, paddleB);
   noStroke();
   rect(xPos, yPos, paddleWidth, paddleHeight); 
  }
  
  
  void moveUp() //move the paddle up, but not off the screen
  {
    yPos -= paddleSpeed; 
    if (yPos < 0)
    yPos = 0; 
  }
  
  
  void moveDown() //move the paddle down, but not off the screen
  {
    yPos += paddleSpeed;
    if (yPos > height - paddleHeight)
    yPos = height - paddleHeight;
  }
  
  
  void auto() //set paddle to move automatically based on gameBall's yPos
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
  
  
  public void setColor(int r, int g, int b) //change the color of the paddle
  {
    paddleR = r;
    paddleG = g;
    paddleB = b;
  }
  
  
  public int getX()
  {
    return xPos;
  }
  
  
  public int getY()
  {
    return yPos;
  }
  
  
} //end paddle class



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
} //end timer class
