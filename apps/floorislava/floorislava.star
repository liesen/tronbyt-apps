# The FLOOR IS LAVA when the hours on the clock equals the minutes e.g.
# 01:01, 02:02, 10:10, 22:22, 23:23, 00:00

# The FLOOR IS ICE when the hours on the clock equals the minutes reversed e.g.
# 01:10, 02:20, 10:01, 22:22, 00:00

load("encoding/base64.star", "base64")
load("render.star", "render")
load("time.star", "time")
# load("file.star", "file")

# LAVA_IMAGE = file.read("lava.gif")
# floor_is_text = file.read("text")


def get_minutes_until_floor_is_lava(now):
    if now.minute == now.hour:
        return 0

    if now.minute < now.hour:
        # Next event is today at hour:hour
        return now.hour - now.minute

    # minute > hour
    # Next event is at next hour:next hour
    next_hour = (now.hour + 1) % 24
    return (60 - now.minute) + next_hour


def get_minutes_until_floor_is_ice(now):
    # Returns minutes until next 'floor is ice' event

    # This hour
    m = (now.hour % 10) * 10 + (now.hour // 10)

    if m < 60 and m >= now.minute:
        return m - now.minute

    for i in range(1, 24):
        h = (now.hour + i) % 24
        m = (h % 10) * 10 + (h // 10)

        if m < 60:
            return i * 60 + (m - now.minute)


def main(config):
    timezone = config.get("timezone", "Europe/Stockholm")
    now = time.now().in_location(timezone)
    minutes_until_floor_is_lava = get_minutes_until_floor_is_lava(now)
    minutes_until_floor_is_ice = get_minutes_until_floor_is_ice(now)

    return render.Root(
        child=render.Column(
            children=[
                render.WrappedText(
                    content="Golvet är lava om {} minuter".format(
                        minutes_until_floor_is_lava
                    ),
                    color="#fc5e03",
                ),
                render.Box(width=64, height=1, color="#333333"),
                render.WrappedText(
                    content="Golvet är is om {} minuter".format(
                        minutes_until_floor_is_ice
                    ),
                    color="#03fcb1",
                ),
            ],
        )
    )
