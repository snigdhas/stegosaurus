var exec = require('child_process').exec;
var LCD = require('lcdi2c');
var lcd = new LCD(1, 0x27);
var readline = require('readline');
var GPIO = require('onoff').Gpio;
var button = new GPIO(4, 'in', 'both');
var LED = new GPIO(17, 'out');
var pushed = false;
var line = 1;
lcd.clear();
var text = "";
var buffer = "x".repeat(24);
var inputEnabled = true;

const OSC = require('osc-js');
const osc = new OSC({ plugin: new OSC.DatagramPlugin()})
osc.open()

LED.writeSync(0)

readline.emitKeypressEvents(process.stdin);

if (process.stdin.isTTY) process.stdin.setRawMode(true);

process.stdin.on('keypress', (str, key) => {
	if (!inputEnabled) return;
	if (key.name === "backspace") {
		text = text.substring(0, text.length - 1);
		displayText(text);
	} else if (key.name === "return") {
		processText()
	}
	else {
		str = str.toLowerCase();
		if (!(/^[a-z]/.test(str) || str==="!" || str===" " || str==="." || str==="?")) return;
		text += str;
		if (text.length > 32) text = text.substring(0, 32);
		if (text.length === 17) lcd.print(buffer);
		lcd.print(str)
		//if (text.length <= 16) lcd.print(str);
		//if (text.length === 16) lcd.print(buffer);
		//if (text.length > 16) lcd.print(str);
	}
	
})


function displayText(s) {
	const lineLength = 16;
	if (s.length < lineLength) {
		lcd.clear();
		lcd.print(s);
	}
	else {
		lcd.clear();
		lcd.print(s.substring(0, lineLength));
		lcd.print(buffer);
		lcd.print(s.substring(lineLength));
	}
}

button.watch((err, val) => {
	console.log("button pressed");
	if (!pushed) {
		processText();
	}
	if (pushed) pushed = false;
	else pushed = true;
})

function processText() {
	// writes out to shell
	
	// exec('processing-java --sketch="/home/pi/stegosaurus/encoderFiles/imageGen" --run ' + text, (err, stdout, stderr) => {
	// 	        console.log(`stdout: ${stdout}`);
	// 	        console.log(`stderr: ${stderr}`);
	// 	        if (err !== null) {
	// 			            console.log(`exec error: ${err}`);
	//			        }
	// });
	// console.log("printed");
	disableInput();
	setTimeout(enableInput, 20000);
	console.log(text);	
	osc.send(new OSC.Message("/msg", text), {port: 8080});
	console.log("message sent");

	text = "";
}

var periodInterval;

function enableInput() {
	LED.writeSync(0);
	clearInterval(periodInterval);
	console.log("input enabled");
	inputEnabled = true;
	lcd.clear();
}

function disableInput() {
	LED.writeSync(1);
	console.log("input disabled");
	inputEnabled = false;
	lcd.clear();
	periods = 0;
	lcd.print("printing");
	periodInterval = setInterval(() => {
		if (periods === 3) {
			lcd.clear();
			lcd.print("printing");
			periods = 0;
		} else {
			lcd.print(".");
			periods += 1;
		}
	}, 800)
}

process.stdin.on('keypress', (str, key) => {
	if (key.ctrl && key.name === 'c') {
		process.kill(process.pid, 'SIGINT');
	}
})
