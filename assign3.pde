final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int SOIL_WIDTH=80;
final int SOIL_HIGHT=80;

final int   STOP=0, HOG_DOWN=1 , HOG_LEFT=2 , HOG_RIGHT=3;
int moveState=0;
boolean hogDown;


int hogX=320;
int hogY=80;


int lifeX;
int lifeY=10;

PImage[]soilImg;
PImage stone1,stone2;
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundHog,down,left,right,imgLife;
PImage bg;


// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

boolean hogPress=false;
float moveRangeY=0;
int viewY;

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
  down=loadImage("img/groundhogDown.png");
  left=loadImage("img/groundhogLeft.png");
  right=loadImage("img/groundhogRight.png");
  
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
      for (int h=2 ; h<27 ; h++){ 
        if(h<6){
          image(soilImg[0],80*i,80*h-viewY);
        }        
        if(h>5 && h<10){
          image(soilImg[1],80*i,80*h-viewY);
        }
        if(h>9 && h<14){         
          image(soilImg[2],80*i,80*h-viewY);
        }
        if(h>13 && h<18){
          image(soilImg[3],80*i,80*h-viewY);
        }
        if(h>17 && h<22){
          image(soilImg[4],80*i,80*h-viewY);
        }
        if(h>21 && h<26){
          image(soilImg[5],80*i,80*h-viewY);
      }
      
      }
            
    }
    
    //stone
    //1-8
    
    for(int i=0 ; i<8 ; i++){
     float x=i*80;
     float y=80*2+80*i;
     image(stone1,x,y-viewY);
    }
    //9-16
    for(int w=0 ; w<8 ; w+=7){
       for(int i=0 ; i<8 ; i+=4){
          float x1=80+i*80;
          float x2=x1+80;
          float y1=80*(8+w+2);         
          image(stone1,x1,y1-viewY);
          image(stone1,x2,y1-viewY);        
        }
    }
        for(int w=0 ; w<8 ; w+=4){
         for(int i=0 ; i<12 ; i+=4){
          float x1=-80+i*80;
          float x2=x1+80;
          float y1=80*(9+w+2);   
          float y2=y1+80; 
          image(stone1,x1,y1-viewY);
          image(stone1,x2,y1-viewY); 
          image(stone1,x1,y2-viewY);
          image(stone1,x2,y2-viewY);   
          }
        }
        
        for(int i=0 ; i<8 ; i+=4){
          float x1=80+i*80;
          float x2=x1+80;
          float y1=80*(11+2);
          float y2=y1+80; 
          image(stone1,x1,y1-viewY);
          image(stone1,x2,y1-viewY);  
          image(stone1,x1,y2-viewY);
          image(stone1,x2,y2-viewY);  
        }

                                           
    //17-24    
  for(int w=-6;w<8;w+=3){  
    for(int i=0; i<8; i++){     
      float x=i*80+80*w;
      float y=80*25-80*i;     
      image(stone1,x,y-viewY);      
     }
  }
  for(int w=-5;w<8;w+=3){  
    for(int i=0; i<8; i++){     
      float x=i*80+80*w;
      float y=80*25-80*i;     
      image(stone1,x,y-viewY);      
     }
  }
  for(int w=-5;w<8;w+=3){  
    for(int i=0; i<8; i++){     
      float x=i*80+80*w;
      float y=80*25-80*i;     
      image(stone2,x,y-viewY);      
     }
  }
     
    
      
      

		// Player
    
    
    switch(moveState){
      
      case  STOP:
      image(groundHog,hogX,hogY);
      break;
      
      case HOG_DOWN: 
            
     if(hogDown){
       image(down,hogX,hogY);
     }else{ image(groundHog,hogX,hogY);
     }
             
     if(viewY>=80*20){
          viewY=80*20;
          hogY+=5;
            if(hogY%80==0){
              moveState=STOP;
              }
        }   
        
      if(hogY>height-80) hogY=height-80;
      /*
      if(hogY%80==0){
        moveState=STOP;
        image(down,hogX,hogY-80);
      }
      */
      
      break;
      
      case  HOG_LEFT:
      image(left,hogX,hogY);
      hogX-=5;
      if(hogX%80==0){
        moveState=STOP;
      }
      if(hogX<0) hogX=width-80;
      break;
      
      case HOG_RIGHT:
      image(right,hogX,hogY);
      hogX+=5;
      if(hogX%80==0){
        moveState=STOP;
      }
      if(hogX>width-80) hogX=0; 
      break;
    }
    
  
   
    
        
      
		// Health UI
      for(int i=0 ; i<playerHealth  ; i++){
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
      case DOWN:      
      moveState=HOG_DOWN;
      viewY +=80;  
      hogDown=true;
      break;
      
      case RIGHT:   
      moveState=HOG_RIGHT;          
        
      break;
      
      case LEFT:
      moveState=HOG_LEFT;       
        
      break;
    }
    
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    hogDown=false;
    break;
  }
}
