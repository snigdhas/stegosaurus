from shapelabeler import ShapeDetector
from colorlabeler import ColorLabeler
#from randomizdDecoder import decode
import argparse
# import imutils
import csv
from RPLCD.i2c import CharLCD
import time
import picamera
import picamera.array
import cv2
import RPi.GPIO as GPIO
from gpiozero import Button

def alltheCV(image):        
    #resized = imutils.resize(image, width=300)
    #ratio = image.shape[0] / float(resized.shape[0])
    #height, width = image.shape[:2]
    print("runningCV")
    #Convert white background to black
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    (thresh, baw) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    wab = cv2.bitwise_not(baw)
    wabrgb = cv2.cvtColor(wab,cv2.COLOR_GRAY2RGB)
    noBackground = cv2.bitwise_and(image, wabrgb)

    #Blur and threshold the image for curve detection
    blurred = cv2.GaussianBlur(noBackground, (5, 5), 0)
    lab = cv2.cvtColor(blurred, cv2.COLOR_BGR2LAB)
    gray = cv2.cvtColor(noBackground, cv2.COLOR_BGR2GRAY)
    thresh = cv2.threshold(gray, 30, 255, cv2.THRESH_BINARY)[1]

    #Detect contours
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] 

    #Initialize classes
    sd = ShapeDetector()
    cl = ColorLabeler()

    #Finding centers using bounding rectangle
    centers = []
    for c in cnts:
        shape, perimeter = sd.detect(c, 1)
        color = cl.label(lab, c)
        x,y,w,h = cv2.boundingRect(c)
        cX = x+w/2
        cY = y+h/2
        centers.append([cX,cY, perimeter, shape, color])
    return centers

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)
input_state = GPIO.input(18)
button = Button(18)

# Hardware
while True:
    image = None
    with picamera.PiCamera() as camera:
        camera.resolution = (1280, 720);
        
        camera.hflip = True
        camera.start_preview()
        camera.preview.alpha = 255

        input("Press enter")
        #button.wait_for_press()
        
        with picamera.array.PiRGBArray(camera) as stream:
            camera.resolution = (1920, 1080);
            camera.capture(stream, format='bgr')
            image = stream.array
            cv2.imwrite("zoom.jpg", image)
            #shapes = alltheCV(image)
            #textoutput = decode(shapes)
            #lcd = CharLCD('PCF8574', 0x27)
            #lcd.write_string(textoutput)
            time.sleep(20)
