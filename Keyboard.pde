public class Keyboard  {

    public final Set<Integer> pressed = new HashSet<Integer>();

    public void keyPressed(int e) {
        pressed.add(e);
    }

    public int processChar(char e) {
        e = Character.toLowerCase(e);
        return (int)e;
    }

    // pressed.contains(KeyEvent.VK_UP)

    public void keyReleased(int e) {
        pressed.remove(e);
    }
}