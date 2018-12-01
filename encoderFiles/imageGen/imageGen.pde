import processing.net.*;
import java.util.Random;
import java.io.*;

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
String filepath = "/home/pi/stegosaurus/encoderFiles/imageGen/encodedmessage.jpg";

void setup() {
  size(2800, 4374);
  scale(4.166);
  background(255, 255, 255);
  stroke(0);
  noStroke();
  noLoop();
  MAROON = color(150, 0, 0);
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
  } else {
    inputString = "z .!?";
  }

  ArrayList<String> s = new ArrayList<String>();;
  String t = null;
  try {
    String path = "/home/pi/stegosaurus/encoderFiles/imageGen/randomizedEncoder.py";
    Process p = Runtime.getRuntime().exec(new String[] {"python3", path, "-r", "-e", inputString});
    BufferedReader stdOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
    //BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
    while ((t = stdOut.readLine()) != null) {
       s.add(t);
    }
    // read any errors from the attempted command
    //System.out.println("Here is the standard error of the command (if any):\n");
    //while ((t = stdError.readLine()) != null) {
    //  System.out.println(t);
    //}
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
    //print("CODE: ");
    //println(code);
    x = offset;
    for (int k = 0; k < code.length; k++) {
      String i = code[k].trim();
      //println(i);
      String[] instr = i.split(" ");
      String shape = instr[0];
      String fc = instr[1];
      //print("INSTR: ");
      //print(instr);
      //println(instr.length, " SHAPE: ", shape, " COLOR: ", fc);
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
            //case 2:
            //  for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            //    drawTriangleR(x + inc_width * x_offset, y, fillColor);
            //  }
            //  break;
            //case 3:
            //  for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
            //    drawTriangleL(x + inc_width * x_offset, y, fillColor);
            //  }
            //  break;
          }
          break;
        //case "triangle2":
        //  switch (randTriangle2) {
        //    case 0:
        //      for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
        //        drawTriangleU(x + inc_width * x_offset, y, fillColor);
        //      }
        //      break;
        //    case 1:
        //      for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
        //        drawTriangleD(x + inc_width * x_offset, y, fillColor);
        //      }
        //      break;
        //    //case 2:
        //    //  for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
        //    //    drawTriangleR(x + inc_width * x_offset, y, fillColor);
        //    //  }
        //    //  break;
        //    //case 3:
        //    //  for (int x_offset = 0; x_offset < N_COLS; x_offset++) {
        //    //    drawTriangleL(x + inc_width * x_offset, y, fillColor);
        //    //  }
        //    //  break;
        //  }
        //  break;
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

//void drawTriangleR(int x1, int y1, color fillColor) {
//  int h = 20;
//  float b = (h / 2) * sqrt(3); 
//  fill(fillColor);
//  x1 += 2;
//  triangle(x1, y1, x1, y1 + h, x1 + b, y1 + h / 2);
//}

//void drawTriangleL(int x1, int y1, color fillColor) {
//  int h = 20;
//  float b = (h / 2) * sqrt(3);
//  x1 += 2;
//  fill(fillColor);
//  triangle(x1 + b, y1, x1 + b, y1 + h, x1, y1 + h / 2);
//}

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
  //drawTriangleR(0, 80, MAROON); 
  //drawTriangleR(25, 80, PINK);
  //drawTriangleR(50, 80, GREEN);
  //drawTriangleR(80, 80, BLUE);
  //drawTriangleR(100, 80, PURPLE);
  //drawTriangleR(125, 80, MAROON);
  drawSquare(0, 140, MAROON); 
  drawSquare(25, 140, PINK);
  drawSquare(50, 140, GREEN);
  drawSquare(80, 140, BLUE);
  drawSquare(100, 140, PURPLE);
  drawSquare(125, 140, MAROON);
  //drawTriangleL(0, 220, MAROON); 
  //drawTriangleL(25, 220, PINK);
  //drawTriangleL(50, 220, GREEN);
  //drawTriangleL(80, 220, BLUE);
  //drawTriangleL(100, 220, PURPLE);
  //drawTriangleL(125, 220, MAROON);
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
