import oscP5.*;
import netP5.*;
import processing.data.Table;
import processing.data.TableRow;

OscP5 oscP5;
NetAddress pd;
Table data;
int current = 0;
boolean flash = false;
int lastFlash = 0;

void setup() {
  size(900, 600);
  frameRate(30);
  textAlign(CENTER);
  textSize(20);

  data = loadTable("dataset.csv", "header");

  oscP5 = new OscP5(this, 12000);
  pd = new NetAddress("127.0.0.1", 8000);
}

void draw() {
  TableRow row = data.getRow(current);

  String phase = row.getString("Round");
  String venue = row.getString("Venue");
  String result = row.getString("Result");
  float gf = row.getFloat("Goals For");
  float ga = row.getFloat("Goals Against");
  String rival = row.getString("Opponent");

  if (rival.matches("^[a-z]{2}\\s.*")) {
    rival = rival.substring(3);
  }

  if (venue.equalsIgnoreCase("Home")) background(0, 0, 150);
  else background(150, 0, 0);

  int phaseLevel = getPhaseLevel(phase);
  int flashInterval = int(map(phaseLevel, 1, 5, 1000, 200));

  if (millis() - lastFlash > flashInterval) {
    flash = !flash;
    lastFlash = millis();
    sendToPD(phaseLevel, gf, ga);
  }

  if (flash) {
    pushMatrix();
    translate(width/2, height/2);

    float size = map(gf, 0, 5, 60, 220);
    float thickness = map(ga, 0, 5, 2, 10);

    stroke(255);
    strokeWeight(thickness);
    fill(255, 255, 0);

    if (result.equals("W")) drawArrow(1, size);
    else if (result.equals("L")) drawArrow(-1, size);
    else drawArrow(0, size);

    popMatrix();
  }

  fill(255);
  text("Phase: " + phase, width/2, 50);
  text("Opponent: " + rival, width/2, height - 80);
  text("Score: " + int(gf) + " - " + int(ga) + " (" + result + ")", width/2, height - 50);

  fill(200);
  text("Click to advance (" + (current+1) + "/" + data.getRowCount() + ")", width/2, height - 20);
}

void drawArrow(float direction, float s) {
  pushMatrix();
  if (direction == -1) rotate(PI);
  else if (direction == 0) rotate(HALF_PI);

  beginShape();
  vertex(-s/2, s/2);
  vertex(s/2, s/2);
  vertex(0, -s/2);
  endShape(CLOSE);

  popMatrix();
}

void sendToPD(int phase, float gf, float ga) {
  int resultCode = 2;
  String result = data.getRow(current).getString("Result");
  if (result.equals("W")) resultCode = 1;
  else if (result.equals("L")) resultCode = 3;
  
  // Simple UDP message instead of OSC
  String msg = phase + " " + gf + " " + ga + " " + resultCode + "\n";
  byte[] data = msg.getBytes();
  
  // Create a simple UDP packet
  try {
    java.net.DatagramSocket socket = new java.net.DatagramSocket();
    java.net.DatagramPacket packet = new java.net.DatagramPacket(
      data, data.length, 
      java.net.InetAddress.getByName("127.0.0.1"), 
      8001
    );
    socket.send(packet);
    socket.close();
  } catch (Exception e) {
    println("Error sending: " + e);
  }
  
  println("Sent: " + msg);
}

int getPhaseLevel(String phase) {
  if (phase.toLowerCase().contains("league")) return 1;
  if (phase.toLowerCase().contains("round")) return 2;
  if (phase.toLowerCase().contains("quarter")) return 3;
  if (phase.toLowerCase().contains("semi")) return 4;
  if (phase.toLowerCase().equals("final")) return 5;
  return 1;
}

void mousePressed() {
  current = (current + 1) % data.getRowCount();
}
