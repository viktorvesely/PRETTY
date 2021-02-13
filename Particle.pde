final float particleOffset = 0.2;

public class Particle extends Entity {
  
    Particle() {
      this(E_TYPE.CIRCLE);
    }

    Particle(E_TYPE type) {
        super(type);
        r = 18; //(int)(Math.random() * 20) + 14;
        red = 255;//Utils.randInt(30, 255);
        green = 255;//Utils.randInt(30, 255);
        blue = 255;//Utils.randInt(30, 255);
    }

    public void act(Vector2 force) {
        velocity.add(force);
    } 

    public void act(Vector2 origin, Vector2 force) {
        velocity.add(force);
    } 

    public void move() {
        pos.add(velocity);
    }

    public void draw() {
        noStroke();
        fill(red, green, blue);
        ellipseMode(CENTER);
        ellipse(pos.x, pos.y, r, r);
    }
  
  
    public void render() {
        draw();
    }


    public void update(List<Entity> entities) {
        move();
    }
}              
