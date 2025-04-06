import base64

im = "lava.gif"

with open(im, "rb") as f:
    buf = f.read()
    print(base64.b64encode(buf).decode())