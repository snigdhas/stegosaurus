
from shapelabeler import ShapeDetector
from colorlabeler import ColorLabeler

import cv2
import imutils
import numpy as np
import matplotlib.pyplot as plt	

img = cv2.imread('../cropping/test6.jpg')
num_rows, num_cols = img.shape[:2]
horizontal_img = cv2.flip( img, 0 )


# If we need to rotate the image
# rotation_matrix = cv2.getRotationMatrix2D((num_cols/2, num_rows/2), 180, 1)
# img = cv2.warpAffine(img, rotation_matrix, (num_cols, num_rows))

# cropped = img[40:1040, 140:1780]
# cv2.imshow("cropped", cropped)

resized = imutils.resize(img, width=1200)
ratio = resized.shape[0] / float(img.shape[0])

#Convert white background to black
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
(thresh, baw) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
wab = cv2.bitwise_not(baw)
wabrgb = cv2.cvtColor(wab,cv2.COLOR_GRAY2RGB)
noBackground = cv2.bitwise_and(img, wabrgb)

lab = cv2.cvtColor(noBackground, cv2.COLOR_BGR2LAB)
blurred_3 = cv2.GaussianBlur(noBackground, (1, 1), 0)
gray_3 = cv2.cvtColor(blurred_3, cv2.COLOR_BGR2GRAY)
thresh_3 = cv2.threshold(gray_3, 30, 255, cv2.THRESH_BINARY)[1]

cnts = cv2.findContours(thresh_3.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnts = cnts[0] if imutils.is_cv2() else cnts[1]

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
centers = []
rowMin = contours[0][1]-10
rowMax = contours[0][1]+10

for c in contours:
	cX, cY, shape, color = c
	if rowMin <= cY and cY <= rowMax:
		row.append([cX, cY, shape+' '+color+', '])
	else:
		row.sort(reverse=False)
		centers.append(row)
		row = [[cX, cY, shape+' '+color+', ']]
		rowMin = cY-10
		rowMax = cY+10

# Here need to format the array for the decoder file
