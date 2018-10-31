var LCD = require('lcdi2c');
var lcd = new LCD(1, 0x27);
var readline = require('readline');
var GPIO = require('onoff').Gpio;
var button = new GPIO(4, 'in', 'both');
var pushed = false;
var line = 1;
lcd.clear();
var text = "";
var buffer = "x".repeat(24);


readline.emitKeypressEvents(process.stdin);

if (process.stdin.isTTY) process.stdin.setRawMode(true);

process.stdin.on('keypress', (str, key) => {
	if (key.name === "backspace") {
		text = text.substring(0, text.length - 1);
		displayText(text);
	} else if (key.name === "return") {
		print()
	}
	else {	
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
	if (!pushed) print();
	if (pushed) pushed = false;
	else pushed = true;
})

function print() {
	console.log('print text: ' + text);
	text = "";
	lcd.clear();
}

process.stdin.on('keypress', (str, key) => {
	if (key.ctrl && key.name === 'c') {
		process.kill(process.pid, 'SIGINT');
	}
})
