import csv
import math
import itertools
from copy import copy, deepcopy
import numpy

alphamap = {}
with open('alphamap.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        alphamap[row[0]] = [row[1].lower(), row[2].lower(), row[3].lower()]
# print(alphamap)

shapeArray = []
with open('filename.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        for column in row:
          a = column.replace('[\'', '').replace('\']', '').replace('\'', '').split(',')
          shape = ""
          for attr in a:
              shape += attr.strip(" \'").strip("\')") + " "
          shapeArray.append(shape.strip(" ").lower())
# print(shapeArray)
n_arr = [None] * (math.ceil(len(shapeArray) / 12))
for i in range(12):
    n_arr[i] = shapeArray[30 * i: 30 * i + 30]
    if len(n_arr[i]) != 30:
        n_arr[i] += ["NONE"] * (30-len(n_arr[i]))
    # print(n_arr[i], len(n_arr[i]))
# a = list(itertools.zip_longest(n_arr))
np = numpy.array(n_arr)
print(np.transpose())

# result = [None] * 30
# for i in range(len(result)):
#     result[i] = [1] * 12
# for i in range(len(n_arr)):
#     for j in range(len(n_arr[0])):
#         print(j)
#         result[j][i] = n_arr[i][j]
# print(map(list,zip(*n_arr)))
# for i in n_arr: 
#     print(i, len(i))
# message = [None] * len(n_arr)
# for letter in alphamap:
#     i = n_arr.index(alphamap[letter])
#     print(i)