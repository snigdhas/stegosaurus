var LCD = require('lcdi2c');
var GPIO = require('onoff').Gpio;
var lcd = new LCD( 1, 0x27, 16, 2 );
var button = new GPIO(4, 'in', 'both');
var text = "hello world";
lcd.clear();
lcd.println(text, 1);

var pushed = false;

function updateText() {
	lcd.clear();
	if (text === "hello world") text = "pushed!";
	else if (text === "pushed!") text = "wow!!!";
	else if (text === "wow!!!") text = "pushed!";
	lcd.print(text);

}

button.watch((err, val) => {
	if (!pushed) updateText();
	if (pushed) pushed = false;
	else pushed = true;
})
