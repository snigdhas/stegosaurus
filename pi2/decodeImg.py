import csv
import math
import itertools
from copy import copy, deepcopy
import numpy

alphamap = {}
with open('alphamap.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        encoding = ', '.join([row[1].lower(), row[2].lower(), row[3].lower()]).replace('triangle1', 'triangle').replace('triangle2', 'triangle')
        alphamap[encoding] = row[0]
# print(alphamap)

shapeArray = []
i = 1
with open('coords_first3.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        for column in row:
            # for i in range(len(column)):
            #     column[i] = column[i].strip(', ')
            if(i<=3): 
                a = column.lower().replace(" ',", "").replace("'", "").replace("[", "").replace("]", "").split(",")
                # print(a[:len(a)-1], len(a)-1)
                shapeArray.append(a[:len(a)-1])
                i += 1
        #   a = column.replace('[\'', '').replace('\']', '').replace('\'', '').split(',')
        #   shape = a
        #   for attr in a:
            #   print(a)
            #   shape += attr.strip(" \'").strip("\')") + " "
        #   shapeArray.append(shape.strip(" ").lower())
# print(shapeArray)
# shapeArray = shapeArray[:30] + shapeArray[31:91]
# print(len(shapeArray))
# n_arr = [None] * (math.ceil(len(shapeArray) / 12))
# n_arr = []
# for i in range(3):
    # n_arr.append(shapeArray[30 * i: 30 * i + 30])
    # print(n_arr[i], len(n_arr[i]))
    # print(30 * i, 30 * i + 30 - 1)
# print(n_arr)
encodedMessage = list(map(list, zip(*shapeArray)))
for i in range(len(encodedMessage)):
    for j in range(len(encodedMessage[i])):
        encodedMessage[i][j] = encodedMessage[i][j].strip()
# encodedMessage = encodedMessage[:len(encodedMessage) - 1]
print(encodedMessage)
decodedMessage = ['_'] * len(encodedMessage) 
for i in range(len(encodedMessage)):
    message = ', '.join(encodedMessage[i])
    # print(message)
    if message in alphamap: 
        decodedMessage[i] = alphamap.get(message)
    else: 
        print(message)

print(''.join(decodedMessage).replace('bang', '!').replace('qmark', '?').replace('space', ' ').replace('dot', '.'), decodedMessage.count("_"))