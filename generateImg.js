var alphaMap;
var maroon;
var pink;
var yellow;
var cyan;
var purple;
var encodedMessage;

function setup() {
  createCanvas(600, 600);
  background(255, 255, 255);
  stroke(0);
  noLoop();
  alphaMap = mapSetup();
  maroon = color(128, 0, 0);
  pink = color(252, 0, 172);
  yellow = color(242, 238, 36);
  cyan = color(65, 205, 225);
  purple = color(137, 0, 150);
  encodedMessage = processInput("hello");
  drawEncodedMessage(10, 5);
}

function processInput(inputString) {
  var message = inputString.toLowerCase().split("");
  var encodedMessage = new Array(message.length);
  for (var i = 0; i < message.length; i++) { 
    console.log(alphaMap[message[i]]);
    encodedMessage[i] = alphaMap[message[i]];
    console.log(message[i], encodedMessage[i]);
  }
  return encodedMessage;
}

function drawGrid() {
  for (var x = 0; x < width; x += width / 5) {
    for (var y = 0; y < height; y += height / 10) {
      stroke(0);
      strokeWeight(1);
      line(x, 0, x, height);
      line(0, y, width, y);
    }
  }
}

function drawEncodedMessage(n_rows, n_cols) {
  drawGrid();
  var x = 0;
  var y = 0;
  row_height = width / n_rows
  col_width = height / n_cols

  encodedMessage.map(function(code) {
    x = 0;
    n_reps = code.pop();
    code.map(function(i) {
      instr = i.split(" ");
      for (var k = 0; k < n_reps; k++) {
        fillColor = instr.pop();
        shape = instr.pop();
        console.log(x, y, shape, n_reps);
        switch (shape) {
          case "circle":
            drawCircle(x, y, fillColor); 
            break;
          case "tallTriangleU":
            drawTallTriangleU(x, y, fillColor);
            break;
          case "tallTriangleD":
            drawTallTriangleD(x, y, fillColor);
            break;
          case "shortTriangleU":
            drawShortTriangleU(x, y, fillColor);
            break;
          case "shortTriangleD":
            drawShortTriangleD(x, y, fillColor);
            break;
          case "tallRectangle":
            drawTallRect(x, y, fillColor);
            break;
          case "longRectangle":
            drawLongRect(x, y, fillColor);
            break;
          case "funkyShape":
            drawFunkyShape(x, y, fillColor);
            break;
          case "square":
            drawSquare(x, y, fillColor);
            break;
          case "pentagon":
           drawPentagon(x, y, fillColor);
           break;
        }
        x += col_width / 6;
        instr = i.split(" ");
      }
    });
    y += row_height;
    x += width / n_rows / 2
  });

}

function drawTallRect(x1, y1, fillColor) {
  const w = 20;
  const h = 60;
  fill(fillColor);
  rect(x1, y1, w, h);
}

function drawLongRect(x1, y1, fillColor) {
  const w = 20;
  const h = 10;
  fill(fillColor);
  rect(x1, y1, w, h);
}

function drawSquare(x1, y1, fillColor) {
  const w = 20;
  const h = 20;
  fill(fillColor);
  rect(x1, y1, w, h);
}

function drawTallTriangleD(x1, y1, fillColor) {
  const h = 60;
  const b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

function drawTallTriangleU(x1, y1, fillColor) {
  const h = 60;
  const b = 20;
  y1 += width / 10;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 - h);
}

function drawShortTriangleD(x1, y1, fillColor) {
  const h = 30;
  const b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

function drawShortTriangleU(x1, y1, fillColor) {
  const h = 30;
  const b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 - h);
}

function drawCircle(x1, y1, fillColor) {
  const r = 20;
  fill(fillColor);
  ellipse(x1, y1, r, r);
}

function drawFunkyShape(x1, y1, fillColor) {
  const w = 20;
  const h = 20;
  fill(fillColor);
  beginShape();
  vertex(x1, y1);
  vertex(x1 + w / 2, y1 + h / 4);
  vertex(x1 + w, y1);
  vertex(x1 + 3 * w / 4, y1 + h / 2);
  vertex(x1 + w, y1 + h);
  vertex(x1 + w / 2, y1 + 3 * h / 4);
  vertex(x1, y1 + h);
  vertex(x1 + w / 4, y1 + h / 2);
  vertex(x1, y1);
  endShape();
}

function drawPentagon(x1, y1, fillColor) {
  fill(fillColor);
  const r = 10;
  push();
  translate(x1+r, y1+r);
  scale(1, -1);
  rotate(HALF_PI);
  beginShape();
  for (i = 0; i < 5; i++) {
    vertex(r * cos(TWO_PI * i / 5), r * sin(TWO_PI * i / 5));
  }
  endShape(CLOSE);
  pop();
}

function mapSetup() {
  const alphaMap = {};
  alphaMap["a"] = ["circle purple", "circle yellow", "circle purple", "circle yellow", "circle purple", "circle yellow", 0];
  alphaMap["b"] = ["shortTriangleU purple", "shortTriangleU cyan", 3];
  alphaMap["c"] = ["tallTriangleU cyan", "shortTriangleU pink", 3];
  alphaMap["d"] = ["shortTriangleU pink", "tallTriangleU cyan", 3];
  alphaMap["e"] = ["tallTriangleU purple", "tallTriangleD yellow", "3", ];
  alphaMap["f"] = ["tallRectangle maroon", "square pink", "tallRectangle maroon", 2];
  alphaMap["g"] = ["circle cyan", "tallRectangle pink", "tallRectangle pink", 2];
  alphaMap["h"] = ["funkyShape purple", 6];
  alphaMap["i"] = ["pentagon maroon", "tallRectangle pink", 3];
  alphaMap["j"] = ["longRectangle maroon", "longRectangle maroon", "pentagon purple", 2];
  alphaMap["k"] = ["funkyShape cyan", "square purple", "square purple", 2];
  alphaMap["l"] = ["pentagon cyan", "funkyShape maroon", 3];
  alphaMap["m"] = ["longRectangle yellow", "square pink", 3];
  alphaMap["n"] = ["tallRectangle cyan", "shortRectangle yellow", 3];
  alphaMap["o"] = ["tallRectangle cyan", "tallRectangle yellow", 3];
  alphaMap["p"] = ["pentagon yellow", "circle purple", 3];
  alphaMap["q"] = ["pentagon cyan", 6];
  alphaMap["r"] = ["funkyShape cyan", "funkyShape purple", 3];
  alphaMap["s"] = ["longRectangle yellow", "longRectangle maroon", 3];
  alphaMap["t"] = ["tallRectangle cyan", "tallTriangleU pink", "tallTriangleU pink", "tallTriangleU pink", "tallTriangleU pink", "tallRectangle cyan", 0];
  alphaMap["u"] = ["funkyShape maroon", "tallRectangle cyan", "tallRectangle cyan", 2];
  alphaMap["v"] = ["tallTriangleU pink", "tallTriangleU pink", "tallRectangle cyan", "tallTriangleU pink", "tallTriangleU pink", 0];
  alphaMap["w"] = ["square yellow", "tallRectangle maroon", "tallRectangle maroon", 2];
  alphaMap["x"] = ["shortTriangleU maroon", 6];
  alphaMap["y"] = ["circle pink", "square maroon", 3];
  alphaMap["z"] = ["circle maroon", 6];
  alphaMap[" "] = ["circle cyan", "circle yellow", "circle pink", 2];

  return alphaMap;
}

function drawTestShapes() {
  drawTallRect(0, 0, maroon);
  drawTallRect(25, 0, pink);
  drawTallRect(50, 0, yellow);
  drawTallRect(75, 0, cyan);
  drawTallRect(100, 0, purple);
  drawTallRect(125, 0, maroon);
  drawLongRect(0, 65, maroon);
  drawLongRect(25, 65, pink);
  drawLongRect(50, 65, yellow);
  drawLongRect(75, 65, cyan);
  drawLongRect(100, 65, purple);
  drawLongRect(125, 65, maroon);
  drawTallTriangleD(0, 80, maroon);
  drawTallTriangleD(25, 80, pink);
  drawTallTriangleD(50, 80, yellow);
  drawTallTriangleD(75, 80, cyan);
  drawTallTriangleD(100, 80, purple);
  drawTallTriangleD(125, 80, maroon);
  drawSquare(0, 140, maroon);
  drawSquare(25, 140, pink);
  drawSquare(50, 140, yellow);
  drawSquare(75, 140, cyan);
  drawSquare(100, 140, purple);
  drawSquare(125, 140, maroon);
  drawTallTriangleU(0, 220, maroon);
  drawTallTriangleU(25, 220, pink);
  drawTallTriangleU(50, 220, yellow);
  drawTallTriangleU(75, 220, cyan);
  drawTallTriangleU(100, 220, purple);
  drawTallTriangleU(125, 220, maroon);
  drawShortTriangleD(0, 225, maroon);
  drawShortTriangleD(25, 225, pink);
  drawShortTriangleD(50, 225, yellow);
  drawShortTriangleD(75, 225, cyan);
  drawShortTriangleD(100, 225, purple);
  drawShortTriangleD(125, 225, maroon);
  drawSquare(0, 255, maroon);
  drawSquare(25, 255, pink);
  drawSquare(50, 255, yellow);
  drawSquare(75, 255, cyan);
  drawSquare(100, 255, purple);
  drawSquare(125, 255, maroon);
  drawShortTriangleU(0, 305, maroon);
  drawShortTriangleU(25, 305, pink);
  drawShortTriangleU(50, 305, yellow);
  drawShortTriangleU(75, 305, cyan);
  drawShortTriangleU(100, 305, purple);
  drawShortTriangleU(125, 305, maroon);
  drawCircle(10, 320, maroon);
  drawCircle(35, 320, pink);
  drawCircle(60, 320, yellow);
  drawCircle(85, 320, cyan);
  drawCircle(110, 320, purple);
  drawCircle(135, 320, maroon);
  drawFunkyShape(0, 330, maroon);
  drawFunkyShape(25, 330, pink);
  drawFunkyShape(50, 330, yellow);
  drawFunkyShape(75, 330, cyan);
  drawFunkyShape(100, 330, purple);
  drawFunkyShape(125, 330, maroon);
  drawPentagon(0, 365, maroon);
  drawPentagon(25, 365, pink);
  drawPentagon(50, 365, yellow);
  drawPentagon(75, 365, cyan);
  drawPentagon(100, 365, purple);
  drawPentagon(125, 365, maroon);
}