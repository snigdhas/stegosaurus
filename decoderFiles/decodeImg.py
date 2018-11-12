import csv

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
n_arr = [None] * (len(shapeArray) // 6)
for i in range(len(n_arr)):
    n_arr[i] = shapeArray[6*i: 6 * i + 6]
    print(n_arr[i])
# print(n_arr)

message = [None] * len(n_arr)
for letter in alphamap:
    i = n_arr.index(alphamap[letter])
    # print(i)