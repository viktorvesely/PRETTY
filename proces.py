import imageio

path = "./maps/"
name = "vnutro"

def f(extension):
    return path + name + "." + extension

image= imageio.imread(f("BMP"), as_gray=True)


with open(f("bw"), "w") as f:
    output = ""
    
    for row in image:
        comma = False
        for pixel in row:
            if comma:
                output += ","
            comma = True
            if pixel == 255:
                output += "-1"
            else:
                output += "0"
        output += "\n"
    
    f.write(output[:-1])