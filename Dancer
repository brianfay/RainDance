class Dancer{
	boolean isDancing = false;
	boolean isFrowning = false;
	boolean isCrying = false;
	PVector location;
	PVector velocity;
	PVector acceleration;
	PVector[] tearLocation = new PVector[10];
	int tearEye = 1;
	int tearSpeed = (int)(Math.random()*2)+1;
	
	int size;
	int rColor = (int)(Math.random()*127)+127;
	int gColor = 200;
	int bColor = (int)(Math.random()*127)+127;
	float squishOffset, squishSpeed = 1;
	float noiseIndex = 0, bounceIndex = 0, bounceIncr;
	float haloSize;
	float haloIndex = 0;
 
	Dancer(int x, int y, int s){
		location = new PVector(x,y);
		velocity = new PVector(Math.random()-0.5,0);
		bounceIncr = (Math.random()*0.5) + 0.07;
		size = s;
		for(int i = 0; i<tearLocation.length; i++){
			tearLocation.x = location.x + size/2;
			tearLocation.y = location.y + size/10;
		}
	}
  
	void update(){
		acceleration = new PVector((noise(noiseIndex) - 0.5)*0.01,0);
		noiseIndex += 1;
		velocity.add(acceleration);
		location.add(velocity);
		checkXBounds();
		
		//Actually Drawing the Dancer
		beginShape();
		noStroke();
		fill(rColor,gColor,bColor, 180);
		ellipse(location.x,location.y,size + squishOffset,size);
		fill(0);
		ellipse(location.x - (size*0.2) ,location.y - (size*0.1), size*0.2, size*0.2);
		ellipse(location.x + (size*0.2) ,location.y - (size*0.1), size*0.2, size*0.2);
		drawMouth();
		endShape();
		if(isDancing){
			squish();
			bounce();
			danceHalo();
		}
		if(isCrying){
			cry();
		}
		else{
			velocity.y = 0;
		}
	}
  
	void drawMouth(){
		fill(200,0,0);
		if(isDancing){
			vertex(location.x-(size*0.2),location.y+(size*0.2));
			vertex(location.x,location.y+(size*0.4));
			vertex(location.x+(size*0.2),location.y+(size*0.2));
			vertex(location.x-(size*0.2),location.y+(size*0.2));
		} 
		else if(isFrowning){
			vertex(location.x,location.y+(size*0.2));
			vertex(location.x-(size*0.2),location.y+(size*0.3));
			vertex(location.x+(size*0.2),location.y+(size*0.3));
			vertex(location.x,location.y+(size*0.2));
		}
		else{
			ellipse(location.x, location.y + (size*0.2), size*0.4,size*0.1);
			}
	}
	
	void checkXBounds(){
		if((location.x>width) || (location.x<0)){
			velocity.x *= -1;
		}
	}	
	void checkYBounds(){	
		if((location.y>400) || (location.y<0)){
			velocity.y *= -1;
		}
	}
  
	void squish(){
		if(squishOffset < 0 || squishOffset > 10){
			squishSpeed *= -1;
		}
		squishOffset += squishSpeed;
	}
	
	void bounce(){
		checkYBounds();
		velocity.y = sin(bounceIndex);
		//println(velocity.y);
		bounceIndex += bounceIncr;
		if (bounceIndex >= 2 * PI){
			bounceIndex -= 2 * PI;
		};
	}	 
	
	void danceHalo(){
		strokeWeight(3);
		stroke(0,255,0,100);
		haloSize = abs(sin(haloIndex)*2);
		haloIndex += 0.1;
		noFill();
		ellipse(location.x,location.y,size*haloSize,size*haloSize);
	}	
			
	void startDancer(){
	for(int i = 0; i < dancer.length; i++)
			if(!dancer[i].isDancing){
				dancer[i].isDancing = true;
				setNotePlayable();
				numDancersDancing++;
				break;
		}	
	}
	
	void stopDancer(){
	for(int i = dancer.length - 1; i >= 0; i--){
			if(dancer[i].isDancing){
				dancer[i].isDancing = false;
				setNoteUnplayable();
				numDancersDancing--;
				break;
			}
		}
	}
	
	void cry(){
		fill(0,0,255,100);
		tearLocation.x = location.x + (size/5*tearEye);
		ellipse(tearLocation.x,tearLocation.y,2,5);
		tearLocation.y+=tearSpeed;
		if(tearLocation.y > 400 + size/2){
			tearLocation.y = location.y + size/10;
			tearEye *= -1;
		}
	}
}
/*
void mousePressed(){
	dancer[0].startDancer();
}
*/
