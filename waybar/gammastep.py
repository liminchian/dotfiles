#! /usr/bin/python3
import json
import logging
import os
import sys
from configparser import ConfigParser
from datetime import datetime, timezone
from subprocess import PIPE, call

import requests

logger = logging.getLogger(__name__)


def load_gammastep_config(is_day: bool) -> int:
    logger.info("取得初始設定")
    path = os.path.realpath("/home/larvasei/.config/gammastep/gammastep.conf")
    config = ConfigParser()
    config.read(path)
    daytemp = 5700
    nighttemp = 3500
    if "temp-day" in config["general"] and "temp-night" in config["general"]:
        daytemp = config["general"]["temp-day"]
        nighttemp = config["general"]["temp-night"]
    if is_day:
        return int(daytemp)
    return int(nighttemp)


def open_weather(city_name: str) -> dict:
    logger.info("取得日出與日落時間")
    output = {}
    output["text"] = ""
    api_key = "a074932e3b8507ff7b3024bdb2bcc9a6"
    url = (
        f"https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={api_key}"
    )
    with requests.Session() as rs:
        res = rs.get(url)
        if not res.status_code == 200:
            logger.error(f"{res.text}")
        data = json.loads(res.text)
        rs.close()
    sunrise = datetime.fromtimestamp(data["sys"]["sunrise"], timezone.utc)
    sunset = datetime.fromtimestamp(data["sys"]["sunset"], timezone.utc)
    is_day = (
        datetime.now(tz=timezone.utc) >= sunrise
        and datetime.now(tz=timezone.utc) < sunset
    )
    if is_day:
        output["text"] = ""
    output["tooltip"] = f"TEMP: {load_gammastep_config(is_day)}K"
    return output


def is_active(app_name: str) -> bool:
    logger.info(f"確認{app_name}是否正在執行")
    pid = call(["pgrep", "-f", app_name], stdout=PIPE)
    return pid != 1


def write_output(app_name: str, city_name: str):
    logger.info("回傳waybar json格式字串")
    output = {
        "text": "",
        "tooltip": "",
        "class": f"custom-{app_name}",
        "alt": app_name,
    }
    if is_active(app_name):
        output.update(open_weather(city_name))
    sys.stdout.write(json.dumps(output) + "\n")
    sys.stdout.flush()


def main():
    write_output("gammastep", "Taipei")


if __name__ == "__main__":
    main()
