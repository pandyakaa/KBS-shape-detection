import cv2
import numpy as np
import math
import logging
import sys

THRESHOLD = 25


def euclidDistance(x1, x2, y1, y2):
    return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)


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


def adjacentLine(line1, line2):
    L1x1, L1y1, L1x2, L1y2 = line1
    L2x1, L2y1, L2x2, L2y2 = line2

    d1 = euclidDistance(L1x1, L2x1, L1y1, L2y1)
    d2 = euclidDistance(L1x1, L2x2, L1y1, L2y2)
    d3 = euclidDistance(L1x2, L2x1, L1y2, L2y1)
    d4 = euclidDistance(L1x2, L2x2, L1y2, L2y2)

    return d1 < THRESHOLD or d2 < THRESHOLD or d3 < THRESHOLD or d4 < THRESHOLD


img = cv2.imread(sys.argv[1])
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray, 100, 150)
raw_lines = cv2.HoughLinesP(edges, 1, np.pi/180, 30, maxLineGap=250)

lines = list()
adjacent_lines = list()
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

for i in range(len(lines)):
    for j in range(i+1, len(lines)):
        line1 = lines[i]
        line2 = lines[j]

        tuple_line1 = tuple(line1.flat)
        tuple_line2 = tuple(line2.flat)

        if (adjacentLine(line1, line2) and (frozenset((tuple_line1, tuple_line2)) not in adjacent_lines)):
            adjacent_lines.append(frozenset((tuple_line1, tuple_line2)))

print(m)
print(lines)
print(adjacent_lines)

cv2.imshow("Image", img)
cv2.waitKey(0)
cv2.destroyAllWindows()
