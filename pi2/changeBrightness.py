import cv2
import numpy as np

camera = cv2.imread('../images/resizedrpi1.jpg')
original = cv2.imread('../images/32chars.jpg')

originalg = cv2.cvtColor(original, cv2.COLOR_BGR2GRAY)
(thresh, bawo) = cv2.threshold(originalg, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
mean_greyo = cv2.mean(originalg, mask=bawo)

camerag = cv2.cvtColor(camera, cv2.COLOR_BGR2GRAY)
(thresh, bawc) = cv2.threshold(camerag, 128, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
mean_greyc = cv2.mean(camerag, mask=bawc)
diff = int(mean_greyo[0]) - int(mean_greyc[0])

hsv = cv2.cvtColor(camera, cv2.COLOR_BGR2HSV)
h,s,v = cv2.split(hsv)
lim = 255 - diff
v[v > lim] = 255
v[v <= lim] += diff
final_hsv = cv2.merge((h, s, v))
output = cv2.cvtColor(final_hsv, cv2.COLOR_HSV2BGR)
cv2.imshow("output", output)
cv2.imwrite("brightened.jpg", output)
cv2.waitKey(0)