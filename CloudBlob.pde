class CloudBlob{
   float locationX;
   int locationY;
   int cloudSize = (int)(Math.random()*90+30);
   int cloudColor = (int)(Math.random()*200+50);
   float transparency = 50;
   float xOffset = 0;
   float yOffset = 0;
   
   CloudBlob(){
    locationX = (int)(Math.random()*200);
    locationY = (int)(Math.random()*80);
   }
   
   void update(){
     noStroke();
     fill(cloudColor, transparency);
     ellipse(locationX,locationY,cloudSize,cloudSize);
   }
   
   void changeColor(){
	cloudColor += 0.1;
   }
   
   void moveCloud(){
	locationX += 0.1;
   }
}
