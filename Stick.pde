


public class Stick extends Entity {
    public float theta, w, angularVelocity;
  
    Stick() {
        super(E_TYPE.LINE);
        r = (int)(Math.random() * 60) + 40;
        w = 2;
        theta = (float)(Math.random() * 2 * Math.PI - Math.PI);
        angularVelocity = 0;
    }

    protected Vector2[] ends() {
        Vector2 [] points = new Vector2[2];
        float x, y;

        x = (float)Math.cos(theta) * r;
        y = (float)Math.sin(theta) * r;

        points[0] = new Vector2(pos.x + x, pos.y + y);
        points[1] = new Vector2(pos.x - x, pos.y - y);

        return points;
    }

    protected Vector2 rotationVector() {
        float x, y;

        x = (float)Math.cos(theta);
        y = (float)Math.sin(theta);

        return new Vector2(x, y);
    }

    public void act(Vector2 force) {
        Vector2 origin;
        origin = behind(force);
        act(origin, force);
    }

    public void act(Vector2 origin, Vector2 force) {
        Vector2 rotation, delta;
        float dl, dot;
        
        rotation = rotationVector();

        delta = origin.copy();
        delta.subtract(pos);
        dl = delta.getLength();
        if (dl == 0) {
            return;
        }
        delta.multiply(1 / dl);

        dot = rotation.dot(delta);
        angularVelocity += dot * force.getLength() * 0.01;

        velocity.add(force);
    } 

    public void move() {
        velocity.multiply(Config.friction);
        angularVelocity *= Config.friction;

        float PI = (float)Math.PI;

        pos.add(velocity);
        theta += angularVelocity;
    }
  
  
    public void render() {
        Vector2[] points;

        points = ends();

        strokeWeight(w);
        stroke(red, green, blue);
        line(points[0].x, points[0].y, points[1].x, points[1].y);

    }

    public void update(List<Entity> entities) {

         move();
        
    }
}
