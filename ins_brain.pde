import java.util.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import java.awt.geom.*;
import java.lang.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.nio.file.*;
import java.nio.charset.*;

List<Entity> entities;
PostFX fx;
VectorField vectorField;
Keyboard keyboard;
Collision collision;

int addEnt(Entity entity) {
  entities.add(entity);
  return entities.size() - 1;
}

void removeEnt(Entity entity) {
  entities.remove(entity);
}

void setup() {
  size(2600, 1500, P2D);
  stroke(255);
  background(0, 0, 0);
  
  //fx = new PostFX(this);

  entities = new ArrayList<Entity>();

  for (int i = 0; i < Config.nParticles; ++i) {
    addEnt(new Particle());
  }

  //vectorField = new VectorField("pov", "pov");
  vectorField = new VectorField();
  //vectorField = new VectorField(Map.dW, Map.dH, "vege");
  keyboard = new Keyboard();
  collision = new Collision();
} 


void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      keyboard.keyReleased((int)'n');
    }
 
    return;
  }


  int code = keyboard.processChar(key);
  keyboard.keyReleased(code);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      keyboard.keyPressed((int)'n');
    }

    return;
  }

  int code = keyboard.processChar(key);
  keyboard.keyPressed(code);
}

int intCheckKey(int keyCode) {
  return keyboard.pressed.contains(keyCode) ? 1 : 0; 
}


boolean checkKey(int keyCode) {
  return keyboard.pressed.contains(keyCode); 
}

void applyVectorField(Entity entity) {
  Vector2 force, origin;

  force = vectorField.f(entity.pos);

  if (force.x != 0 || force.y != 0) {
    entity.velocity.multiply(Config.friction);
  } else {
    entity.velocity.multiply(0.98);
  }

  entity.act(force);
}

boolean g_j = false;
boolean g_e = false;
boolean g_p = false;

boolean g_pause = true;

void update() {

  if (checkKey((int)'j') && !g_j) {

    vectorField.shuffle().nextFrame();

    g_j = true;
  } else if (!checkKey((int)'j')) {
    g_j = false;
  }

  if (checkKey((int)'e') && !g_e) {

    collision.toggleEdge();

    g_e = true;
  } else if (!checkKey((int)'e')) {
    g_e = false;
  }


  for (int i = 0; i < entities.size(); i++) {
    Entity e = entities.get(i);


    applyVectorField(e);
    e.update(entities);
    e.render();

    
  }

  collision.check(entities);
}

void drawMode() {
  vectorField.draw();

  if (mousePressed) {
    Vector2 mouse = new Vector2(mouseX, mouseY);

    if (checkKey((int)'n')) {
      vectorField.removePixel(mouse);
    } else {
      vectorField.setPixel(mouse);
    }
  }

  if (checkKey((int)'s')) {
    vectorField.finishDrawing();
  }
  
}

void draw() {
  background(0, 0, 0);

  if (checkKey((int)'p') && !g_p) {

    g_pause = !g_pause;

    g_p = true;
  } else if (!checkKey((int)'p')) {
    g_p = false;
  }

  if (g_pause) return;

  if (vectorField.drawMode) {
    drawMode();
  }
  else {
    update();
  }

  //fx.render().rgbSplit(250).bloom(0.6, 20, 40).compose();
}
