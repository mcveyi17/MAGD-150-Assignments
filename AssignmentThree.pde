
void setup()
{
  size(1280, 800);
  background(80, 140, 210);
}

void draw()
{
  //rect(200, 100, 100, 100);
  fill(15);
  stroke(0);
  strokeWeight(1);
  beginShape();
  vertex(300, 250);
  vertex(980, 250);
  vertex(1030, 400);
  vertex(250, 400);
  endShape(CLOSE);
  
  fill(0, 230, 220);
  stroke(255);
  strokeWeight(3);
 
  triangle(380, 300, 440, 200, 500, 300);
  triangle(640, 400, 835, 100, 1030, 400);
  
  
  //blue part
  noStroke();
  rect(300, 401, 650, 40);
  
  
  //yellow parts
  fill(240, 250, 120);
  noStroke();
  beginShape();
  vertex(440, 220);
  vertex(490, 300);
  vertex(490, 350);
  vertex(390, 350);
  vertex(390, 300);
  endShape(CLOSE);
  
  beginShape();
  vertex(835, 140);
  vertex(970, 350);
  vertex(970, 410);
  vertex(1000, 440);
  vertex(670, 440);
  vertex(700, 410);
  vertex(700, 350);
  endShape(CLOSE);
  
  //chimney
  fill(160, 40, 10);
  rect(600, 120, 60, 150);
  
  //balloons
  strokeWeight(0);
  stroke(0);
  fill(10, 200, 210);
  arc(710, 40, 40, 60, 0, PI*2);
  
  fill(0, 240, 50);
  ellipse(660, 30, 50, 80);
  
  fill(200, 100, 150);
  arc(mouseY, mouseX, 70, 100, 0, PI*2);
  
  fill(250, 160, 10);
  ellipse(mouseX-20, mouseY-20, 40, 70);
  
  
  //balloon strings
  stroke(255);
  strokeWeight(0);
  line(mouseX-20, mouseY+15, 620, 120);
  line(660, 70, 635, 120);
  line(620, 70, 630, 120);
  line(710, 70, 650, 120);
  
  //pink side
  noStroke();
  fill(250, 180, 180);
  rect(300, 440, 370, 400);
  
  
  //green side
  fill(40, 200, 40);
  rect(670, 440, 330, 400);
  fill(50, 230, 50);
  rect(770, 440, 130, 400);
  
  //grey parts
  fill(200);
  
  rect(300, 700, 700, 100);
  fill(210);
  rect(300, 401, 20, 800);
  rect(460, 401, 20, 800);
  
  
  //windows
  fill(0, 0, 30);
  stroke(120, 80, 120);
  strokeWeight(2);
  rect(420, 265, 40, 76);
  line(420, 303, 460, 303);
  rect(800, 260, 70, 120);
  line(800, 320, 870, 320);
  rect(790, 460, 90, 200);
  line(790, 560, 880, 560);
  rect(380, 500, 60, 120);
  line(380, 560, 440, 560);
  
  //door
  fill(150, 50, 30);
  stroke(255);
  rect(500, 500, 100, 200);
  
  
  
}

void mousePressed()
{
  //click to display title
  //title
  fill(255);
  noStroke();
  //u
  beginShape();
  vertex(100, 100);
  vertex(120, 100);
  vertex(120, 150);
  vertex(130, 170);
  vertex(150, 170);
  vertex(160, 150);
  vertex(160, 100);
  vertex(180, 100);
  vertex(180, 160);
  vertex(160, 200);
  vertex(120, 200);
  vertex(100, 160);
  endShape(CLOSE);
  beginShape();
  vertex(200, 100);
  vertex(250, 100);
  vertex(280, 120);
  vertex(280, 150);
  vertex(250, 170);
  vertex(220, 170);
  vertex(220, 200);
  vertex(200, 200);
  endShape(CLOSE);
  
 fill(80, 140, 210);
 ellipse(240, 135, 50, 25);
 stroke(255);
 point(240, 135);
 point(140, 135);
 
}

void keyPressed()
{
 //erase title and clear balloons
 background(#508CD2);
}
