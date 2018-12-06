from RPLCD.i2c import CharLCD
import time

lcd = CharLCD('PCF8574', 0x27)
lcd.write_string('Hel world!')
time.sleep(2)

