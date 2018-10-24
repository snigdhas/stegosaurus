var LCD = require('lcdi2c');
var GPIO = require('onoff').Gpio;
var lcd = new LCD( 1, 0x27, 16, 2 );
var button = new GPIO(4, 'in', 'both');
lcd.clear();
lcd.print('hello world');

button.watch((err, val) => {
	lcd.clear();
	lcd.print('pushed!');
});
