final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int SOIL_WIDTH=80;
final int SOIL_HIGHT=80;

int hogX=320;
int hogY=80;
int hogMove=80;

int lifeX;
int lifeY=10;

PImage[]soilImg;
PImage stone1,stone2;
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundHog,imgLife;
PImage bg;


// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

boolean hogPress=false;
float moveRangeY=0;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundHog=loadImage("img/groundhogIdle.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
  imgLife=loadImage("img/life.png");
	
  soilImg=new PImage[6];
  for (int i=0; i<6 ; i++){
    soilImg[i]=loadImage("img/soil"+i+".png");
  }
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */
    
    
    
 
  
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

             
    

    
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		for (int i=0 ; i<8 ; i++){      
      for (int h=2 ; h<26 ; h++){ 
        if(h<6){
          image(soilImg[0],80*i,80*h);
        }        
        if(h>5 && h<10){
          image(soilImg[1],80*i,80*h);
        }
        if(h>9 && h<14){         
          image(soilImg[2],80*i,80*h);
        }
        if(h>13 && h<18){
          image(soilImg[3],80*i,80*h);
        }
        if(h>17 && h<22){
          image(soilImg[4],80*i,80*h);
        }
        if(h>21 && h<26){
          image(soilImg[5],80*i,80*h);
      }
      
      }
            
    }
    
    //stone
    //1-8
    for(int i=0 ; i<8 ; i++){
      image(stone1,80*i,80*(i+2));
    }
    //9-16
    for(int i=-3 ; i<8 ; i+=4){   
      for(int h=0 ; h<8 ; h+=4){
      image(stone1,80*i,80*(h+11));
      image(stone1,80*(i+1),80*(h+12));
      }
    }
    
    for(int i=1 ; i<8 ; i+=4){  
      for(int h=0 ; h<8 ;h+=4){
      image(stone1,80*i,80*(h+10));
      image(stone1,80*(i+1),80*(h+13));
      }
    }
    /*
    //17-24
    for(int i=0 ; i<8 ; i++){     
        for(int a=1 ; a<8 ;a++ )
      image(stone1,80*i+a,80*y+a);      
    }        
    for(int i=0 ; i<8 ; i++){
      for(int a=2;a<)
      image(stone1,80*i,80*i);
    }
    */
      
      

		// Player
    image(groundHog,hogX,hogY);
    
  
   
    
        
      
		// Health UI
      for(int i=0 ; i<5 ; i++){
        image(imgLife,10+70*i,lifeY);
      }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
    
    //groundHug
    switch(keyCode){
      case UP:        
        hogY-=hogMove;        
        if(hogY<80) hogY=80;
      break;
      case DOWN:
        hogPress=true;
        moveRangeY +=80;
        hogY+=hogMove;
        if(hogY>height-80) hogY=height-80;
      break;
      case RIGHT:     
        hogX+=hogMove;        
        if(hogX>width-80) hogX=width-80; 
      break;
      case LEFT:
        hogX-=hogMove;
        if(hogX<0) hogX=0;
      break;
    }
    
}

void keyReleased(){
}
