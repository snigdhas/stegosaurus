var ALPHA_MAP = {};
var MAROON;
var PINK;
var YELLOW;
var CYAN;
var PURPLE;
var ENCODED_MESSAGE;
const N_COLS = 8;
const N_ROWS = 20;
const DIM = 1200;

function setup() {
  createCanvas(DIM, DIM);
  background(255, 255, 255);
  stroke(0);
  noLoop();
  mapSetup();
  MAROON = color("#FF9F70");
  PINK = color("#FFA5AB");
  YELLOW = color("#FFEC82");
  CYAN = color("#15877F");
  PURPLE = color("#AED67E");
  // MAROON = color(128, 0, 0);
  // PINK = color(252, 0, 172);
  // YELLOW = color(242, 238, 36);
  // CYAN = color(65, 205, 225);
  // PURPLE = color(137, 0, 150);
  processInput("abcdefghijklmnopqrst");
  drawGrid();
  for (var i = 0; i < N_COLS; i++) {
    drawEncodedMessage(N_ROWS, N_COLS, 150 * i);
  }
}

function processInput(inputString) {
  var message = inputString.toLowerCase().split("");
  ENCODED_MESSAGE = new Array(message.length);
  for (var i = 0; i < message.length; i++) {
    ENCODED_MESSAGE[i] = ALPHA_MAP[message[i]];
  }
  return ENCODED_MESSAGE;
}

function drawGrid() {
  for (var x = 0; x < width; x += width / N_COLS) {
    for (var y = 0; y < height; y += height / N_ROWS) {
      stroke(0);
      strokeWeight(1);
      line(x, 0, x, height);
      line(0, y, width, y);
    }
  }
}

function drawEncodedMessage(N_ROWS, N_COLS, offset) {
  var x = offset;
  var y = 0;
  row_height = width / N_ROWS
  col_width = height / N_COLS
  for (var j = 0; j < ENCODED_MESSAGE.length; j++) {
    code = ENCODED_MESSAGE[j];
    x = offset;
    code.map(function(i) {
      instr = i.split(" ");
      fillColor = instr[1];
      shape = instr[0];
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
    });
    y += row_height;
    x += width / N_ROWS / 2
  }

}

function drawTallRect(x1, y1, fillColor) {
  const w = 20;
  const h = 55;
  fill(fillColor);
  rect(x1, y1, w, h);
}

function drawLongRect(x1, y1, fillColor) {
  const w = 20;
  const h = 10;
  y1 += w;
  fill(fillColor);
  rect(x1, y1, w, h);
}

function drawSquare(x1, y1, fillColor) {
  const w = 20;
  const h = 20;
  fill(fillColor);
  rect(x1, y1 + h, w, h);
}

function drawTallTriangleD(x1, y1, fillColor) {
  const h = 55;
  const b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

function drawTallTriangleU(x1, y1, fillColor) {
  const h = 55;
  const b = 20;
  y1 += h;
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
  y1 += 3 * h / 2;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 - h);
}

function drawCircle(x1, y1, fillColor) {
  const r = 20;
  fill(fillColor);
  ellipse(x1 + r / 2, y1 + 3 / 2 * r, r, r);
}

function drawFunkyShape(x1, y1, fillColor) {
  const w = 20;
  const h = 20;
  y1 += h;
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
  y1 += r * 2;
  push();
  translate(x1 + r, y1 + r);
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
  ALPHA_MAP["a"] = ["circle PURPLE", "circle YELLOW", "circle PURPLE", "circle YELLOW", "circle PURPLE", "circle YELLOW"];
  ALPHA_MAP["b"] = ["shortTriangleU PURPLE", "shortTriangleU CYAN", "shortTriangleU PURPLE", "shortTriangleU CYAN", "shortTriangleU PURPLE", "shortTriangleU CYAN"];
  ALPHA_MAP["c"] = ["tallTriangleU CYAN", "shortTriangleU PINK", "tallTriangleU CYAN", "shortTriangleU PINK", "tallTriangleU CYAN", "shortTriangleU PINK"];
  ALPHA_MAP["d"] = ["shortTriangleU PINK", "tallTriangleU CYAN", "shortTriangleU PINK", "tallTriangleU CYAN", "shortTriangleU PINK", "tallTriangleU CYAN"];
  ALPHA_MAP["e"] = ["tallTriangleU PURPLE", "tallTriangleD YELLOW", "tallTriangleU PURPLE", "tallTriangleD YELLOW", "tallTriangleU PURPLE", "tallTriangleD YELLOW"];
  ALPHA_MAP["f"] = ["tallRectangle MAROON", "square PINK", "tallRectangle MAROON", "tallRectangle MAROON", "square PINK", "tallRectangle MAROON"];
  ALPHA_MAP["g"] = ["circle CYAN", "tallRectangle PINK", "tallRectangle PINK", "circle CYAN", "tallRectangle PINK", "tallRectangle PINK"];
  ALPHA_MAP["h"] = ["funkyShape PURPLE", "funkyShape PURPLE", "funkyShape PURPLE", "funkyShape PURPLE", "funkyShape PURPLE", "funkyShape PURPLE"];
  ALPHA_MAP["i"] = ["pentagon MAROON", "tallRectangle PINK", "pentagon MAROON", "tallRectangle PINK", "pentagon MAROON", "tallRectangle PINK"];
  ALPHA_MAP["j"] = ["longRectangle MAROON", "longRectangle MAROON", "pentagon PURPLE", "longRectangle MAROON", "longRectangle MAROON", "pentagon PURPLE"];
  ALPHA_MAP["k"] = ["funkyShape CYAN", "square PURPLE", "square PURPLE", "funkyShape CYAN", "square PURPLE", "square PURPLE"];
  ALPHA_MAP["l"] = ["pentagon CYAN", "funkyShape MAROON", "pentagon CYAN", "funkyShape MAROON", "pentagon CYAN", "funkyShape MAROON"];
  ALPHA_MAP["m"] = ["longRectangle YELLOW", "square PINK", "longRectangle YELLOW", "square PINK", "longRectangle YELLOW", "square PINK"];
  ALPHA_MAP["n"] = ["tallRectangle CYAN", "square YELLOW", "tallRectangle CYAN", "square YELLOW", "tallRectangle CYAN", "square YELLOW"];
  ALPHA_MAP["o"] = ["tallRectangle CYAN", "tallRectangle YELLOW", "tallRectangle CYAN", "tallRectangle YELLOW", "tallRectangle CYAN", "tallRectangle YELLOW"];
  ALPHA_MAP["p"] = ["pentagon YELLOW", "circle PURPLE", "pentagon YELLOW", "circle PURPLE", "pentagon YELLOW", "circle PURPLE"];
  ALPHA_MAP["q"] = ["pentagon CYAN", "pentagon CYAN", "pentagon CYAN", "pentagon CYAN", "pentagon CYAN", "pentagon CYAN"];
  ALPHA_MAP["r"] = ["funkyShape CYAN", "funkyShape PURPLE", "funkyShape CYAN", "funkyShape PURPLE", "funkyShape CYAN", "funkyShape PURPLE"];
  ALPHA_MAP["s"] = ["longRectangle YELLOW", "longRectangle MAROON", "longRectangle YELLOW", "longRectangle MAROON", "longRectangle YELLOW", "longRectangle MAROON"];
  ALPHA_MAP["t"] = ["tallRectangle CYAN", "tallTriangleU PINK", "tallTriangleU PINK", "tallTriangleU PINK", "tallTriangleU PINK", "tallRectangle CYAN"];
  ALPHA_MAP["u"] = ["funkyShape MAROON", "tallRectangle CYAN", "tallRectangle CYAN", "funkyShape MAROON", "tallRectangle CYAN", "tallRectangle CYAN"];
  ALPHA_MAP["v"] = ["tallTriangleU PINK", "tallTriangleU PINK", "tallRectangle CYAN", "tallTriangleU PINK", "tallTriangleU PINK"];
  ALPHA_MAP["w"] = ["square YELLOW", "tallRectangle MAROON", "tallRectangle MAROON", "square YELLOW", "tallRectangle MAROON", "tallRectangle MAROON"];
  ALPHA_MAP["x"] = ["shortTriangleU MAROON", "shortTriangleU MAROON", "shortTriangleU MAROON", "shortTriangleU MAROON", "shortTriangleU MAROON", "shortTriangleU MAROON"];
  ALPHA_MAP["y"] = ["circle PINK", "square MAROON", "circle PINK", "square MAROON", "circle PINK", "square MAROON"];
  ALPHA_MAP["z"] = ["circle MAROON", "circle MAROON", "circle MAROON", "circle MAROON", "circle MAROON", "circle MAROON"];
  ALPHA_MAP[" "] = ["circle CYAN", "circle YELLOW", "circle PINK", "circle CYAN", "circle YELLOW", "circle PINK"];
}

function drawTestShapes() {
  drawTallRect(0, 0, MAROON);
  drawTallRect(25, 0, PINK);
  drawTallRect(50, 0, YELLOW);
  drawTallRect(75, 0, CYAN);
  drawTallRect(100, 0, PURPLE);
  drawTallRect(125, 0, MAROON);
  drawLongRect(0, 65, MAROON);
  drawLongRect(25, 65, PINK);
  drawLongRect(50, 65, YELLOW);
  drawLongRect(75, 65, CYAN);
  drawLongRect(100, 65, PURPLE);
  drawLongRect(125, 65, MAROON);
  drawTallTriangleD(0, 80, MAROON);
  drawTallTriangleD(25, 80, PINK);
  drawTallTriangleD(50, 80, YELLOW);
  drawTallTriangleD(75, 80, CYAN);
  drawTallTriangleD(100, 80, PURPLE);
  drawTallTriangleD(125, 80, MAROON);
  drawSquare(0, 140, MAROON);
  drawSquare(25, 140, PINK);
  drawSquare(50, 140, YELLOW);
  drawSquare(75, 140, CYAN);
  drawSquare(100, 140, PURPLE);
  drawSquare(125, 140, MAROON);
  drawTallTriangleU(0, 220, MAROON);
  drawTallTriangleU(25, 220, PINK);
  drawTallTriangleU(50, 220, YELLOW);
  drawTallTriangleU(75, 220, CYAN);
  drawTallTriangleU(100, 220, PURPLE);
  drawTallTriangleU(125, 220, MAROON);
  drawShortTriangleD(0, 225, MAROON);
  drawShortTriangleD(25, 225, PINK);
  drawShortTriangleD(50, 225, YELLOW);
  drawShortTriangleD(75, 225, CYAN);
  drawShortTriangleD(100, 225, PURPLE);
  drawShortTriangleD(125, 225, MAROON);
  drawSquare(0, 255, MAROON);
  drawSquare(25, 255, PINK);
  drawSquare(50, 255, YELLOW);
  drawSquare(75, 255, CYAN);
  drawSquare(100, 255, PURPLE);
  drawSquare(125, 255, MAROON);
  drawShortTriangleU(0, 305, MAROON);
  drawShortTriangleU(25, 305, PINK);
  drawShortTriangleU(50, 305, YELLOW);
  drawShortTriangleU(75, 305, CYAN);
  drawShortTriangleU(100, 305, PURPLE);
  drawShortTriangleU(125, 305, MAROON);
  drawCircle(10, 320, MAROON);
  drawCircle(35, 320, PINK);
  drawCircle(60, 320, YELLOW);
  drawCircle(85, 320, CYAN);
  drawCircle(110, 320, PURPLE);
  drawCircle(135, 320, MAROON);
  drawFunkyShape(0, 330, MAROON);
  drawFunkyShape(25, 330, PINK);
  drawFunkyShape(50, 330, YELLOW);
  drawFunkyShape(75, 330, CYAN);
  drawFunkyShape(100, 330, PURPLE);
  drawFunkyShape(125, 330, MAROON);
  drawPentagon(0, 365, MAROON);
  drawPentagon(25, 365, PINK);
  drawPentagon(50, 365, YELLOW);
  drawPentagon(75, 365, CYAN);
  drawPentagon(100, 365, PURPLE);
  drawPentagon(125, 365, MAROON);
}