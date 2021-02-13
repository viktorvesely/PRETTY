final float R_SMOOTH = 1000.0;

public class Collision {

    private static final float offset = 0;

    Collision() {
    }


    public void phsysicsLines(Stick src, Stick target, Vector2 delta, float length) {
        float dot;

        dot = (float) Math.abs(Math.cos(target.theta - src.theta));
        
        delta.multiply(dot / length);

        target.act(src.pos, delta);

        delta.multiply(-1);

        src.act(target.pos, delta);
    } 

    public void physicsCircle(Particle src, Particle target, Vector2 delta, float length) {
        Vector2 repelentForce;
        float minR;

        minR = (src.r + target.r + offset);

        repelentForce = delta.clone();
        repelentForce.divide(length);
        repelentForce.multiply(R_SMOOTH * minR * (1.0 / (minR + R_SMOOTH) - 1.0 / (length + R_SMOOTH)));
        repelentForce.multiply(1.2);
        
        src.act(target.pos, repelentForce);
        repelentForce.multiply(-1);
        target.act(src.pos, repelentForce);
    }


    

     public void edge(Entity e) {
        float x, y, nx, ny, vx, vy;
        boolean out;

        x = e.pos.x;
        y = e.pos.y;

        nx = x;
        ny = y;
        vx = vy = 1;


        if (x < 0) {
            nx =  0;
            vx = -1;
        }

        if (x > Map.width) {
            nx = Map.width;
            vx = -1;
        }

        if (y < 0) {
            ny = 0;
            vy = -1;
        }

        if (y > Map.height) {
            ny = Map.height;
            vy = -1;
        }

        e.pos.x = nx;
        e.pos.y = ny;

        e.velocity.x *= vx;
        e.velocity.y *= vy;
    }

    private boolean isCircle(Entity ent) {
        return ent.type() == E_TYPE.CIRCLE;
    }



    public void check(List<Entity> ents) {

        Entity src, target;
        Vector2 delta;
        float dLength;
        
        for (int iSrc = ents.size() - 1; iSrc >= 0; iSrc--) {
            
            src = ents.get(iSrc);

            edge(src);
            
            for(int iTarget = iSrc - 1; iTarget >= 0; iTarget--) {
             

                target = ents.get(iTarget);

                delta = src.vectorTo(target);
                dLength = delta.getLength();
                

                if (dLength > target.r + src.r) {
                    continue;
                }
                
                if (isCircle(src)) {
                    physicsCircle((Particle)src, (Particle) target, delta, dLength);
                }

                
            }

        }

    }



}