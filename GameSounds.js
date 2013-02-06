var context = new webkitAudioContext();
var bound = false;

function bindJavascript(){
  var pjs = Processing.getInstanceById('RainDanceSketch');
	if(pjs!=null){
		pjs.bindJavascript(this);
		bound = true;
	}
	if(!bound)setTimeout(bindJavascript,250);
}
bindJavascript();

var soundSource, soundBuffer;

function playSound(soundSource, ampEnv){
	soundSource.noteOn(context.currentTime);
	soundSource.connect(ampEnv);
	ampEnv.gain.cancelScheduledValues(0);
	ampEnv.gain.setTargetAtTime(0.3, context.currentTime, 0.001);
	ampEnv.gain.setTargetAtTime(0, context.currentTime + 0.25, 0.25);
	ampEnv.connect(context.destination);
	stopSound(soundSource,2);
}

function stopSound(soundSource, time){
	soundSource.noteOff(context.currentTime + time);
}

function playSynth(){
	var cosineHarmonics = new Float32Array([0,0,0]);
	var sineHarmonics = new Float32Array([1,0.3,0.2]);
	var myWaveTable = context.createWaveTable(cosineHarmonics,sineHarmonics);
	var ampEnv = context.createGainNode();
	ampEnv.gain.value = 0;
	var myOsc = context.createOscillator();
	myOsc.setWaveTable(myWaveTable);
	var noteChoice = parseInt((Math.random()*5))
	var theNote = (noteChoice + 1) * 440;
	
	myOsc.frequency.value = theNote;
	playSound(myOsc,ampEnv);
}

window.onload = function(){
	var playButton = document.getElementById("playButton");
	playButton.onclick = function(){playSynth()};
};
