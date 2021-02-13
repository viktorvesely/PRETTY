public class Frame  {
    
    private static final float shuffleStrength = 5;

    private Vector2[][] field;
    private int _w;
    private int _h;
    public Vector2 transform;
    private boolean _shuffle = false;
    

    Frame(int width, int height) {
        _w = width;
        _h = height;
        field = new Vector2[_h][_w];
        init();
    }

    Frame(Vector2[][] field) {
        this.field = field;
        _h = field.length;
        _w = field[0].length;
        init();
    }

    Frame(String name) {
        load(name);
        init();
    }

    private void init() {
        transform = new Vector2((float)_w / (float)Map.width, (float)_h / (float)Map.height);
    }

    public boolean isShuffle() {
        return _shuffle;
    }

    public Frame shuffle() {
        float mx, my, dx, dy;

        mx = (float)_w / 2.0;
        my = (float)_h / 2.0;

        for (int y = 0; y < _h; y++) {
            for (int x = 0; x < _w; x++) {
                
                dx = mx - (float)x;
                dy = my - (float)y;

                float angle = (float)Math.atan2(dy, dx);

                set(x, y, new Vector2(
                    (float)Math.cos(angle) * shuffleStrength,
                    (float)Math.sin(angle) * shuffleStrength
                ));
            }
        }

        _shuffle = true;

        return this;
    }

    public int[] getCoords(Vector2 pos) {
        Vector2 tPos;
        tPos = transform.clone();
        tPos.multiply(pos);

        int y = (int)Math.floor(tPos.y);
        int x = (int)Math.floor(tPos.x);

        x = Utils.clamp(x, 0, _w - 1);
        y = Utils.clamp(y, 0, _h - 1);

        int[] coords = new int[2];
        coords[0] = x;
        coords[1] = y;

        return coords;
    }

    public Vector2 get(Vector2 screenPos) {
        int[] coords = getCoords(screenPos);
        
        return field[
            coords[1]
        ][
            coords[0]
        ].clone();
    }

    public Vector2 get(int x, int y) {
        return field[y][x].clone();
    }

    public int w() {
        return _w;
    }

    public int h() {
        return _h;
    }

    public void set(int x, int y, Vector2 force) {
        field[y][x] = force;
    }

    public boolean ok() {
        return field != null;
    }

    private String generateHead() {
        return Integer.toString(_w) + "," + Integer.toString(_h);
    }

    public void save(String name) {
        List<String> output = new ArrayList<String>();

        output.add(generateHead());
        for (int y = 0; y < _h; y++) {
            String temp = "";
            for (int x = 0; x < _w; x++) {
                if (x > 0) {
                    temp += ",";
                }
                temp += Float.toString(field[y][x].x) + "|" + Float.toString(field[y][x].y);
            }
            output.add(temp); 
        }

        Path file = Paths.get("C:/Users/weseli/Documents/ins_brain/frames/" + name + ".vf");
        try {
            Files.write(file, output, StandardCharsets.UTF_8);
        } catch (IOException e) {
            System.out.println("Pice error");
        }
    }

    public void load(String name) {
        try {
            File file = new File("C:/Users/weseli/Documents/ins_brain/frames/" + name + ".vf");
            Scanner scanner = new Scanner(file);
            String row = "";
            int lines = 0;
            String[] head;
            
            head = scanner.nextLine().split(",");
            _w = Integer.parseInt(head[0]);
            _h = Integer.parseInt(head[1]);

            field = new Vector2[_h][_w];
            
            while (scanner.hasNextLine()) {
                row = scanner.nextLine();
                String[] args = row.split(",");

                for (int x = 0; x < args.length; x++) {
                    String[] coords = args[x].split("\\|");
                    float vx, vy;

                    vx = Float.parseFloat(coords[0]);
                    vy = Float.parseFloat(coords[1]);

                    field[lines][x] =  new Vector2(vx, vy);
                }
                lines++;
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            System.out.println("No frame");
        }
    }
}