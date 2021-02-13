public class Vector2 {

    public float x;
    public float y;
    
    public Vector2() { }

    public Vector2(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public Vector2 copy() {
        return new Vector2(this.x, this.y);
    }

    public Vector2(Vector2 v) {
        set(v);
    }

    public void set(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public void set(Vector2 v) {
        this.x = v.x;
        this.y = v.y;
    }

    public void setZero() {
        x = 0;
        y = 0;
    }

    public float[] getComponents() {
        return new float[]{x, y};
    }

    public float getLength() {
        return (float) Math.sqrt(x * x + y * y);
    }

    public float getLengthSq() {
        return (x * x + y * y);
    }

    public float distanceSq(float vx, float vy) {
        vx -= x;
        vy -= y;
        return (vx * vx + vy * vy);
    }

    public float distanceSq(Vector2 v) {
        float vx = v.x - this.x;
        float vy = v.y - this.y;
        return (vx * vx + vy * vy);
    }

    public float distance(float vx, float vy) {
        vx -= x;
        vy -= y;
        return (float) Math.sqrt(vx * vx + vy * vy);
    }

    public float distance(Vector2 v) {
        float vx = v.x - this.x;
        float vy = v.y - this.y;
        return (float) Math.sqrt(vx * vx + vy * vy);
    }

    public float getAngle() {
        return (float) Math.atan2(y, x);
    }

    public void normalize() {
        float magnitude = getLength();
        x /= magnitude;
        y /= magnitude;
    }

    public Vector2 getNormalized() {
        float magnitude = getLength();
        return new Vector2(x / magnitude, y / magnitude);
    }


    public void add(Vector2 v) {
        this.x += v.x;
        this.y += v.y;
    }

    public void add(float vx, float vy) {
        this.x += vx;
        this.y += vy;
    }


    public Vector2 getAdded(Vector2 v) {
        return new Vector2(this.x + v.x, this.y + v.y);
    }

    public void subtract(Vector2 v) {
        this.x -= v.x;
        this.y -= v.y;
    }

    public void subtract(float vx, float vy) {
        this.x -= vx;
        this.y -= vy;
    }

    public Vector2 getSubtracted(Vector2 v) {
        return new Vector2(this.x - v.x, this.y - v.y);
    }

    public void multiply(float scalar) {
        x *= scalar;
        y *= scalar;
    }

    public Vector2 getMultiplied(float scalar) {
        return new Vector2(x * scalar, y * scalar);
    }

    public void multiply(Vector2 v) {
        x *= v.x;
        y *= v.y;
    }

    public void divide(float scalar) {
        x /= scalar;
        y /= scalar;
    }

    public Vector2 getDivided(float scalar) {
        return new Vector2(x / scalar, y / scalar);
    }

    public Vector2 getPerp() {
        return new Vector2(-y, x);
    }

    public float dot(Vector2 v) {
        return (this.x * v.x + this.y * v.y);
    }

    public float dot(float vx, float vy) {
        return (this.x * vx + this.y * vy);
    }


    public float cross(Vector2 v) {
        return (this.x * v.y - this.y * v.x);
    }

    public float cross(float vx, float vy) {
        return (this.x * vy - this.y * vx);
    }

    public float project(Vector2 v) {
        return (this.dot(v) / this.getLength());
    }

    public float project(float vx, float vy) {
        return (this.dot(vx, vy) / this.getLength());
    }


    public Vector2 getProjectedVector(Vector2 v) {
        return this.getNormalized().getMultiplied(this.dot(v) / this.getLength());
    }

    public Vector2 getProjectedVector(float vx, float vy) {
        return this.getNormalized().getMultiplied(this.dot(vx, vy) / this.getLength());
    }



    public void rotateBy(float angle) {
        float cos = (float) Math.cos(angle);
        float sin = (float) Math.sin(angle);
        float rx = x * cos - y * sin;
        y = x * sin + y * cos;
        x = rx;
    }

    public Vector2 getRotatedBy(float angle) {
        float cos = (float) Math.cos(angle);
        float sin = (float) Math.sin(angle);
        return new Vector2(x * cos - y * sin, x * sin + y * cos);
    }

    public void reverse() {
        x = -x;
        y = -y;
    }

    public Vector2 getReversed() {
        return new Vector2(-x, -y);
    }

    @Override
    public Vector2 clone() {
        return new Vector2(x, y);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Vector2) {
            Vector2 v = (Vector2) obj;
            return (x == v.x) && (y == v.y);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Vector2[" + x + ", " + y + "]";
    }
}