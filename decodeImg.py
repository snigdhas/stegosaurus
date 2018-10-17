import csv

alphamap = {}
with open('alphamap.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        alphamap[row[0]] = [row[1], row[2], row[3]]
# print(alphamap)

message = ""
with open('encodedImage.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        charEncoding = [row[0], row[1], row[2]]
        for key in alphamap:
            if alphamap[key] == charEncoding:
                message += key
print(message)h
