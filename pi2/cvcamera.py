from picamera.array import PiRGBArray
from picamera import PiCamera
import time
import cv2
import RPi.GPIO as GPIO

num_pics = 0

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)

camera = PiCamera()
camera.hflip = True
rawCapture = PiRGBArray(camera)

output = "/home/pi/Desktop/image.jpg";

camera.start_preview()

def take_picture():
    camera.capture(rawCapture, format="bgr")
    image = rawCapture.array
    cv2.imshow('img', image)
    # cv2.imwrite(output, image)
    cv2.waitKey(0)
    wait_for_button()

def wait_for_button():
    while True:
        input_state = GPIO.input(18)
        if input_state == False:
            take_picture()
            num_pics+=1
            time.sleep(4)


wait_for_button()
