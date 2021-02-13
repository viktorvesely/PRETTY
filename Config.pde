public static class Map {
  public static final int width = 2600;
  public static final int height = 1500;

  public static final int dW = 100;
  public static final int dH = 70;
}

public static class Utils {
  public static int randInt(int min, int max) {
    return (int) (Math.random() * (max - min)) + min;
  }

  public static int clamp(int value, int min, int max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  public static long now() {
      return System.currentTimeMillis();
  }
}

public static class Config {
  public static final int nParticles = 1400;
  public static final float friction = 0.9;
  public static final float FPS = 60;
  public static final float FPM = FPS / 1000;

}
