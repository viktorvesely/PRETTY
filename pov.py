import imageio

path = "./maps/"
name = "pov"

def f(extension):
    return path + name + "." + extension

image= imageio.imread(f("jpg"))

with open(f("bw"), "w") as f:
    output = ""
    
    for row in image:
        comma = False
        for pixel in row:
            if comma:
                output += ","
            comma = True
            if (pixel == [0, 0, 0]).all():
                output += "0"
            else:
                output += "-1"
        output += "\n"
    
    f.write(output[:-1])