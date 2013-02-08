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

}

function stopSound(soundSource, time){
	soundSource.noteOff(context.currentTime + time);
	soundSource.stop(context.currentTime + time);
}

function playChirp(){
	var cosineHarmonics = new Float32Array([0,0,0]);
	var sineHarmonics = new Float32Array([1,0.5,1]);
	var myWaveTable = context.createWaveTable(cosineHarmonics,sineHarmonics);
	var ampEnv = context.createGainNode();
	ampEnv.gain.value = 0;
	var myOsc = context.createOscillator();
	myOsc.setWaveTable(myWaveTable);
	var fundamentalFreq = 440;
	var pentatonicScale = [0, 2, 4, 7, 9, 12, 14, 16, 19, 21];	
	var scaleIndex = Math.floor(Math.random()*pentatonicScale.length);
	var actualNote = mtof(fundamentalFreq, pentatonicScale[scaleIndex]);
	
	myOsc.connect(ampEnv);
	myOsc.frequency.value = actualNote * 0.5;
	myOsc.noteOn(context.currentTime);
	myOsc.frequency.setTargetAtTime(actualNote, context.currentTime, 0.05);	
	ampEnv.gain.cancelScheduledValues(0);
	ampEnv.gain.setTargetAtTime(0.1, context.currentTime, 0.001);
	ampEnv.gain.setTargetAtTime(0, context.currentTime + 0.25, 0.25);
	ampEnv.connect(context.destination);
	stopSound(myOsc,2);
}

function mtof(freq, shift){
	var adjFreq = freq*(Math.pow(2,(shift/12)));
	return adjFreq;
}

