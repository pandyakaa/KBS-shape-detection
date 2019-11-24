import cv2
import numpy as np

def countGradient(x1, x2, y1, y2):
    return((y2-y1)/(x2-x1))

img = cv2.imread("square.png")
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray, 100, 110)
lines = cv2.HoughLinesP(edges, 1, np.pi/180, 30, maxLineGap=250)

print(lines)
m = []
for line in lines:
    x1, y1, x2, y2 = line[0]
    gradient = countGradient(x1, x2, y1, y2)
    m.append(gradient)
    cv2.line(img, (x1,y1), (x2,y2), (0, 255, 0), 3)

print(m)


# cv2.imshow("Edges", edges)
cv2.imshow("Image", img)
cv2.waitKey(0)
cv2.destroyAllWindows()

