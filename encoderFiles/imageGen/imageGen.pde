import processing.net.*;
import java.util.Random;

HashMap<String, String[]> ALPHA_MAP = new HashMap<String, String[]>();
color MAROON;
color PINK;
color GREEN;
color BLUE;
color PURPLE;
String[][] ENCODED_MESSAGE;
int ENCODED_MESSAGE_LENGTH;
    
int N_COLS = 8;
int N_ROWS = 32;
int X_DIM = 600;
int Y_DIM = 990;

String inputString = "";
String filepath = "/home/pi/stegosaurus/encoderFiles/imageGen/encodedmessage.jpg";

void setup() {
  size(2800, 4144);
  scale(4.166);
  background(255, 255, 255);
  stroke(0);
  line(2, 2, 660, 2);
  line(2, 8, 660, 8);
  noStroke();
  noLoop();
  mapSetup();
  MAROON = color(150, 0, 0);
  PINK = color(244, 66, 140);
  GREEN = color(37, 163, 64);
  BLUE = color(47, 50, 226);
  PURPLE = color(137, 0, 150);
  ENCODED_MESSAGE = processInput();
  //int canvasSize = (ENCODED_MESSAGE_LENGTH) * 30; 
  //surface.setSize(300, canvasSize); // comment out to stop canvas resize
  drawEncodedMessage();
  printEncodedMessage();
}

String[][] processInput() {
  if (args != null && args.length > 0) {
    for (int i = 0; i < args.length; i++) {
      inputString += args[i] + " ";
    }
  } else {
    inputString = "abcdefghijklmnopqrstuvwxyz .!?zz";
  }
  ENCODED_MESSAGE_LENGTH = inputString.length();
  String[][] encodedMessage = new String[ENCODED_MESSAGE_LENGTH][];
  int i = 0;
  for (String c: inputString.toLowerCase().split("")) {
    encodedMessage[i] = (String[])ALPHA_MAP.get(c);
    i++;
  }  
  return encodedMessage;
}

void drawEncodedMessage() {
  int offset = 10;
  int x = offset;
  int y = 15;
  int col_width = X_DIM / N_COLS;
  for (int j = 0; j < ENCODED_MESSAGE_LENGTH; j++) {    
    int randTriangle1 = new Random().nextInt(4); 
    int randTriangle2 = new Random().nextInt(4);
    int randRect = new Random().nextInt(3);
    int inc_height = 30;
    int inc_width = 80;
    String[] code = ENCODED_MESSAGE[j];
    x = offset;
    for (int k = 0; k < code.length; k++) {
      String i = code[k];
      String[] instr = i.split(" ");
      String shape = instr[0];
      String fc = instr[1];
      color fillColor;
      switch (fc) {
        case "MAROON": fillColor = MAROON;
          break;
        case "PINK": fillColor = PINK;
          break;
        case "PURPLE": fillColor = PURPLE;
          break;
        case "BLUE": fillColor = BLUE;
          break;
        case "GREEN": fillColor = GREEN;
          break;
        default: fillColor = PINK;
          break;        
      }
      switch (shape) {
        case "circle":
          for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            drawCircle(x + inc_width * x_offset, y, fillColor);
          }
          break;
        case "triangle1":
          switch (randTriangle1) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleU(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleD(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleR(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 3:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleL(x + inc_width * x_offset, y, fillColor);
              }
              break;
          }
          break;
        case "triangle2":
          switch (randTriangle2) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleU(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleD(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleR(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 3:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTriangleL(x + inc_width * x_offset, y, fillColor);
              }
              break;
          }
          break;
        case "rectangle":
          switch (randRect) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawSquare(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawLongRect(x + inc_width * x_offset, y, fillColor);
              }
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallRect(x + inc_width * x_offset, y, fillColor);
              }
              inc_height = 35;
              break;
          }
          break;
        case "star":
          for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            drawStar(x + inc_width * x_offset, y, fillColor);
          }
          break;
        case "pentagon":
          for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            drawPentagon(x + inc_width * x_offset, y, fillColor);
          }
          break;
      }
      x += inc_width / 3;
      instr = i.split(" ");
    }
    y += inc_height;
    x += (4.166 * X_DIM) / N_ROWS / 2;
  } 
}

HashMap<String, String[]> mapSetup() {
  String[] a_string = {"circle PURPLE", "circle GREEN", "circle PURPLE"};
  String[] b_string = {"rectangle MAROON", "rectangle MAROON", "pentagon PURPLE"};
  String[] c_string = {"triangle1 BLUE", "triangle2 PINK", "triangle1 BLUE"};
  String[] d_string = {"triangle1 PINK", "triangle2 BLUE", "triangle1 PINK"};
  String[] e_string = {"star PURPLE", "circle GREEN", "star PURPLE"};
  String[] f_string = {"rectangle MAROON", "rectangle PINK", "rectangle MAROON"};
  String[] g_string = {"circle BLUE", "rectangle PINK", "rectangle PINK"};
  String[] h_string = {"star PURPLE", "star PINK", "star GREEN"};
  String[] i_string = {"pentagon MAROON", "rectangle PINK", "pentagon MAROON"};
  String[] j_string = {"triangle1 PURPLE", "triangle2 GREEN", "triangle1 PURPLE"};
  String[] k_string = {"pentagon BLUE", "star GREEN", "pentagon BLUE"};
  String[] l_string = {"pentagon PURPLE", "triangle1 PURPLE", "pentagon PURPLE"};
  String[] m_string = {"star GREEN", "pentagon PURPLE", "star GREEN"};
  String[] n_string = {"rectangle MAROON", "pentagon BLUE", "rectangle MAROON"};
  String[] o_string = {"circle BLUE", "star MAROON", "circle BLUE"};
  String[] p_string = {"pentagon GREEN", "circle PURPLE", "pentagon GREEN"};
  String[] q_string = {"pentagon PURPLE", "pentagon BLUE", "pentagon GREEN"};
  String[] r_string = {"star BLUE", "star PURPLE", "star BLUE"};
  String[] s_string = {"rectangle GREEN", "rectangle MAROON", "rectangle GREEN"};
  String[] t_string = {"rectangle BLUE", "triangle1 PINK", "triangle1 PINK"};
  String[] u_string = {"star MAROON", "rectangle BLUE", "rectangle BLUE"};
  String[] v_string = {"triangle1 PINK", "triangle1 PINK", "rectangle BLUE"};
  String[] w_string = {"rectangle GREEN", "rectangle MAROON", "rectangle MAROON"};
  String[] x_string = {"triangle1 MAROON", "triangle2 MAROON", "triangle1 MAROON"};
  String[] y_string = {"circle PINK", "rectangle MAROON", "circle PINK"};
  String[] z_string = {"circle MAROON", "circle MAROON", "circle MAROON"};
  String[] space_string = {"circle BLUE", "circle GREEN", "circle PINK"};
  String[] dot_string = {"circle PURPLE", "triangle1 BLUE", "circle PURPLE"};
  String[] bang_string = {"triangle1 BLUE", "circle GREEN", "circle PURPLE"};
  String[] qmark_string = {"circle PURPLE", "triangle1 MAROON", "circle PURPLE"};

  ALPHA_MAP.put("a", a_string);
  ALPHA_MAP.put("b", b_string);
  ALPHA_MAP.put("c", c_string);
  ALPHA_MAP.put("d", d_string);
  ALPHA_MAP.put("e", e_string);
  ALPHA_MAP.put("f", f_string);
  ALPHA_MAP.put("g", g_string);
  ALPHA_MAP.put("h", h_string);
  ALPHA_MAP.put("i", i_string);
  ALPHA_MAP.put("j", j_string);
  ALPHA_MAP.put("k", k_string);
  ALPHA_MAP.put("l", l_string);
  ALPHA_MAP.put("m", m_string);
  ALPHA_MAP.put("n", n_string);
  ALPHA_MAP.put("o", o_string);
  ALPHA_MAP.put("p", p_string);
  ALPHA_MAP.put("q", q_string);
  ALPHA_MAP.put("r", r_string);
  ALPHA_MAP.put("s", s_string);
  ALPHA_MAP.put("t", t_string);
  ALPHA_MAP.put("u", u_string);
  ALPHA_MAP.put("v", v_string);
  ALPHA_MAP.put("w", w_string);
  ALPHA_MAP.put("x", x_string);
  ALPHA_MAP.put("y", y_string);
  ALPHA_MAP.put("z", z_string);
  ALPHA_MAP.put(" ", space_string);
  ALPHA_MAP.put(".", dot_string);
  ALPHA_MAP.put("!", bang_string);
  ALPHA_MAP.put("?", qmark_string);

  return ALPHA_MAP;
}

void drawTallRect(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 30;
  fill(fillColor);
  rect(x1, y1, w, h);
}

void drawLongRect(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 10;
  fill(fillColor);
  rect(x1, y1, w, h);
}

void drawSquare(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 20;
  fill(fillColor);
  rect(x1, y1, w, h);
}

void drawTriangleR(int x1, int y1, color fillColor) {
  int h = 20;
  float b = (h / 2) * sqrt(3); 
  fill(fillColor);
  x1 += 2;
  triangle(x1, y1, x1, y1 + h, x1 + b, y1 + h / 2);
}

void drawTriangleL(int x1, int y1, color fillColor) {
  int h = 20;
  float b = (h / 2) * sqrt(3);
  x1 += 2;
  fill(fillColor);
  triangle(x1 + b, y1, x1 + b, y1 + h, x1, y1 + h / 2);
}

void drawTriangleD(int x1, int y1, color fillColor) {
  int b = 20;
  float h = (b / 2) * sqrt(3);
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

void drawTriangleU(int x1, int y1, color fillColor) {
  int b = 20;
  float h = (b / 2) * sqrt(3);
  fill(fillColor);
  triangle(x1, y1 + h, x1 + b, y1 + h, x1 + b / 2, y1);
}

void drawCircle(int x1, int y1, color fillColor) {
  int r = 20;
  fill(fillColor);
  ellipse(x1 + r / 2, y1 + r / 2, r, r);
}

void drawStar(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 20;
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

void drawPentagon(int x1, int y1, color fillColor) {
  fill(fillColor);
  int r = 10;
  pushMatrix();
  translate(x1 + r, y1 + r);
  scale(1, -1);
  rotate(HALF_PI);
  beginShape();
  for (int i = 0; i < 5; i++) {
    vertex(r * cos(TWO_PI * i / 5), r * sin(TWO_PI * i / 5));
  }
  endShape(CLOSE);
  popMatrix();
}

void printEncodedMessage() {
  save("encodedmessage.jpg");
  while (true) {
    File f = dataFile(filepath);
    if (f.exists()) {
      try {
        Runtime.getRuntime().exec("lp /home/pi/stegosaurus/encoderFiles/imageGen/encodedmessage.jpg");
        break;
      } catch (IOException e) {
        println(e);
      }
      exit();
    }
  }
}

void drawTestShapes() {  
  drawTallRect(0, 0, MAROON);
  drawTallRect(25, 0, PINK);
  drawTallRect(50, 0, GREEN);
  drawTallRect(80, 0, BLUE);
  drawTallRect(100, 0, PURPLE);
  drawTallRect(125, 0, MAROON);
  drawLongRect(0, 65, MAROON);
  drawLongRect(25, 65, PINK);
  drawLongRect(50, 65, GREEN);
  drawLongRect(80, 65, BLUE);
  drawLongRect(100, 65, PURPLE);
  drawLongRect(125, 65, MAROON);
  drawTriangleR(0, 80, MAROON); 
  drawTriangleR(25, 80, PINK);
  drawTriangleR(50, 80, GREEN);
  drawTriangleR(80, 80, BLUE);
  drawTriangleR(100, 80, PURPLE);
  drawTriangleR(125, 80, MAROON);
  drawSquare(0, 140, MAROON); 
  drawSquare(25, 140, PINK);
  drawSquare(50, 140, GREEN);
  drawSquare(80, 140, BLUE);
  drawSquare(100, 140, PURPLE);
  drawSquare(125, 140, MAROON);
  drawTriangleL(0, 220, MAROON); 
  drawTriangleL(25, 220, PINK);
  drawTriangleL(50, 220, GREEN);
  drawTriangleL(80, 220, BLUE);
  drawTriangleL(100, 220, PURPLE);
  drawTriangleL(125, 220, MAROON);
  drawTriangleD(0, 225, MAROON); 
  drawTriangleD(25, 225, PINK);
  drawTriangleD(50, 225, GREEN);
  drawTriangleD(80, 225, BLUE);
  drawTriangleD(100, 225, PURPLE);
  drawTriangleD(125, 225, MAROON);
  drawSquare(0, 255, MAROON); 
  drawSquare(25, 255, PINK);
  drawSquare(50, 255, GREEN);
  drawSquare(80, 255, BLUE);
  drawSquare(100, 255, PURPLE);
  drawSquare(125, 255, MAROON);
  drawTriangleU(0, 305, MAROON); 
  drawTriangleU(25, 305, PINK);
  drawTriangleU(50, 305, GREEN);
  drawTriangleU(80, 305, BLUE);
  drawTriangleU(100, 305, PURPLE);
  drawTriangleU(125, 305, MAROON);
  drawCircle(10, 320, MAROON);
  drawCircle(35, 320, PINK);
  drawCircle(60, 320, GREEN);
  drawCircle(85, 320, BLUE);
  drawCircle(110, 320, PURPLE);
  drawCircle(135, 320, MAROON);
  drawStar(0, 330, MAROON);
  drawStar(25, 330, PINK);
  drawStar(50, 330, GREEN);
  drawStar(80, 330, BLUE);
  drawStar(100, 330, PURPLE);
  drawStar(125, 330, MAROON);
  drawPentagon(0, 365, MAROON);
  drawPentagon(25, 365, PINK);
  drawPentagon(50, 365, GREEN);
  drawPentagon(80, 365, BLUE);
  drawPentagon(100, 365, PURPLE);
  drawPentagon(125, 365, MAROON);
}
