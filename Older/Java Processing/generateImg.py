from tkinter import Tk
from tkinter import Canvas
from tkinter import mainloop

def drawDownTriangle(canvas, x, y, b, h, **kwargs):
    canvas.create_line(x-b/2, y, x+b/2, y, x, y+h, x-b/2, y, **kwargs)

def drawUpTriangle(canvas, x, y, b, h, **kwargs):
    canvas.create_line(x-b/2, y+h, x+b/2, y+h, x, y, x-b/2, y+h, **kwargs)

def drawSquare(canvas, x, y, w, **kwargs):
    canvas.create_rectangle(x, y, x+w, y+w, **kwargs)

def drawDot(canvas, x,  y, **kwargs):
    r = 10
    canvas.create_oval(x-r, y-r, x+r, y+r, **kwargs)

def drawCircle(canvas, x, y, r, **kwargs):
    canvas.create_oval(x-r, y-r, x+r, y+r, **kwargs)

def drawDash(canvas, x, y, w, **kwargs):
    canvas.create_line(x, y, x+w, y, **kwargs)

def drawGrid(canvas, n_rows, n_cols, dim):
    start = 0
    for i in range(n_rows):
        canvas.create_line(0, start, dim, start, dash=(2,2))
        start = dim/n_rows * (i + 1)

    start = 0
    for i in range(n_cols):
        canvas.create_line(start, 0, start, dim, dash=(2,2))
        start = dim/n_cols * (i + 1)

def parseInput(message):
    message = message.lower()
    encodedMessage = []
    for c in message:
        encodedMessage.append(alphaMap[c])
    return encodedMessage

def drawEncodedMessage(Canvas, encodedMessage, dim, n_rows, n_cols):
    x = dim/n_rows / 2
    y = dim/n_rows / 2
    row_height = dim/n_rows 
    col_width = dim/n_cols
    w = 50
    
    for code in encodedMessage:
        color = code[-1]
        for shape in code[:-1]:
            if shape == "DOT":
                drawDot(canvas, x, y, fill=color)
            elif shape == "CIRCLE":
                drawCircle(canvas, x, y, 20, fill=color)
            elif shape == "UPTRIANGLE":
                drawUpTriangle(canvas, x, y, 30, 20, fill=color, width=2)
            elif shape == "DOWNTRIANGLE":
                drawDownTriangle(canvas, x, y, 30, 20, fill=color, width=2)
            elif shape == "SQUARE":
                drawSquare(canvas, x, y, 20, fill=color)
            elif shape == "LINE":
                canvas.create_line(x, y-w/2, x, y+w/2, width=2, fill=color)    
            elif shape == "DASH":
                drawDash(canvas, x-w/2, y, w, width=2, fill=color)
            x += dim/n_rows
            
        x = dim/n_rows / 2
        y += dim/n_rows

master = Tk()
dim = 600

alphaMap = {
    'a': ['DOT', 'black'],
    'b': ['LINE', 'LINE', 'LINE', 'red'],
    'c': ['UPTRIANGLE', 'UPTRIANGLE', 'UPTRIANGLE', 'red'],
    'd': ['LINE', 'CIRCLE', 'LINE', 'red'],
    'e': ['DOT', 'DOT', 'black'],
    'f': ['UPTRIANGLE', 'CIRCLE', 'UPTRIANGLE', 'red'],
    'g': ['SQUARE', 'SQUARE', 'SQUARE', 'red'],
    'h': ['LINE', 'LINE', 'UPTRIANGLE', 'red'],
    'i': ['DOT', 'DOT', 'DOT', 'black'],
    'j': ['UPTRIANGLE', 'SQUARE', 'UPTRIANGLE', 'red'],
    'k': ['LINE', 'LINE', 'LINE', 'blue'],
    'l': ['UPTRIANGLE', 'UPTRIANGLE', 'DOWNTRIANGLE', 'blue'],
    'm': ['LINE', 'CIRCLE', 'LINE', 'blue'],
    'n': ['DOWNTRIANGLE', 'CIRCLE', 'DOWNTRIANGLE', 'blue'],
    'o': ['DOT', 'DOT', 'DOT', 'DOT', 'black'],
    'p': ['SQUARE', 'SQUARE', 'SQUARE', 'blue'],
    'q': ['LINE', 'LINE', 'DOWNTRIANGLE', 'blue'],
    'r': ['DOWNTRIANGLE', 'SQUARE', 'DOWNTRIANGLE', 'blue'],
    's': ['LINE', 'LINE', 'LINE', 'green'],
    't': ['DOWNTRIANGLE', 'DOWNTRIANGLE', 'DOWNTRIANGLE', 'green'],
    'u': ['DOT', 'DOT', 'DOT', 'DOT', 'DOT', 'black'],
    'v': ['LINE', 'CIRCLE', 'LINE', 'green'],
    'w': ['DOWNTRIANGLE', 'CIRCLE', 'DOWNTRIANGLE', 'green'],
    'x': ['SQUARE', 'SQUARE', 'SQUARE', 'green'],
    'y': ['LINE', 'LINE', 'DOWNTRIANGLE', 'green'],
    'z': ['DOWNTRIANGLE', 'SQUARE', 'DOWNTRIANGLE', 'green'],
    ' ': ['CIRCLE', 'CIRCLE', 'CIRCLE', 'green']
}

canvas = Canvas(master, 
           width=dim, 
           height=dim)
canvas.pack()

n_rows = 11
n_cols = 11

# drawGrid(canvas, n_rows, n_cols, dim)
encodedMessage = parseInput("dinosaur")
drawEncodedMessage(canvas, encodedMessage, dim, n_rows, n_cols)
mainloop()
