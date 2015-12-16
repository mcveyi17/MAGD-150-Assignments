boolean facePalm = false;
int x = 300;
void setup()
{
 size(1280, 800); 
 background(255);
}

void draw()
{
 background(255);
 
 //left person
 stroke(0);
 fill(255);
 ellipse(x, 400, 100, 100);
 line(x, 450, 300, 600);
 line(x, 600, 250, 650);
 line(x, 600, 350, 650);
 line(x, 500, 250, 550);
 line(x, 500, 350, 550);
   //eyes
   fill(0);
   ellipse(285, 390, 5, 5);
   ellipse(315, 390, 5, 5);
   //mouth
   noFill();
   arc(300, 420, 50, 20, QUARTER_PI, HALF_PI+QUARTER_PI);
 
 //text bubble
 noFill();
 stroke(0);
 beginShape();
 vertex(350, 350);
 vertex(370, 330);
 vertex(470, 330);
 vertex(470, 230);
 vertex(270, 230);
 vertex(270, 330);
 vertex(350, 330);
 endShape(CLOSE);

 //text in bubble
 fill(0);
 textSize(12);
 text("Since Donald Trump thinks it's a", 275, 250);
 text("good idea, it's obvious", 275, 270);
 text("that we should do it.", 275, 290);
 
 
 //title
 fill(255);
 rect(490, 1, 420, 50);
 fill(0);
 textSize(42);
 text("Appeal to Authority", 500, 40);
 
 //right person
 stroke(0);
 fill(255);
 ellipse(700, 400, 100, 100);
 line(700, 450, 700, 600);
 line(700, 600, 650, 650);
 line(700, 600, 750, 650);
 
 line(700, 500, 750, 550);
   //eyes
   noFill();
   arc(685, 390, 15, 5, QUARTER_PI, HALF_PI+QUARTER_PI);
   arc(715, 390, 15, 5, QUARTER_PI, HALF_PI+QUARTER_PI);
   //mouth
   noFill();
   arc(700, 440, 50, 20, PI+QUARTER_PI, PI+HALF_PI+QUARTER_PI);
   
   //arm
   if (!facePalm)
   line(700, 500, 650, 550);
   else
   {
     line(700, 500, 670, 450);
     line(670, 450, 700, 390);
   }
}

void keyPressed()
{
 if (facePalm)
 facePalm = false;
 else
 facePalm = true;
}
