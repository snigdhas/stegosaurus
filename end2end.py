from shapelabeler import ShapeDetector
from colorlabeler import ColorLabeler
from randomizdDecoder import decode
import argparse
import imutils
import csv
from RPLCD.i2c import CharLCD
import time
import picamera
import picamera.array
import cv2
import RPi.GPIO as GPIO
from gpiozero import Button


def brighten(img):
    resized = imutils.resize(img, width=600)
    ratio = resized.shape[0] / float(img.shape[0])
    num_rows, num_cols = resized.shape[:2]

    gray = cv2.cvtColor(resized, cv2.COLOR_BGR2GRAY)
    (thresh, baw) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)

    mean_grey_original = some_value
    mean_greyc = cv2.mean(gray, mask=baw)
    diff = int(mean_grey_original[0]) - int(mean_greyc[0])
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    h,s,v = cv2.split(hsv)
    lim = 255 - diff
    v[v > lim] = 255
    v[v <= lim] += diff
    final_hsv = cv2.merge((h, s, v))
    brightened = cv2.cvtColor(final_hsv, cv2.COLOR_HSV2BGR)
    return (brightened, gray, baw)
    
def imageProcessing(img, gray, baw):
    # resized = imutils.resize(img, width=600)
    # ratio = resized.shape[0] / float(img.shape[0])
    # num_rows, num_cols = resized.shape[:2]

    #Convert white background to black
    # gray = cv2.cvtColor(resized, cv2.COLOR_BGR2GRAY)
    # (thresh, baw) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    wab = cv2.bitwise_not(baw)
    wabrgb = cv2.cvtColor(wab,cv2.COLOR_GRAY2RGB)
    noBackground = cv2.bitwise_and(resized, wabrgb)

    lab = cv2.cvtColor(noBackground, cv2.COLOR_BGR2LAB)
    blurred = cv2.GaussianBlur(noBackground, (1, 1), 0)
    gray_new = cv2.cvtColor(blurred, cv2.COLOR_BGR2GRAY)
    thresh = cv2.threshold(gray_new, 30, 255, cv2.THRESH_BINARY)[1]

    cnts = cv2.findContours(thresh_3.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if imutils.is_cv2() else cnts[1]
    return cnts

def patternDetection(cnts)
    #Initialize classes
    sd = ShapeDetector()
    cl = ColorLabeler()
    contours = []

    for c in cnts:
        shape = sd.detect(c, 3)
        if shape != "":
            color = cl.label(lab, c)
            x,y,w,h = cv2.boundingRect(c)
            cX = x+w/2
            cY = y+h/2
            contours.append([cX, cY, shape, color])

    row = []
    pattern = []
    rowMin = contours[0][1]-10
    rowMax = contours[0][1]+10

    for c in contours:
        cX, cY, shape, color = c
        if rowMin <= cY and cY <= rowMax:
            row.append([cX, cY, shape+' '+color+', '])
        else:
            row.sort()
            pattern.append(row)
            row = [[cX, cY, shape+' '+color+', ']]
            rowMin = cY-10
            rowMax = cY+10

    return pattern

# Old function
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

# Hardware and all of the processing
while True:
    image = None
    with picamera.PiCamera() as camera:
        camera.resolution = (1280, 720);
        
        camera.hflip = True
        camera.start_preview()
        camera.preview.alpha = 255

        #raw_input("Press enter")
        button.wait_for_press()
        
        with picamera.array.PiRGBArray(camera) as stream:
            camera.resolution = (1920, 1080);
            camera.capture(stream, format='bgr')
            image = stream.array
            brightened = brighten(image)
            contours = imageProcessing(brightened)
            pattern = patternDetection(contours)
            textoutput = decode(pattern)
            lcd = CharLCD('PCF8574', 0x27)
            lcd.write_string(textoutput)
            time.sleep(2)