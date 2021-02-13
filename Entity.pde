
public enum E_TYPE {
    LINE, CIRCLE
}

public abstract class Entity {
    private E_TYPE __type;
    
    public Vector2 velocity, pos;
    public float red, green, blue;
    public float r;

    public abstract void render();
    public abstract void update(List<Entity> entities);
    public abstract void act(Vector2 origin, Vector2 force);
    public abstract void act(Vector2 force);
    
    public Entity(E_TYPE type) {
        this.__type = type;

        red = 255;
        green = 255;
        blue = 255;
        r = 0;

        velocity = new Vector2(0, 0);

        float x = (float)Math.random() * Map.width;
        float y = (float)Math.random() * Map.height;
        pos = new Vector2(x, y);
    }

    public Vector2 behind(Vector2 dir) {
        Vector2 vec = dir.copy();
        vec.multiply(-1);
        vec.add(pos);

        return vec;
    }

    public E_TYPE type() {
        return __type;
    }

    public Vector2 vectorTo(Entity entity) {
        Vector2 delta = entity.pos.clone();
        delta.subtract(pos);
        return delta;
    }
}