import csv

alphamap = {}
with open('alphamap.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        alphamap[row[0]] = [row[1], row[2], row[3]]
# print(alphamap)

message = ""
shapeArray = []
with open('filename.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        for column in row:
          a = column.split(',')[2:]
          shape = ""
          for attr in a:
              shape += attr.strip(" \'").strip("\')") + " "
          shapeArray.append(shape.strip(" "))
print(shapeArray)