var LCD = require('lcdi2c');
var lcd = new LCD(1, 0x27, 16, 2);
var text = "0123456789012345abcdefghijklmnop";
var buffer = "x".repeat(24);
var textToPrint;
lcd.clear();


function displayText() {
	if (text.length < 16) {
		lcd.print(text);
	} else {
		lcd.print(text.substring(0, 16));
		lcd.print(buffer);
		lcd.print(text.substring(16));
	}
}

displayText();
