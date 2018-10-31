from picamera import PiCamera
from time import sleep
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)
camera = PiCamera();
camera.hflip = True

output = '/home/pi/Desktop/image.jpg';

camera.start_preview()
camera.preview.alpha = 0

def take_picture():
    camera.capture(output)
    camera.stop_preview()
    
while True:
    input_state = GPIO.input(18)
    if input_state == False:
        take_picture()
        sleep(4)


    

