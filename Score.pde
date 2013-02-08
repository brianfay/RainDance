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
		checkWinLose();
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
		if(!gameWon){
			dancer[0].stopDancer();
		}
	}
	
	void checkWinLose(){
		if(dancer[(dancer.length-1)].isDancing){
			if(!gameWon){
				gameWon = true;
				//println("You win!");
			}	
		}
		if(gameLost){
				println("You lose!");
				noLoop();
		}
	}
}
