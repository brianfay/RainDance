class CloudSet{
	CloudBlob[] clouds = new CloudBlob[500];
	float cloudLocation = 0;
  
	CloudSet(){
		for(int i = 0; i<clouds.length; i++){
			clouds[i] = new CloudBlob(); 
		}
	}
	
	void update(){
		for(int i = 0; i<clouds.length; i++){
			clouds[i].update(); 
			if(!gameWon){
				clouds[i].moveCloud();
			}
		}
			if(!gameWon){
				cloudLocation += 0.1;
			}	
		if(cloudLocation >= width){
			gameLost = true;
			loseScreenIsOn = true;
		}
	}
}
