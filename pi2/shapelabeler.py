import cv2

class ShapeDetector:
    def __init__(self):
        pass

    def detect(self, c, ratio):
        shape = ""
        peri = cv2.arcLength(c, True)
        approx = cv2.approxPolyDP(c, 0.04 * peri, True)
        area = cv2.contourArea(c)   
        if area < 40 or peri < 10:
            return shape
        if len(approx) == 3:
            shape = "triangle"
        elif len(approx) == 4:
            shape = "rectangle"
        elif len(approx) == 5 and peri < 95:
            shape = "pentagon"
        elif peri > 105:
            shape = "star"
        else:
            shape = "circle"
        return shape
