class Score{
  boolean[] birdsTouched = new boolean[10];
	PVector scoreBoardLocation = new PVector(200,500);
	int scoreBoardSize = 10;

	
	Score(){
		for(int i = 0; i < birdsTouched.length; i++){
			birdsTouched[i] = false;
		}
	}
	
	void update(){
		noStroke();
		for(int i = 0; i<birdsTouched.length; i++){
			if(birdsTouched[i]){
				fill(255);
			}
			else{
				fill(100);
			}
			rect(scoreBoardLocation.x+(i*scoreBoardSize*2), scoreBoardLocation.y, scoreBoardSize, scoreBoardSize);
		}
	}
	
	void touchBird(){
		for(i = 0; i<birdsTouched.length; i++){
			if(!birdsTouched[i]){
				birdsTouched[i] = true;
				return;
			}
		}
		for(i = 0; i<birdsTouched.length; i++){
			birdsTouched[i] = false;
		}
		dancer[0].startDancer();
	}
	
	void birdEscaped(){
		for(i = birdsTouched.length - 1; i>=0; i--){
			if(birdsTouched[i]){
				birdsTouched[i] = false;
				return;
			}
		}
		println("Stop Dancer Called");
		dancer[0].stopDancer();
	}
}
