class Cursor{
	PVector location = new PVector(mouseX,mouseY);
	int cursorSize = 25;
	int cursorSpeed = 20;
	void update(){
		location.x = mouseX;
		location.y = mouseY;
		strokeWeight(1);
		stroke(0);
		fill(100, 0, 0, 50);
		rect(location.x,location.y,cursorSize,cursorSize);
		}
	/*	
	boolean checkLowerBound(){
		if(location <= (400 - (cursorSize + cursorSpeed))){
			return true;
		} else{return false;}
	}	
	
	boolean checkUpperBound(){
		if(location >= 0 + cursorSpeed){
			return true;
		} else{return false;}		
	}
	*/	
}

