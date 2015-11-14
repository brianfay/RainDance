var contextIsSupported = false;
try{
	var context = new AudioContext();
	contextIsSupported = true;
}
catch(e){
	alert('Note: The Web Audio API is unsupported in this browser. Google Chrome may be a nice alternative');
}
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

function audioIsSupported(){
	return contextIsSupported;
}

var soundSource, soundBuffer;
var majorScale = [0, 2, 4, 5, 7, 9, 11, 12];
var pentatonicScale = [0, 2, 4, 7, 9, 12, 14, 16, 19, 21];	
var donePlaying = true;
var notePlayable = [false,false,false,false,false,false,false,false];

function setNotePlayable(){
	for(var i = 0; i < notePlayable.length; i++){
		if(!notePlayable[i]){
			notePlayable[i] = true;
			return;
		}
	}
}
function setNoteUnplayable(){
	for(var i = notePlayable.length - 1; i >= 0; i--){
		if(notePlayable[i]){
			notePlayable[i] = false;
			return;
		}
	}
}

function stopSound(soundSource, time){
	soundSource.stop(context.currentTime + time);
}

function playChirp(){
	var cosineHarmonics = new Float32Array([0,0,0]);
	var sineHarmonics = new Float32Array([1,0.5,1]);
	var myWaveTable = context.createPeriodicWave(cosineHarmonics,sineHarmonics);
	var ampEnv = context.createGain();
	ampEnv.gain.value = 0;
	var myOsc = context.createOscillator();
	myOsc.setPeriodicWave(myWaveTable);
	var fundamentalFreq = 440;
	var scaleIndex = Math.floor(Math.random()*pentatonicScale.length);
	var actualNote = mtof(fundamentalFreq, pentatonicScale[scaleIndex]);
	
	myOsc.connect(ampEnv);
	myOsc.frequency.value = actualNote * 0.5;
	myOsc.start(context.currentTime);
	myOsc.frequency.setTargetAtTime(actualNote, context.currentTime, 0.05);	
	ampEnv.gain.cancelScheduledValues(0);
	ampEnv.gain.setTargetAtTime(0.1, context.currentTime, 0.001);
	ampEnv.gain.setTargetAtTime(0, context.currentTime + 0.25, 0.25);
	ampEnv.connect(context.destination);
	stopSound(myOsc,2);
}

function playNote(index,startTime){
	if(notePlayable[index]){
	var cosineHarmonics = new Float32Array([0,0,0,0,0,0,0]);
	var sineHarmonics = new Float32Array([1,(1/2),(1/3),(1/4),(1/5),(1/6),(1/7)]);
	var myWaveTable = context.createPeriodicWave(cosineHarmonics,sineHarmonics);
	var ampEnv = context.createGain();
	ampEnv.gain.value = 0;
	var myOsc = context.createOscillator();
	myOsc.setPeriodicWave(myWaveTable);
	var fundamentalFreq = 220;
	var scaleIndex = Math.floor(Math.random()*pentatonicScale.length);
	var actualNote = mtof(fundamentalFreq, pentatonicScale[scaleIndex]);
	
	myOsc.connect(ampEnv);
	myOsc.frequency.value = actualNote;
	myOsc.start(context.currentTime);
	ampEnv.gain.cancelScheduledValues(0);
	ampEnv.gain.setTargetAtTime(0.1, context.currentTime + startTime, 0.001);
	ampEnv.gain.setTargetAtTime(0, context.currentTime + 0.1 + startTime, 0.1);
	ampEnv.connect(context.destination);
	stopSound(myOsc,2 + startTime);
	}
	else{
		donePlaying = true;
		}
}

function scheduler(){
		donePlaying = false;
		for(var i = 0; i<notePlayable.length; i++){
		if(notePlayable[i]){
			playNote(i,i*0.250);
		}	
	}
}
if(contextIsSupported){
	window.setInterval(function(){scheduler()},2000);
}
function mtof(freq, shift){
	var adjFreq = freq*(Math.pow(2,(shift/12)));
	return adjFreq;
}

