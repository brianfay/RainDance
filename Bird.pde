class Bird{
	int birdSize;
	int flapSpeed = (int)(Math.random()*6)+1+numDancersDancing;
	int flapOffset = 0;
	boolean isFlying = false;
	PVector location;
	int flyDirection = (int)(Math.random()*2);
	float noiseIndex = 0;
	float yOffset = 0;
	int ySpeed = (Math.random()*60)+5;
	int perlinDirection = 1;
	boolean hasCollided = false;
	float chirpIndex = 0;
	float chirpSize = 0;
 
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
		if(hasCollided){
				chirpHalo();
		}
	}
  
	void flap(){	
		if(flapOffset < 0 || flapOffset > birdSize){
			flapSpeed *= -1;
		}
	flapOffset += flapSpeed;
	}
	
	void checkCursor(){
		//Collision Detection to see if the bird is inside the cursor box
		//It's a mess, I know!
		if(hasCollided == true){
			return;
		}
		else{
			if((location.y >= cursor.location.y && 
				location.y <= (cursor.location.y + cursor.cursorSize))
				|| (location.y+birdSize >= cursor.location.y &&
				location.y <= (cursor.location.y + cursor.cursorSize))){
			
					if((location.x >= cursor.location.x && 
						location.x <= (cursor.location.x + cursor.cursorSize))
						|| (location.x+birdSize >= cursor.location.x &&
						location.x <= (cursor.location.x + cursor.cursorSize))){
							//bird has entered bound box, trigger chirp!
							hasCollided = true;
							score.touchBird();
							if(gameSounds.audioIsSupported()){
								gameSounds.playChirp();
								}
							//println("Collision!");
					}		
				}		
		}
	}
	void fly(){
		if(!isFlying){
			isFlying = true;
			if(flyDirection){
				location.x = 0 - birdSize;
			}
			else{
				location.x = width + birdSize;
			}
		}
		if(flyDirection){
			location.x += abs(flapSpeed);
		}
		else{
			location.x -= abs(flapSpeed);
		}
		yOffset = (noise(noiseIndex)-0.5)*perlinDirection*birdSize*0.5;
		if(checkYBounds(location.y + yOffset)){
			location.y += yOffset;
			//println("Bounds Good");
		}
		else{
			location.y -= yOffset;		
			perlinDirection *= -1;
			//println("Bounds Bad");
		}	
		noiseIndex += 0.01;
		update();
	}
	
	void chirpHalo(){
		strokeWeight(3);
		stroke(0,0,255,100);
		chirpSize = abs(sin(chirpIndex));
		chirpIndex += 0.1;
		noFill();
		ellipse(location.x+birdSize/2,location.y+birdSize,birdSize*chirpSize,birdSize*chirpSize);
	}
	
	boolean checkYBounds(float yVal){
		if((yVal < 0) || (yVal > 400 - birdSize)){
			return false;
		}
		else{
			return true;
		}
	}
	
	boolean isDead(){
		if((location.x > (width + birdSize*2)) || (location.x < 0 - birdSize*2)){
			//println("This little birdy is dead!");
			return true;
		}
			return false;	
	}
}
