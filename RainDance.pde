Dancer dancer[] = new Dancer[8];
Dancer menuDancers[] = new Dancer[10];
Dancer loseScreenDancers[] = new Dancer[10];

CloudSet theClouds;
Rain theRain;
Cursor cursor;
Score score;
BirdSet theBirds;
boolean gameWon = false;
boolean gameLost = false;
boolean menuScreenIsOn = true;
boolean loseScreenIsOn = false;
int numDancersDancing = 0;

interface JavaScript{
	void audioIsSupported();
	void playChirp();
	void setNotePlayable();
	void setNoteUnplayable();
}

void bindJavascript(JavaScript js){
	gameSounds = js;
}

JavaScript gameSounds;

int maxSize = 55;
int minSize = 20;
int birdCount = 0;


void setup(){
	frameRate(60);
	noCursor();
	size(800,600);
	
	for(int i = 0; i < dancer.length; i++){
		setNoteUnplayable();
	}
	
	cursor = new Cursor();
	theClouds = new CloudSet();
	for(int i = 0; i < dancer.length; i++){
		dancer[i] = new Dancer((int)(Math.random()*800),400,(int)(Math.random()*(maxSize - minSize))+minSize)
	}
	for(int i = 0; i < menuDancers.length; i++){
		menuDancers[i] = new Dancer((int)(Math.random()*800),400,(int)(Math.random()*(maxSize - minSize))+minSize);
		menuDancers[i].isDancing = true;
	}
	for(int i = 0; i < loseScreenDancers.length; i++){
		loseScreenDancers[i] = new Dancer((int)(Math.random()*800),400,(int)(Math.random()*(maxSize - minSize))+minSize);
		loseScreenDancers[i].isFrowning = true;
		loseScreenDancers[i].isCrying = true;
	}
	theBirds = new BirdSet();
	theRain = new Rain();
	score = new Score();
	smooth();
}


void draw(){
	if(menuScreenIsOn){
		background(0);
		fill(255,255,255);
		textFont(createFont("Georgia", 36));
		textAlign(CENTER,CENTER);
		text("Rain Dance", width/2, height*(1/6));
		textFont(createFont("Georgia",24));
			if((mouseY > (height*(7/9) - 20))&&(mouseY<height*(7/9)+20)){
				fill(0,0,255);
			}
			textAlign(CENTER,CENTER);
			text("Play",width/2,height*(7/9));
			fill(255,255,255);
			
			textAlign(LEFT,CENTER);
			text("Make it rain before the cloud passes!",width/4,height*(3/9));
			text("Hover the mouse over birds to make them sing.",width/4,height*(4/9));
			text("If enough birds sing, these guys will be happy!",width/4,height*(5/9));			
		
		for(int i = 0; i < menuDancers.length; i++){
			menuDancers[i].update();
		}		
		noStroke();
		fill(255,255,255);
		rect(mouseX,mouseY,5,5);
		return;
	}
	if(loseScreenIsOn){
		background(0);
		textFont(createFont("Georgia", 36));
		textAlign(CENTER,CENTER);
		fill(255,255,255);
		text("The cloud has left without raining!", width/2, height*(1/6));
		if((mouseY > (height*(1/2) - 20))&&(mouseY<height*(1/2)+20)){
			fill(0,0,255);
		}
		text("Play Again",width/2,height*(1/2));
		for(int i = 0; i<loseScreenDancers.length; i++){
			loseScreenDancers[i].update();
		}
		fill(255,255,255);
		rect(mouseX,mouseY,5,5);
		return;
	}

	background(175,175,200);
	theBirds.addBird();
	fill(82,151,52);
	noStroke();
	rect(0, height/1.5, width, height - (height/1.5));
	for(int i = 0; i < dancer.length; i++){
		dancer[i].update();
	}
	if(gameWon){
		theRain.addRainDrop();
		theRain.updateRainDrops();
		fill(255,255,255);
		textFont(createFont("Georgia", 36));
		textAlign(CENTER,CENTER);
		text("You Win!!!", width/2, height*(2/6));
		if((mouseY > (height*(1/2) - 20))&&(mouseY<height*(1/2)+20)){
			fill(0,0,255);
		}
		text("Play Again",width/2,height*(1/2));
	}
	theClouds.update();
	theBirds.updateBirds();
	cursor.update();
	score.update();
}

void mousePressed(){
		if((mouseY > (height*(7/9) - 20))&&(mouseY<height*(7/9)+20)){
			menuScreenIsOn = false;
		}
		if(loseScreenIsOn || gameWon){
			if((mouseY > (height*(1/2) - 20))&&(mouseY<height*(1/2)+20)){
				setup();
				loseScreenIsOn = false;
				gameWon = false;
				menuScreenIsOn = true;
			}
		}
}
