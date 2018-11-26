from scipy.spatial import distance as dist
from collections import OrderedDict
import numpy as np
import cv2

class ColorLabeler:
	def __init__(self):
	
		colors = OrderedDict({
			"Maroon": (134, 0, 0),
			"Pink": (203,70,126),
			"Green": (45,161,60),
			"Purple": (140, 6, 150),
			"blue": (41, 103, 202),
			"Blue": (45, 51, 233)})
			# "Blue": (26,63,125), 
			# "Pink": (141,40,61), 

		self.lab = np.zeros((len(colors), 1, 3), dtype="uint8")
		self.colorNames = []

		for (i, (name, rgb)) in enumerate(colors.items()):
			self.lab[i] = rgb
			self.colorNames.append(name)

		self.lab = cv2.cvtColor(self.lab, cv2.COLOR_RGB2LAB)

	def label(self, image, c):
		
		mask = np.zeros(image.shape[:2], dtype="uint8")
		cv2.drawContours(mask, [c], -1, 255, -1)
		mask = cv2.erode(mask, None, iterations=2)
		mean = cv2.mean(image, mask=mask)[:3]

		minDist = (np.inf, None)

		for (i, row) in enumerate(self.lab):
			d = dist.euclidean(row[0], mean)
			if d < minDist[0]:
				minDist = (d, i)

		return self.colorNames[minDist[1]]