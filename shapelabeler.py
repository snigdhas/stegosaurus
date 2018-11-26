import cv2

class ShapeDetector:
	def __init__(self):
		pass

	def detect(self, c, ratio):
		shape = ""
		peri = cv2.arcLength(c, True)
		approx = cv2.approxPolyDP(c, 0.04 * peri, True)
		perimeter = cv2.arcLength(c,True)


		if len(approx) == 3:
			shape = "triangle"
		elif len(approx) == 4:
			shape = "rectangle"
		elif len(approx) == 5:
			shape = "pentagon"
		elif len(approx) == 8 and perimeter > 71*ratio:
			shape = "star"
		else:

			shape = "circle"
		return shape, len(approx)