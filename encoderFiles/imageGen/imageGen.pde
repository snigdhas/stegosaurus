import processing.net.*;
import java.util.Random;
import java.io.*;
import oscP5.*;
import netP5.*;

color MAROON;
color PINK;
color GREEN;
color BLUE;
color PURPLE;
String[][] ENCODED_MESSAGE;
int ENCODED_MESSAGE_LENGTH;
    
int N_COLS = 8;
int N_ROWS = 34;
int X_DIM = 600;
int Y_DIM = 1050;

String inputString = "";
String filepath = "/home/pi/stegosaurus/encoderFiles/imageGen/";
String filename = "";

boolean messageDrawn = false;

OscP5 oscP5;

void setup() {
  oscP5 = new OscP5(this, 8080);
  size(2800, 4450);
  scale(4.166);
  background(255, 255, 255);
  stroke(0);
  noStroke();
  MAROON = color(150, 0, 0);
  PINK = color(244, 66, 140);
  GREEN = color(37, 163, 64);
  BLUE = color(47, 50, 226);
  PURPLE = color(137, 0, 150);
  //receiveNewMessage("hello!");
}

void draw() {
  scale(4.166);
  if (!messageDrawn) {
    background(255, 255, 255);
    drawEncodedMessage();
    messageDrawn = true;
  }
}

void oscEvent(OscMessage oscMsg) {
  String msg = oscMsg.addrPattern().substring(1);
  println("received: "+ msg);
  ENCODED_MESSAGE = processInput(msg);
  messageDrawn = false;
  printEncodedMessage();
}

String[][] processInput(String message) {
  //inputString = "abcdefghijklmnopqrstuvwxyz .!?zz";
  inputString = message;

  ArrayList<String> s = new ArrayList<String>();
  String t = null;
  try {
    String path = "/home/pi/stegosaurus/encoderFiles/imageGen/randomizedEncoder.py";
    Process p = Runtime.getRuntime().exec(new String[] {"python3", path, "-e", inputString});
    BufferedReader stdOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
    BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
    while ((t = stdOut.readLine()) != null) {
       s.add(t);
       println(t);
    }
    // read any errors from the attempted command
    System.out.println("Here is the standard error of the command (if any):\n");
    while ((t = stdError.readLine()) != null) {
      System.out.println(t);
    }
  } catch (Exception err) {
    err.printStackTrace();
  }

  String[] encodedMessageString = s.get(0).replace("\"", "").split("], ");
  ENCODED_MESSAGE_LENGTH = encodedMessageString.length;
  String[][] encodedMessage = new String[ENCODED_MESSAGE_LENGTH][];
  for (int i = 0; i < ENCODED_MESSAGE_LENGTH; i++) {
    encodedMessage[i] = encodedMessageString[i].replace("[", "").replace("]", "").split(",");
  }
  
  return encodedMessage;
}

void drawEncodedMessage() {
  int offset = 10;
  int x = offset;
  int y = 15;
  int col_width = X_DIM / N_COLS;
  for (int j = 0; j < ENCODED_MESSAGE_LENGTH; j++) {    
    int randTriangle = new Random().nextInt(2);
    int randRect = new Random().nextInt(3);
    int inc_height = 30;
    int inc_width = 80;
    String[] code = ENCODED_MESSAGE[j];
    x = offset;
    for (int k = 0; k < code.length; k++) {
      String i = code[k].trim();
      String[] instr = i.split(" ");
      String shape = instr[0];
      String fc = instr[1];
      color fillColor;
      switch (fc) {
        case "maroon": fillColor = MAROON;
          break;
        case "pink": fillColor = PINK;
          break;
        case "purple": fillColor = PURPLE;
          break;
        case "blue": fillColor = BLUE;
          break;
        case "green": fillColor = GREEN;
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
        case "triangle":
          switch (randTriangle) {
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
  filename = "encoded-" + minute() + second() + ".jpg";
  while (!messageDrawn) {
  }
  save(filename);
  
  while (true) {
    File f = dataFile(filepath + filename);
    if (f.exists()) {
      println("tryn print");
      try {
        println("lp " + filepath + filename);
        Runtime.getRuntime().exec("lp " + filepath + filename);
        break;
      } catch (IOException e) {
        println(e);
      }
      exit();
    }
  }
}
