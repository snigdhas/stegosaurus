
from shapelabeler import ShapeDetector
from colorlabeler import ColorLabeler

import cv2
import imutils
import numpy as np
import matplotlib.pyplot as plt	

img = cv2.imread('../cropping/test6.jpg')
resized = imutils.resize(img, width=600)
ratio = resized.shape[0] / float(img.shape[0])
# cv2.imshow("original", resized)
num_rows, num_cols = resized.shape[:2]

# img = cv2.flip( resized, 1 )
# rotation_matrix = cv2.getRotationMatrix2D((num_cols/2, num_rows/2), 90, 1)
# img = cv2.warpAffine(img, rotation_matrix, (num_cols, num_rows))
# cv2.imshow("rotated", img)
# cv2.waitKey(0)

# rotated = imutils.rotate_bound(resized, 90)
# cv2.imshow("Rotated (Correct)", rotated)
# img = cv2.flip( rotated, 1 )
# cv2.imshow("Rotated flipped", img)
# cv2.waitKey(0)
# cropped = img[40:1040, 140:1780]
# cv2.imshow("cropped", cropped)

#Convert white background to black
gray = cv2.cvtColor(resized, cv2.COLOR_BGR2GRAY)
(thresh, baw) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
wab = cv2.bitwise_not(baw)
wabrgb = cv2.cvtColor(wab,cv2.COLOR_GRAY2RGB)
noBackground = cv2.bitwise_and(resized, wabrgb)

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
		# cv2.imshow("Image", img)
		# cv2.circle(img, (cX, cY), 3, (255, 255, 255), -1)
		# cv2.waitKey(0)
	# cv2.imshow("Image", img)
	# cv2.circle(img, (cX, cY), 3, (255, 255, 255), -1)
# cv2.waitKey(0)

# print(contours)



# img = cv2.imread('../cropping/test6.jpg')
# num_rows, num_cols = img.shape[:2]
# img = cv2.flip( img, 0 )


# If we need to rotate the image
# rotation_matrix = cv2.getRotationMatrix2D((num_cols/2, num_rows/2), 180, 1)
# img = cv2.warpAffine(img, rotation_matrix, (num_cols, num_rows))

# resized = imutils.resize(img, width=1200)
# ratio = resized.shape[0] / float(img.shape[0])



row = []
centers = []
rowMin = contours[0][1]-10
rowMax = contours[0][1]+10

for c in contours:
	cX, cY, shape, color = c
	# cv2.circle(resized, (int(cX*ratio), int(cY*ratio)), 3, (255, 255, 255), -1)
	# cv2.imshow('image',resized)
	# cv2.waitKey(0)
	# print(rowMin, rowMax)

	if rowMin <= cY and cY <= rowMax:
		# row_info.append(shape+' '+color+', ')
		# row_coords.append(cX)
		row.append([cX, cY, shape+' '+color+', '])
	else:
		# print(row_info)
		# row_info = [x for _,x in sorted(zip(row_coords, row_info))]
		# print(cY, len(row_info))
		# print(row_info)
		# print(cY, rowMin, rowMax)
		row.sort()
		# print(row)
		
		# centers.append(row)
		# print(len(row))
		# print(row)
		# print('\n')
		# cv2.waitKey(0)
		centers.append(row)
		row = [[cX, cY, shape+' '+color+', ']]
		rowMin = cY-10
		rowMax = cY+10
# print(centers)

# processed = []
# for row in centers:
# 	for elem in row:
# 		x, y, info = elem
		
# 		cv2.imshow("Image", resized)
# 		cv2.circle(resized, (int(x), int(y)), 3, (255, 255, 255), -1)
# 		cv2.waitKey(0)