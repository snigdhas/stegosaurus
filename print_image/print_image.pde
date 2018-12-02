String message = "";
String filepath = "/home/pi/sketchbook/print_image/encodedmessage2.jpg";
//String filepath = "/home/pi/stegosaurus/encoderFiles/imageGen/encodedmessage.jpg";

void setup() {
  size(400, 400);
  background(255);
  if (args != null && args.length > 0) {
    for (int i = 0; i < args.length; i++) {
      message += args[i] + " ";
    }
  }
  drawMessage();
  print();
}

void drawMessage() {
  textSize(32);
  fill(244, 66, 134);
  text(message, 50, 50, 350, 350);
}

void print() {
  save("encodedmessage.jpg");
  while (true) {
    File f = dataFile(filepath);
    if (f.exists()) {
      try {
        Runtime.getRuntime().exec("lp /home/pi/sketchbook/print_image/encodedmessage.jpg");
        break;
      } catch (IOException e) {
        println(e);
      }
      exit();
    }
  }
}
