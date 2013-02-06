class Cursor{
  int location = mouseY;
	int cursorSize = 50;
	int cursorSpeed = 10;
	void update(){
		strokeWeight(1);
		stroke(0);
		fill(100, 0, 0, 50);
		rect(width/2 - cursorSize/2,location,cursorSize,cursorSize);
		}
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
}

void keyPressed(){
	if(key == CODED){
		if(keyCode == UP){
			if(cursor.checkUpperBound()){
				cursor.location-=cursor.cursorSpeed;
				}
		} else if(keyCode == DOWN){
			if(cursor.checkLowerBound()){
				cursor.location+=cursor.cursorSpeed;
				}
		} 
	}
}
