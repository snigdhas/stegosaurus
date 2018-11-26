from shapelabeler import ShapeDetector
from colorlabeler import ColorLabeler
import argparse
import imutils
import cv2
import csv

#Parse in an image
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True,
	help="path to the input image")
args = vars(ap.parse_args())

#Read and resize the image
image = cv2.imread(args["image"])
resized = imutils.resize(image, width=300)
ratio = image.shape[0] / float(resized.shape[0])
height, width = image.shape[:2]

print(ratio)

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
cnts = cnts[0] if imutils.is_cv2() else cnts[1]

#Initialize classes
sd = ShapeDetector()
cl = ColorLabeler()
output = []

# cv2.imshow('noBack',noBackground)
# cv2.imshow('thresh',thresh)

# Finding centers using moment of shape
# centers = []
# for c in cnts:
# 	if cv2.contourArea(c) > 10:
# 		M = cv2.moments(c)
# 		cX = int(M["m10"] / M["m00"])
# 		cY = int(M["m01"] / M["m00"])
# 		shape = sd.detect(c)
# 	 	color = cl.label(lab, c)
# 		centers.append([cX,cY, shape, color])

#Finding centers using bounding rectangle
centers = []
for c in cnts:
	shape, perimeter = sd.detect(c, ratio)
	color = cl.label(lab, c)
	x,y,w,h = cv2.boundingRect(c)
	cX = x+w/2
	cY = y+h/2
	centers.append([cX,cY, perimeter, shape, color])
		
centersSorted = sorted(centers , key=lambda k: [k[0], k[1]])

curr = 0
col = []
for c in centersSorted:

	if curr > cY: #new column
		output.append(col) #add old column
		col = []
	curr = cY

	cX, cY, length, shape, color = c
	cv2.circle(image, (cX, cY), 3, (255, 255, 255), -1)
	cv2.imshow('image',image)
	print(cX, cY, shape, length, color)
	# print(cX, cY)
	cv2.waitKey(0)
	col.append(shape+' '+color)

output.append(col)

print(output)
	
#Debugging

# cv2.waitKey(0)

#Write to csv file
# with open('coords.csv', 'wb') as myfile:
#     wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
#     wr.writerow(output)
