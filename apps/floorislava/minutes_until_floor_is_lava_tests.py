from dataclasses import dataclass

import pytest


@dataclass(frozen=True)
class Time:
    hour: int
    minute: int


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


@pytest.mark.parametrize(
    "now, expected",
    [
        (Time(0, 0), 0),
        (Time(0, 1), 60),
        (Time(1, 0), 1),
        (Time(1, 1), 0),
        (Time(1, 2), 60),
        (Time(23, 23), 0),
        (Time(23, 24), 36),
        (Time(23, 25), 35),
    ],
)
def test_minutes_until_floor_is_lava(now, expected):
    assert get_minutes_until_floor_is_lava(now) == expected


@pytest.mark.parametrize(
    "now, expected",
    [
        (Time(0, 0), 0),
        (Time(0, 1), 69),  # 00:01 -> 01:10
        (Time(1, 0), 10),
        (Time(1, 1), 9),
        (Time(1, 2), 8),
        (Time(23, 23), 32 - 23),
        (Time(23, 24), 32 - 24),
        (Time(23, 25), 32 - 25),
    ],
)
def test_minutes_until_floor_is_ice(now, expected):
    assert get_minutes_until_floor_is_ice(now) == expected
