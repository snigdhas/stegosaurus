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
  
  
int N_COLS = 4;
int N_ROWS = 32;
int X_DIM = 300;
int Y_DIM = 1920;

String inputString = "";
String filepath = "/home/pi/stegosaurus/encoderFiles/imageGen/encodedmessage.jpg";

void setup() {
  size(300, 1920);
  background(255, 255, 255);
  noStroke();
  noLoop();
  mapSetup();
  MAROON = color(128, 0, 0);
  PINK = color(244, 66, 140);
  GREEN = color(37, 163, 64);
  BLUE = color(47, 50, 226);
  PURPLE = color(137, 0, 150);
  ENCODED_MESSAGE = processInput();
  drawEncodedMessage();
  printEncodedMessage();
}

String[][] processInput() {
  if (args != null && args.length > 0) {
    for (int i = 0; i < args.length; i++) {
      inputString += args[i] + " ";
    }
  }
  ENCODED_MESSAGE_LENGTH = inputString.length();
  String[][] encodedMessage = new String[ENCODED_MESSAGE_LENGTH][];
  int i = 0;
  for (String c: inputString.toLowerCase().split("")) {
    //System.out.println((String[])ALPHA_MAP.get(c));
    encodedMessage[i] = (String[])ALPHA_MAP.get(c);
    i++;
  }  
  return encodedMessage;
}

void drawEncodedMessage() {
  int offset = 0;
  int x = offset;
  int y = 0;
  Random rand = new Random();
 
  int  n = rand.nextInt(50) + 1;
  int row_height = Y_DIM / N_ROWS;
  int col_width = X_DIM / N_COLS;
  //System.out.println(ENCODED_MESSAGE[0][4]);
  for (int j = 0; j < ENCODED_MESSAGE_LENGTH; j++) {    
    int randTriangle1 = new Random().nextInt(4); 
    int randTriangle2 = new Random().nextInt(4);
    int randRect = new Random().nextInt(3);
    int inc_height = 45;
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
            drawCircle(x + 75 * x_offset, y, fillColor);
          }
          inc_height = 45;
          break;
        case "triangle1":
          switch (randTriangle1) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallTriangleD(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallTriangleU(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawShortTriangleU(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 3:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawShortTriangleD(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break; 
          }
          break;
        case "triangle2":
          switch (randTriangle2) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallTriangleD(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallTriangleU(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawShortTriangleU(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 3:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawShortTriangleD(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break; 
          }
          break;
        case "rectangle":
          switch (randRect) {
            case 0:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawTallRect(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 1:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawLongRect(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
            case 2:
              for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
                drawSquare(x + 75 * x_offset, y, fillColor);
              }
              inc_height = 45;
              break;
          }
          break;
        case "funkyShape":
          for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            drawFunkyShape(x + 75 * x_offset, y, fillColor);
          }
          inc_height = 45;
          break;
        case "pentagon":
          for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            drawPentagon(x + 75 * x_offset, y, fillColor);
          }
          inc_height = 45;
          break;
      }
      x += col_width / 3;
      instr = i.split(" ");
    }
    y += inc_height;
    x += width / N_ROWS / 2;
  } 
}

HashMap<String, String[]> mapSetup() {
  String[] a_string = {"circle PURPLE", "circle GREEN", "circle PURPLE"};
  String[] b_string = {"rectangle MAROON", "rectangle MAROON", "pentagon PURPLE"};
  String[] c_string = {"triangle1 BLUE", "triangle2 PINK", "triangle1 BLUE"};
  String[] d_string = {"triangle1 PINK", "triangle2 BLUE", "triangle1 PINK"};
  String[] e_string = {"funkyShape PURPLE", "circle GREEN", "funkyShape PURPLE"};
  String[] f_string = {"rectangle MAROON", "rectangle PINK", "rectangle MAROON"};
  String[] g_string = {"circle BLUE", "rectangle PINK", "rectangle PINK"};
  String[] h_string = {"funkyShape PURPLE", "funkyShape PINK", "funkyShape GREEN"};
  String[] i_string = {"pentagon MAROON", "rectangle PINK", "pentagon MAROON"};
  String[] j_string = {"triangle1 PURPLE", "triangle2 GREEN", "triangle1 PURPLE"};
  String[] k_string = {"pentagon BLUE", "funkyShape GREEN", "pentagon BLUE"};
  String[] l_string = {"pentagon PURPLE", "triangle1 PURPLE", "pentagon PURPLE"};
  String[] m_string = {"funkyShape GREEN", "pentagon PURPLE", "funkyShape GREEN"};
  String[] n_string = {"rectangle MAROON", "pentagon BLUE", "rectangle MAROON"};
  String[] o_string = {"circle BLUE", "funkyShape MAROON", "circle BLUE"};
  String[] p_string = {"pentagon GREEN", "circle PURPLE", "pentagon GREEN"};
  String[] q_string = {"pentagon PURPLE", "pentagon BLUE", "pentagon GREEN"};
  String[] r_string = {"funkyShape BLUE", "funkyShape PURPLE", "funkyShape BLUE"};
  String[] s_string = {"rectangle GREEN", "rectangle MAROON", "rectangle GREEN"};
  String[] t_string = {"rectangle BLUE", "triangle1 PINK", "triangle1 PINK"};
  String[] u_string = {"funkyShape MAROON", "rectangle BLUE", "rectangle BLUE"};
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
  int h = 40;
  fill(fillColor);
  rect(x1, y1, w, h);
}

void drawLongRect(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 10;
  y1 += w;
  fill(fillColor);
  rect(x1, y1, w, h);
}

void drawSquare(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 20;
  fill(fillColor);
  rect(x1, y1 + h, w, h);
}

void drawTallTriangleD(int x1, int y1, color fillColor) {
  int h = 40;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

void drawTallTriangleU(int x1, int y1, color fillColor) {
  int h = 40;
  int b = 20;
  y1 += h;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 - h);
}

void drawShortTriangleD(int x1, int y1, color fillColor) {
  int h = 30;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 + h);
}

void drawShortTriangleU(int x1, int y1, color fillColor) {
  int h = 30;
  int b = 20;
  y1 += 3 * h / 2;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b / 2, y1 - h);
}

void drawCircle(int x1, int y1, color fillColor) {
  int r = 20;
  fill(fillColor);
  ellipse(x1 + r / 2, y1 + 3 / 2 * r, r, r);
}

void drawFunkyShape(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 20;
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

void drawPentagon(int x1, int y1, color fillColor) {
  fill(fillColor);
  int r = 10;
  pushMatrix();
  translate(x1+r, y1 + 2*r);
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
  drawTallRect(75, 0, BLUE);
  drawTallRect(100, 0, PURPLE);
  drawTallRect(125, 0, MAROON);
  drawLongRect(0, 65, MAROON);
  drawLongRect(25, 65, PINK);
  drawLongRect(50, 65, GREEN);
  drawLongRect(75, 65, BLUE);
  drawLongRect(100, 65, PURPLE);
  drawLongRect(125, 65, MAROON);
  drawTallTriangleD(0, 80, MAROON); 
  drawTallTriangleD(25, 80, PINK);
  drawTallTriangleD(50, 80, GREEN);
  drawTallTriangleD(75, 80, BLUE);
  drawTallTriangleD(100, 80, PURPLE);
  drawTallTriangleD(125, 80, MAROON);
  drawSquare(0, 140, MAROON); 
  drawSquare(25, 140, PINK);
  drawSquare(50, 140, GREEN);
  drawSquare(75, 140, BLUE);
  drawSquare(100, 140, PURPLE);
  drawSquare(125, 140, MAROON);
  drawTallTriangleU(0, 220, MAROON); 
  drawTallTriangleU(25, 220, PINK);
  drawTallTriangleU(50, 220, GREEN);
  drawTallTriangleU(75, 220, BLUE);
  drawTallTriangleU(100, 220, PURPLE);
  drawTallTriangleU(125, 220, MAROON);
  drawShortTriangleD(0, 225, MAROON); 
  drawShortTriangleD(25, 225, PINK);
  drawShortTriangleD(50, 225, GREEN);
  drawShortTriangleD(75, 225, BLUE);
  drawShortTriangleD(100, 225, PURPLE);
  drawShortTriangleD(125, 225, MAROON);
  drawSquare(0, 255, MAROON); 
  drawSquare(25, 255, PINK);
  drawSquare(50, 255, GREEN);
  drawSquare(75, 255, BLUE);
  drawSquare(100, 255, PURPLE);
  drawSquare(125, 255, MAROON);
  drawShortTriangleU(0, 305, MAROON); 
  drawShortTriangleU(25, 305, PINK);
  drawShortTriangleU(50, 305, GREEN);
  drawShortTriangleU(75, 305, BLUE);
  drawShortTriangleU(100, 305, PURPLE);
  drawShortTriangleU(125, 305, MAROON);
  drawCircle(10, 320, MAROON);
  drawCircle(35, 320, PINK);
  drawCircle(60, 320, GREEN);
  drawCircle(85, 320, BLUE);
  drawCircle(110, 320, PURPLE);
  drawCircle(135, 320, MAROON);
  drawFunkyShape(0, 330, MAROON);
  drawFunkyShape(25, 330, PINK);
  drawFunkyShape(50, 330, GREEN);
  drawFunkyShape(75, 330, BLUE);
  drawFunkyShape(100, 330, PURPLE);
  drawFunkyShape(125, 330, MAROON);
  drawPentagon(0, 365, MAROON);
  drawPentagon(25, 365, PINK);
  drawPentagon(50, 365, GREEN);
  drawPentagon(75, 365, BLUE);
  drawPentagon(100, 365, PURPLE);
  drawPentagon(125, 365, MAROON);
}
