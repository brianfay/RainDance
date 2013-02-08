class Rain{
	ArrayList<RainDrop> rain;
	
	Rain(){
		rain = new ArrayList<RainDrop>();
	}
	
	void addRainDrop(){
		rain.add(new RainDrop());
	}
	void updateRainDrops(){
		for(int i = 0; i < rain.size(); i++){
			RainDrop r = (RainDrop)rain.get(i);
				r.update();
				if(r.isDead()){
					rain.remove(r);
				}
		}		
	}
}
