# The FLOOR IS LAVA when the hours on the clock equals the minutes e.g.
# 01:01, 02:02, 10:10, 22:22, 23:23, 00:00

load("encoding/base64.star", "base64")
load("render.star", "render")
load("time.star", "time")
load("file.star", "file")

LAVA_IMAGE = file.read("lava.gif")
floor_is_text = file.read("text")

def get_minutes_until_floor_is_lava(hour, minute):
    if minute == hour:
        return 0

    if minute < hour:
        return hour - minute

    # minute > hour
    return 60 - minute + (hour + 1) % 24

def main():
    # text_color = "#c7ba06"
    # timezone = config.get("timezone") or "Europe/Stockholm"
    timezone = "Europe/Stockholm"
    now = time.now().in_location(timezone)
    minutes_until_floor_is_lava = get_minutes_until_floor_is_lava(now.hour, now.minute)
    # floor_is_text = "Golvet är lava"

    return render.Root(
        child = render.Stack(
            children = [
                # render.Box(color="#cf1020"),
                render.Image(src = LAVA_IMAGE, width = 64, height = 32),
                render.Column(
                    children = [
                        # Klocka
                        render.Text(content = now.format("15:04"), color = "#ffffff"),
                        render.Box(width = 64, height = 1, color = "#ffffff"),
                        # Golvet är lava
                        render.Text(content = floor_is_text, color = "#03fcb1"),
                        render.Box(width = 64, height = 1, color = "#ffffff"),
                        # Om hur lång tid
                        render.Text(content = "om {} minuter".format(minutes_until_floor_is_lava), color = "#037bfc"),
                    ],
                ),
            ],
        ),
    )
