class BirdSet{
  ArrayList<Bird> birds;
	
	BirdSet(){
		birds = new ArrayList<Bird>();
	}
	
	void addBird(){
		int randChance = (int)(Math.random()*120);
		if(randChance == 1){
			int size = (int)(Math.random()*50+10);
			int yLoc = (int)(Math.random()*(400-size));
			birds.add(new Bird(400,yLoc,size));
		}
	}
	
	void updateBirds(){

		if(birds.size()){
			for(int i = 0; i < birds.size(); i++){
				Bird b = (Bird)birds.get(i);
				b.fly();
				if(b.isDead()){
					birds.remove(b);
				}
			}
		}
	}	
}
