class RainDrop{
  PVector location;
	
	RainDrop(){
		location = new PVector((Math.random()*200 + theClouds.cloudLocation),Math.random()*30+80);
	}
	
	void update(){
		noStroke();
		fill(50,50,255,100);
		ellipse(location.x,location.y,3,7);
		location.y += 3;
	}
	boolean isDead(){
		if(location.y > 400){
			return true;
		}
		return false;
	}
}
