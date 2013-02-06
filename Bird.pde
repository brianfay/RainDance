class Bird{
  int birdSize;
	int flapSpeed = 3;
	int flapOffset = 0;
	PVector location;
 
	int rColor = (int)(Math.random()*127)+127;;
	int gColor = (int)(Math.random()*127)+127;
	int bColor = 0;  
  
	Bird(int x, int y, int s){
		location = new PVector(x,y);
		birdSize = s;
	}
  
	void update(){
		flap();
		checkCursor();
		beginShape();
		noFill();
		strokeWeight(5);
		stroke(rColor,gColor,bColor);
		vertex(location.x, location.y + flapOffset);
		vertex(location.x + birdSize/2, birdSize + location.y);
		vertex(birdSize + location.x,location.y + flapOffset);
		endShape();
	}
  
	void flap(){	
		if(flapOffset < 0 || flapOffset > 20){
			flapSpeed *= -1;
		}
	flapOffset += flapSpeed;
	}
	
	void checkCursor(){
		//Collision Detection to see if the bird is inside the cursor box
		//It's a mess, I know!
		
		if((location.y >= cursor.location && 
			location.y <= (cursor.location + cursor.cursorSize))
			|| (location.y+birdSize >= cursor.location &&
			location.y <= (cursor.location + cursor.cursorSize))){
		
			if(((location.x >= (width/2 - cursor.cursorSize/2)) &&
			 (location.x <= (width/2 - cursor.cursorSize/2 + cursor.cursorSize)))
			
			|| (((location.x+birdSize) >= (width/2 - cursor.cursorSize/2)) &&
			 (location.x <= (width/2 - cursor.cursorSize/2 + cursor.cursorSize)))){
				println("Collision!");
			}	
			
		}
		
	}
}
