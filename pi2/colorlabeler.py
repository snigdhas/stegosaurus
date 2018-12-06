from scipy.spatial import distance as dist
from collections import OrderedDict
import numpy as np
import cv2

class ColorLabeler:
	def __init__(self):
	
		colors = OrderedDict({
                        
			"Maroon": (73,49,45),
                        "maroon": (79,55,51),
			"Pink": (125,73,83),
			"Green": (65,84,58),
                        "green":  (55,73,45),
			"Purple": (81,57,90),
			"BluE": (57,71,108),
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