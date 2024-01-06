#!/usr/bin/python
from argparse import ArgumentParser
from dataclasses import dataclass, field
from os import environ
from pathlib import Path

import requests


@dataclass
class Cache:
    dir: str = f"{environ['HOME']}/.cache/eww/weather"
    weather_degree: str = field(default="weather-degree")
    weather_quote: str = field(default="weather-quote")
    weather_hex: str = field(default="weather-hex")
    weather_icon: str = field(default="weather-icon")

    def __post_init__(self):
        dir = Path(self.dir).absolute()
        if not dir.exists():
            dir.mkdir()
        self.weather_degree = f"{self.dir}/{self.weather_degree}"
        self.weather_quote = f"{self.dir}/{self.weather_quote}"
        self.weather_hex = f"{self.dir}/{self.weather_hex}"
        self.weather_icon = f"{self.dir}/{self.weather_icon}"

    def write_from_info(self):
        def write_text(path_str: str, content: str):
            Path(path_str).write_text(content)

        info = get_weather_data()
        write_text(self.weather_icon, info.icon)
        write_text(self.weather_quote, info._quote)
        write_text(self.weather_degree, f"{info.temp}°C")
        write_text(self.weather_hex, info._hex)

    def get_data(self):
        print(get_weather_data())
        exit(0)

    def icon(self):
        print(Path(self.weather_icon).read_text())
        exit(0)

    def temp(self):
        print(Path(self.weather_degree).read_text())
        exit(0)

    def hex(self):
        print(Path(self.weather_hex).read_text())
        exit(0)

    def quote(self):
        print(Path(self.weather_quote).open("r").readlines()[0])
        exit(0)

    def quote_tail(self):
        print(Path(self.weather_quote).open("r").readlines()[-1])
        exit(0)


@dataclass
class Config:
    key: str = "a074932e3b8507ff7b3024bdb2bcc9a6"
    id: int = 5128581
    unit: str = "metric"
    lat: float = 25.0478
    lon: float = 121.5319


@dataclass
class WeatherInfo:
    temp: float
    icon: str = field(default=" ")
    _mapping: dict = field(
        default_factory=dict,
        init=False,
    )
    _hex: str = field(default="#adadff", init=False)
    _quote: str = field(
        default="Ah well, no weather huh? \nEven if there's no weather, it's gonna be a great day!",
        init=False,
    )

    def __post_init__(self):
        self._mapping = {
            "50n": (
                " ",
                "#84afdb",
                "Forecast says it's misty \nMake sure you don't get lost on your way...",
            ),
            "50d": (
                " ",
                "#84afdb",
                "Forecast says it's a misty night \nDon't go anywhere tonight or you might get lost...",
            ),
            "01d": (
                " ",
                "#ffd86b",
                "It's a sunny day, gonna be fun! \nDon't go wandering all by yourself though...",
            ),
            "01n": (
                " ",
                "#fcdcf6",
                "It's a clear night \nYou might want to take a evening stroll to relax...",
            ),
            "02d": (
                " ",
                "#adadff",
                "It's  cloudy, sort of gloomy \nYou'd better get a book to read...",
            ),
            "02d": (
                " ",
                "#adadff",
                "It's a cloudy night \nHow about some hot chocolate and a warm bed?",
            ),
            "03d": (
                " ",
                "#adadff",
                "It's  cloudy, sort of gloomy \nYou'd better get a book to read...",
            ),
            "03n": (
                " ",
                "#adadff",
                "It's a cloudy night \nHow about some hot chocolate and a warm bed?",
            ),
            "04d": (
                " ",
                "#adadff",
                "It's  cloudy, sort of gloomy \nYou'd better get a book to read...",
            ),
            "04n": (
                " ",
                "#adadff",
                "It's a cloudy night \nHow about some hot chocolate and a warm bed?",
            ),
            "09d": (
                " ",
                "#6b95ff",
                "It's rainy, it's a great day! \nGet some ramen and watch as the rain falls...",
            ),
            "09n": (
                " ",
                "#6b95ff",
                "It's gonna rain tonight it seems \nMake sure your clothes aren't still outside...",
            ),
            "10d": (
                " ",
                "#6b95ff",
                "It's rainy, it's a great day! \nGet some ramen and watch as the rain falls...",
            ),
            "10n": (
                " ",
                "#6b95ff",
                "It's gonna rain tonight it seems \nMake sure your clothes aren't still outside...",
            ),
            "11d": (
                "",
                "#ffeb57",
                "There's storm for forecast today \nMake sure you don't get blown away...",
            ),
            "11n": (
                "",
                "#ffeb57",
                "There's gonna be storms tonight \nMake sure you're warm in bed and the windows are shut...",
            ),
            "13d": (
                " ",
                "#e3e6fc",
                "It's gonna snow today \nYou'd better wear thick clothes and make a snowman as well!",
            ),
            "13n": (
                " ",
                "#e3e6fc",
                "It's gonna snow tonight \nMake sure you get up early tomorrow to see the sights...",
            ),
            "40d": (
                " ",
                "#84afdb",
                "Forecast says it's misty \nMake sure you don't get lost on your way...",
            ),
            "40n": (
                " ",
                "#84afdb",
                "Forecast says it's a misty night \nDon't go anywhere tonight or you might get lost...",
            ),
        }
        if self.icon in self._mapping.keys():
            (self.icon, self._hex, self._quote) = self._mapping[self.icon]


def get_weather_data() -> "WeatherInfo":
    result = requests.get(
        f"http://api.openweathermap.org/data/2.5/weather?APPID={Config.key}&lat={Config.lat}&lon={Config.lon}&unit={Config.unit}"
    ).json()
    return WeatherInfo(temp=result["main"]["temp"], icon=result["weather"])


if __name__ == "__main__":
    weather_cache = Cache()
    weather_cache.write_from_info()
    parser = ArgumentParser()
    parser.add_argument("--get-data", action="store_true")
    parser.add_argument("--icon", action="store_true")
    parser.add_argument("--temp", action="store_true")
    parser.add_argument("--hex", action="store_true")
    parser.add_argument("--quote", action="store_true")
    parser.add_argument("--quote-tail", action="store_true")

    args = parser.parse_args()
    if args.get_data:
        weather_cache.get_data()
    if args.icon:
        weather_cache.icon()
    if args.temp:
        weather_cache.temp()
    if args.hex:
        weather_cache.hex()
    if args.quote:
        weather_cache.quote()
    if args.quote_tail:
        weather_cache.quote_tail()
