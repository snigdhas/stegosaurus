from picamera import PiCamera
from time import sleep
import RPi.GPIO as GPIO
import cv2

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)
camera = PiCamera();
camera.hflip = True

output = '/home/pi/Desktop/image.jpg';

camera.resolution = (1280, 720);

camera.start_preview()
camera.preview.alpha = 255

def take_picture():
    camera.resolution = (1920, 1080);
    camera.capture(output)
    camera.resolution = (1280, 720);
    camera.stop_preview()
    
while True:
    #input ("Press enter")
    input_mode = GPIO.input(18)
    if input_mode == False:
        take_picture()
        sleep(4)


    

