import processing.net.*;

void setup() {
  size(600, 600);
  background(255, 255, 255);
  noStroke();
  noLoop();
  mapSetup();
  color maroon = color(128, 0, 0);
  color pink = color(252, 0, 172);
  color yellow = color(242, 238, 36);
  color cyan = color(65, 205, 225);
  color purple = color(137, 0, 150);
  processInput("hello world");
  //drawTallRect(0, 0, maroon);
  //drawTallRect(25, 0, pink);
  //drawTallRect(50, 0, yellow);
  //drawTallRect(75, 0, cyan);
  //drawTallRect(100, 0, purple);
  //drawTallRect(125, 0, maroon);
  //drawLongRect(0, 65, maroon);
  //drawLongRect(25, 65, pink);
  //drawLongRect(50, 65, yellow);
  //drawLongRect(75, 65, cyan);
  //drawLongRect(100, 65, purple);
  //drawLongRect(125, 65, maroon);
  //drawTallTriangleD(0, 80, maroon); 
  //drawTallTriangleD(25, 80, pink);
  //drawTallTriangleD(50, 80, yellow);
  //drawTallTriangleD(75, 80, cyan);
  //drawTallTriangleD(100, 80, purple);
  //drawTallTriangleD(125, 80, maroon);
  //drawSquare(0, 140, maroon); 
  //drawSquare(25, 140, pink);
  //drawSquare(50, 140, yellow);
  //drawSquare(75, 140, cyan);
  //drawSquare(100, 140, purple);
  //drawSquare(125, 140, maroon);
  //drawTallTriangleU(0, 220, maroon); 
  //drawTallTriangleU(25, 220, pink);
  //drawTallTriangleU(50, 220, yellow);
  //drawTallTriangleU(75, 220, cyan);
  //drawTallTriangleU(100, 220, purple);
  //drawTallTriangleU(125, 220, maroon);
  //drawShortTriangleD(0, 225, maroon); 
  //drawShortTriangleD(25, 225, pink);
  //drawShortTriangleD(50, 225, yellow);
  //drawShortTriangleD(75, 225, cyan);
  //drawShortTriangleD(100, 225, purple);
  //drawShortTriangleD(125, 225, maroon);
  //drawSquare(0, 255, maroon); 
  //drawSquare(25, 255, pink);
  //drawSquare(50, 255, yellow);
  //drawSquare(75, 255, cyan);
  //drawSquare(100, 255, purple);
  //drawSquare(125, 255, maroon);
  //drawShortTriangleU(0, 305, maroon); 
  //drawShortTriangleU(25, 305, pink);
  //drawShortTriangleU(50, 305, yellow);
  //drawShortTriangleU(75, 305, cyan);
  //drawShortTriangleU(100, 305, purple);
  //drawShortTriangleU(125, 305, maroon);
  //drawCircle(10, 320, maroon);
  //drawCircle(35, 320, pink);
  //drawCircle(60, 320, yellow);
  //drawCircle(85, 320, cyan);
  //drawCircle(110, 320, purple);
  //drawCircle(135, 320, maroon);
  //drawFunkyShape(0, 330, maroon);
  //drawFunkyShape(25, 330, pink);
  //drawFunkyShape(50, 330, yellow);
  //drawFunkyShape(75, 330, cyan);
  //drawFunkyShape(100, 330, purple);
  //drawFunkyShape(125, 330, maroon);
  //drawPentagon(0, 365, maroon);
  //drawPentagon(25, 365, pink);
  //drawPentagon(50, 365, yellow);
  //drawPentagon(75, 365, cyan);
  //drawPentagon(100, 365, purple);
  //drawPentagon(125, 365, maroon);
  //.split("\\s")
}

void processInput(String input){
  String[] message = input.toLowerCase().toCharArray();
  for c in message:
        encodedMessage.append(alphaMap[c])
    return encodedMessage
}

HashMap<String, String[]> mapSetup() {
  String[] a_string = {"circle purple", "circle yellow", "3"};
  String[] b_string = {"shortTriangle purple", "shortTriangle cyan", "3"};
  String[] c_string = {"tallTriangleU cyan", "shortTriangleU pink", "3"};
  String[] d_string = {"shortTriangle pink", "tallTriangleU cyan", "3"};
  String[] e_string = {"tallTriangleUU purple", "tallTriangleUD yellow", "3", };
  String[] f_string = {"tallRectangle maroon", "square pink", "tallRectangle maroon", "2"};
  String[] g_string = {"circle cyan", "tallRectangle pink", "tallRectangle pink", "2"};
  String[] h_string = {"wonkyTriangle purple", "6"};
  String[] i_string = {"pentagon maroon", "tallRectangle pink", "3"};
  String[] j_string = {"longRectangle maroon", "longRectangle maroon", "pentagon purple", "2"};
  String[] k_string = {"wonkyTriangle cyan", "square purple", "square purple", "2"};
  String[] l_string = {"pentagon cyan", "wonkyTriangle maroon", "3"};
  String[] m_string = {"longRectangle yellow", "square pink", "3"};
  String[] n_string = {"tallRectangle cyan", "shortRectangle yellow", "3"};
  String[] o_string = {"tallRectangle cyan", "tallRectangle yellow", "3"};
  String[] p_string = {"pentagon yellow", "circle purple", "3"};
  String[] q_string = {"pentagon cyan", "6"};
  String[] r_string = {"wonkyTriangle cyan", "wonkyTriangle purple", "3"};
  String[] s_string = {"longRectangle yellow", "longRectangle maroon", "3"};
  String[] t_string = {"tallRectangle cyan", "tallTriangleU pink", "tallTriangleU pink", "tallTriangleU pink", "tallTriangleU pink", "tallRectangle cyan", "0"};
  String[] u_string = {"wonkyTriangle maroon", "tallRectangle cyan", "tallRectangle cyan", "2"};
  String[] v_string = {"tallTriangleU pink", "tallTriangleU pink", "tallRectangle cyan", "tallTriangleU pink", "tallTriangleU pink", "0"};
  String[] w_string = {"square yellow", "tallRectangle maroon", "tallRectangle maroon", "2"};
  String[] x_string = {"shortTriangle maroon", "6"};
  String[] y_string = {"circle pink", "square maroon", "3"};
  String[] z_string = {"circle maroon", "6"};
  String[] space_string = {"circle cyan", "circle yellow", "circle pink", "2"};

  HashMap<String, String[]> alphaMap = new HashMap<String, String[]>();
  alphaMap.put("a", a_string);
  alphaMap.put("b", b_string);
  alphaMap.put("c", c_string);
  alphaMap.put("d", d_string);
  alphaMap.put("e", e_string);
  alphaMap.put("f", f_string);
  alphaMap.put("g", g_string);
  alphaMap.put("h", h_string);
  alphaMap.put("i", i_string);
  alphaMap.put("j", j_string);
  alphaMap.put("k", k_string);
  alphaMap.put("l", l_string);
  alphaMap.put("m", m_string);
  alphaMap.put("n", n_string);
  alphaMap.put("o", o_string);
  alphaMap.put("p", p_string);
  alphaMap.put("q", q_string);
  alphaMap.put("r", r_string);
  alphaMap.put("s", s_string);
  alphaMap.put("t", t_string);
  alphaMap.put("u", u_string);
  alphaMap.put("v", v_string);
  alphaMap.put("w", w_string);
  alphaMap.put("x", x_string);
  alphaMap.put("y", y_string);
  alphaMap.put("z", z_string);
  alphaMap.put(" ", space_string);

  return alphaMap;
}

void drawPentagon(int x1, int y1, color fillColor) {
  fill(fillColor);
  int r = 10;
  pushMatrix();
  translate(x1+r, y1);
  scale(1, -1);
  rotate(HALF_PI);
  beginShape();
  for (int i = 0; i < 5; i++) {
    vertex(r * cos(TWO_PI * i / 5), r * sin(TWO_PI * i / 5));
  }
  endShape(CLOSE);
  popMatrix();
}

void drawTallRect(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 60;
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

void drawTallTriangleD(int x1, int y1, color fillColor) {
  int h = 60;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b/2, y1 + h);
}

void drawTallTriangleU(int x1, int y1, color fillColor) {
  int h = 60;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b/2, y1 - h);
}

void drawShortTriangleD(int x1, int y1, color fillColor) {
  int h = 30;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b/2, y1 + h);
}  

void drawShortTriangleU(int x1, int y1, color fillColor) {
  int h = 30;
  int b = 20;
  fill(fillColor);
  triangle(x1, y1, x1 + b, y1, x1 + b/2, y1 - h);
}

void drawCircle(int x1, int y1, color fillColor) {
  int r = 20;
  fill(fillColor);
  ellipse(x1, y1, r, r);
}

void drawFunkyShape(int x1, int y1, color fillColor) {
  int w = 20;
  int h = 20;
  fill(fillColor);
  beginShape();
  vertex(x1, y1);
  vertex(x1 + w/2, y1 + h/4);
  vertex(x1 + w, y1);
  vertex(x1 + 3*w/4, y1 + h/2);
  vertex(x1 + w, y1 + h);
  vertex(x1 + w/2, y1 + 3 * h/4);
  vertex(x1, y1 + h);
  vertex(x1 + w/4, y1 + h/2); 
  vertex(x1, y1);
  endShape();
}
