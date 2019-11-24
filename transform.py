import cv2
import numpy as np
import math

THRESHOLD = 10


def countGradient(x1, x2, y1, y2):
    return ((y2-y1)/(x2-x1)) if (x2-x1) else np.inf


def similarLine(line1, line2):
    sumDiff = 0

    for p1, p2 in zip(line, line2):
        diff = p1 - p2
        diff = diff if diff >= 0 else diff * (-1)
        sumDiff += diff

    avgDiff = sumDiff / 4.0
    return avgDiff < THRESHOLD


img = cv2.imread("image/square.png")
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray, 100, 110)
raw_lines = cv2.HoughLinesP(edges, 1, np.pi/180, 30, maxLineGap=250)
lines = list()
m = list()

for current_line in raw_lines:
    for line in lines:
        if similarLine(line, current_line[0]):
            break
    else:
        x1, y1, x2, y2 = current_line[0]
        lines.append(current_line[0])

        gradient = countGradient(x1, x2, y1, y2)
        m.append(gradient)

        cv2.line(img, (x1, y1), (x2, y2), (0, 255, 0), 3)

print(m)
print(lines)

cv2.imshow("Image", img)
cv2.waitKey(0)
cv2.destroyAllWindows()
